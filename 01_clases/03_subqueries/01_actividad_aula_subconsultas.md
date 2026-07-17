# Subconsultas en SQL

**Base de Datos II — SIS-0126**
Docente: Orlando Isaac Aguilera Zambrana · UPDS Tarija

---

## ¿Para qué sirven las subconsultas?

Una subconsulta es una consulta SQL escrita dentro de otra consulta. Se utiliza cuando para responder una pregunta primero se necesita el resultado de otra pregunta.

Por ejemplo: _"¿Qué productos cuestan más que el promedio?"_ — para responder eso, primero hay que calcular cuánto es el promedio. Ese cálculo previo es la subconsulta.

En términos prácticos sirven para:

- Comparar filas contra un valor calculado dinámicamente (promedio, máximo, mínimo).
- Filtrar registros según si pertenecen o no a un conjunto calculado.
- Construir resultados intermedios sobre los que luego se opera.
- Realizar cálculos que dependen de cada fila del resultado principal.

---

## Tipos de subconsultas y cuándo usarlas

### 1. Escalar

Devuelve un único valor (una fila, una columna). Se usa cuando se necesita un número de referencia para comparar o mostrar junto a cada fila.

**Cuándo usarla:** cuando el cálculo produce un solo resultado, como un promedio general, un máximo global o un conteo total.

**Dónde puede ir:** en el `SELECT`, en el `WHERE` o en el `HAVING`.

```sql
-- ¿Cuántos empleados tiene la empresa en total?
-- Mostrar cada departamento junto al total general de empleados.
SELECT
    d.name AS departamento,
    COUNT(e.businessentityid) AS empleados_depto,
    (SELECT COUNT(*) FROM humanresources.employee) AS total_empresa
FROM humanresources.department d
INNER JOIN humanresources.employeedepartmenthistory edh
    ON d.departmentid = edh.departmentid
INNER JOIN humanresources.employee e
    ON edh.businessentityid = e.businessentityid
WHERE edh.enddate IS NULL
GROUP BY d.name
ORDER BY d.name;
```

La subconsulta `SELECT COUNT(*) FROM humanresources.employee` devuelve un único número que se repite en cada fila como referencia.

---

### 2. De lista — IN / NOT IN

Devuelve una columna con varios valores. Se usa cuando se quiere saber si un valor pertenece o no a un conjunto calculado dinámicamente.

**Cuándo usarla:** cuando el filtro depende de los valores que existen en otra tabla o resultado.

**Dónde puede ir:** en el `WHERE` con `IN` o `NOT IN`.

```sql
-- ¿Qué proveedores han tenido al menos una orden de compra?
SELECT v.name AS proveedor
FROM purchasing.vendor v
WHERE v.businessentityid IN (
    SELECT vendorid
    FROM purchasing.purchaseorderheader
);
```

La subconsulta devuelve la lista de IDs de proveedores que tienen órdenes. `IN` filtra solo los que aparecen en esa lista.

---

### 3. De tabla — FROM

Devuelve un conjunto de filas y columnas que actúa como una tabla temporal. Se usa cuando primero se necesita agregar datos y luego operar sobre ese resultado.

**Cuándo usarla:** cuando se necesita filtrar o unir sobre un resultado ya agregado (totales, conteos, promedios por grupo).

**Dónde puede ir:** en el `FROM`. Siempre debe llevar un alias.

```sql
-- ¿Qué territorios de venta superaron las 100 órdenes?
SELECT territorio.territoryid, territorio.total_ordenes
FROM (
    SELECT territoryid, COUNT(*) AS total_ordenes
    FROM sales.salesorderheader
    GROUP BY territoryid
) AS territorio
WHERE territorio.total_ordenes > 100
ORDER BY territorio.total_ordenes DESC;
```

La subconsulta construye una tabla con el conteo de órdenes por territorio. La consulta externa filtra sobre ese resultado ya calculado.

---

### 4. Correlacionada

Hace referencia a una columna de la consulta externa, por lo que se re-evalúa por cada fila del resultado principal. Se usa cuando el cálculo debe cambiar dependiendo de la fila que se está procesando.

**Cuándo usarla:** cuando el valor a calcular depende del contexto de cada fila.

**Dónde puede ir:** en el `SELECT` o en el `WHERE`.

```sql
-- ¿Cuántas líneas de detalle tiene cada orden de compra?
SELECT
    poh.purchaseorderid,
    poh.orderdate,
    (SELECT COUNT(*)
     FROM purchasing.purchaseorderdetail pod
     WHERE pod.purchaseorderid = poh.purchaseorderid) AS total_lineas
FROM purchasing.purchaseorderheader poh
ORDER BY total_lineas DESC
LIMIT 10;
```

La subconsulta menciona `poh.purchaseorderid`, que pertenece a la consulta externa. Por eso se re-evalúa para cada orden: el conteo cambia fila por fila.

---

## ¿Qué tener en cuenta al escribirlas?

**1. La subconsulta escalar debe devolver exactamente un valor.**
Si devuelve más de una fila, PostgreSQL lanza un error. Garantizalo usando una función de agregación (`AVG`, `MAX`, `COUNT`) o `LIMIT 1`.

**2. Cuidado con `NOT IN` y los valores nulos.**
Si la subconsulta puede devolver `NULL`, toda la comparación `NOT IN` resulta vacía. Siempre filtrá con `WHERE columna IS NOT NULL` dentro de la subconsulta.

```sql
-- Forma incorrecta (puede devolver NULL y vaciar el resultado)
WHERE vendorid NOT IN (SELECT vendorid FROM purchasing.purchaseorderheader)

-- Forma correcta
WHERE vendorid NOT IN (
    SELECT vendorid FROM purchasing.purchaseorderheader
    WHERE vendorid IS NOT NULL
)
```

**3. La subconsulta de tabla siempre necesita un alias.**
PostgreSQL no permite referenciar una subconsulta en el `FROM` sin nombre.

```sql
-- Error: falta el alias
FROM (SELECT territoryid, COUNT(*) FROM sales.salesorderheader GROUP BY territoryid)

-- Correcto
FROM (SELECT territoryid, COUNT(*) AS total FROM sales.salesorderheader GROUP BY territoryid) AS territorio
```

**4. La subconsulta correlacionada se ejecuta una vez por fila.**
Es la más poderosa pero también la más costosa en rendimiento. Para conjuntos grandes de datos conviene evaluar si `EXISTS` o un `JOIN` resuelven lo mismo de forma más eficiente (tema del Día 9).

**5. Para identificar si una subconsulta es correlacionada**, buscá si dentro de ella se menciona una tabla o alias de la consulta externa. Si lo hace, es correlacionada; si no, es independiente.

---

## Guía rápida de decisión

| Pregunta                                         | Tipo de subconsulta |
| ------------------------------------------------ | ------------------- |
| ¿Necesito un número de referencia?               | Escalar             |
| ¿Necesito saber si un valor está en un conjunto? | De lista — `IN`     |
| ¿Necesito excluir los que están en un conjunto?  | De lista — `NOT IN` |
| ¿Necesito una tabla con totales o agrupaciones?  | De tabla — `FROM`   |
| ¿El cálculo cambia según la fila actual?         | Correlacionada      |

---

## Ejercicios

---

**Ejercicio 1**

A partir de ese mismo promedio, se requiere identificar los productos considerados por encima de la media. Obtén únicamente los productos cuyo precio de lista supere el precio promedio general del catálogo, ordenados del más caro al más económico.

```sql

```

---

**Ejercicio 2**

El área comercial necesita evaluar qué productos están por encima o por debajo del precio promedio del catálogo. Obtén el nombre, el precio de lista, el promedio general, la diferencia entre ambos y una clasificación que indique si el producto es "Superior" o "Menor" respecto al promedio. Considera únicamente productos con precio de lista mayor a cero, ordenados por la diferencia de mayor a menor.

```sql

```

---

**Ejercicio 3**

El equipo de marketing necesita depurar su base de contactos. Obtén el nombre completo de las personas que tienen al menos una dirección de correo electrónico registrada en el sistema.

```sql

```

---

**Ejercicio 4**

El área de inventario necesita identificar los productos que nunca han generado una venta para evaluar el stock inmovilizado. Obtén los productos que no aparecen en ningún detalle de venta, mostrando su nombre y la cantidad total disponible en inventario, ordenados de mayor a menor stock.

```sql

```

---

**Ejercicio 5**

La gerencia solicita un resumen del volumen de compra por cliente. Obtén el nombre completo de cada cliente junto al total gastado sumando el monto de todas sus órdenes, ordenados de mayor a menor.

```sql

```

---

**Ejercicio 6**

Se requiere medir el nivel de actividad de cada cliente dentro de la plataforma. Para cada cliente, obtén la cantidad de órdenes que ha realizado y lista los 20 clientes más activos.

```sql

```
