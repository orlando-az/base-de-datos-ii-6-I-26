# Radiografía del esquema y ejercicios multitabla — AdventureWorks (PostgreSQL)

Bloque 2 — Consultas y Manipulación de Datos
Esquemas: production, sales, person, humanresources, purchasing

---

## Radiografía del esquema

Consultas de demostración sobre el catálogo de PostgreSQL (`pg_stat_user_tables`, `information_schema`) para mostrar la estructura, las claves y las relaciones de los cinco esquemas del curso antes de empezar a resolver ejercicios.

### 1. Volumen de datos por tabla

Muestra la cantidad aproximada de filas de cada tabla en los esquemas production, sales, person, humanresources y purchasing, para dimensionar el volumen de datos del modelo.

**Nota:** `n_live_tup` se actualiza con ANALYZE/autovacuum. Si la base fue importada recién y los valores están en 0, ejecutar `ANALYZE;` primero.

```sql
SELECT
    schemaname AS esquema,
    relname AS tabla,
    n_live_tup AS filas_aproximadas
FROM pg_stat_user_tables
WHERE schemaname IN ('production', 'sales', 'person', 'humanresources', 'purchasing')
ORDER BY esquema, filas_aproximadas DESC;
```

### 2. Estructura de una tabla

Muestra las columnas de sales.salesorderheader con su tipo de dato, si permite nulos y su posición dentro de la tabla. El mismo patrón sirve para inspeccionar production.product o humanresources.employee.

```sql
SELECT
    column_name AS columna,
    data_type AS tipo_dato,
    is_nullable AS es_nulable,
    ordinal_position AS posicion
FROM information_schema.columns
WHERE table_schema = 'sales'
  AND table_name = 'salesorderheader'
ORDER BY ordinal_position;
```

### 3. Claves primarias en todos los esquemas

Muestra las claves primarias definidas en los cinco esquemas del curso, indicando en qué tabla y columna está cada una.

```sql
SELECT
    tc.table_schema AS esquema,
    tc.table_name AS tabla,
    kcu.column_name AS columna_clave
FROM information_schema.table_constraints tc
INNER JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema IN ('production', 'sales', 'person', 'humanresources', 'purchasing')
ORDER BY esquema, tabla;
```

### 4. Claves foráneas de una tabla puntual

Muestra las claves foráneas de sales.salesorderheader: qué columna apunta a qué tabla y columna referenciada.

```sql
SELECT
    tc.table_schema || '.' || tc.table_name AS tabla_origen,
    kcu.column_name AS columna_origen,
    ccu.table_schema || '.' || ccu.table_name AS tabla_referenciada,
    ccu.column_name AS columna_referenciada
FROM information_schema.table_constraints tc
INNER JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
INNER JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'sales'
  AND tc.table_name = 'salesorderheader'
ORDER BY tabla_origen;
```

### 5. Mapa completo de relaciones de un esquema

Muestra todas las relaciones (FK) dentro del esquema production, sin limitarse a una tabla en particular, para tener el mapa completo de ese dominio. El mismo patrón sirve para recorrer sales y purchasing.

```sql
SELECT
    tc.table_schema || '.' || tc.table_name AS tabla_origen,
    kcu.column_name AS columna_origen,
    ccu.table_schema || '.' || ccu.table_name AS tabla_referenciada,
    ccu.column_name AS columna_referenciada
FROM information_schema.table_constraints tc
INNER JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
INNER JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'production'
ORDER BY tabla_origen;
```

### 6. Relaciones que cruzan esquemas

Muestra las FK cuyo esquema de origen es distinto del esquema referenciado: los puntos exactos donde un dominio de negocio se conecta con otro.

```sql
SELECT
    tc.table_schema AS esquema_origen,
    tc.table_name || '.' || kcu.column_name AS columna_origen,
    ccu.table_schema AS esquema_referenciado,
    ccu.table_name || '.' || ccu.column_name AS columna_referenciada
FROM information_schema.table_constraints tc
INNER JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
INNER JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema <> ccu.table_schema
ORDER BY esquema_origen, esquema_referenciado;
```

### 7. Tablas más referenciadas

Muestra cuántas tablas distintas apuntan, mediante FK, a cada tabla del modelo, para identificar las tablas centrales que van a repetirse en casi todos los JOINs.

```sql
SELECT
    ccu.table_schema || '.' || ccu.table_name AS tabla_referenciada,
    COUNT(DISTINCT tc.table_schema || '.' || tc.table_name) AS tablas_que_la_referencian
FROM information_schema.table_constraints tc
INNER JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
INNER JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
GROUP BY tabla_referenciada
ORDER BY tablas_que_la_referencian DESC
LIMIT 15;
```

### 8. Tablas catálogo (sin FK propias)

Muestra las tablas que tienen clave primaria pero no tienen ninguna FK saliente: son tablas catálogo o de dominio, y suelen ser un buen punto de partida para entender un esquema nuevo.

```sql
SELECT DISTINCT
    tc.table_schema AS esquema,
    tc.table_name AS tabla
FROM information_schema.table_constraints tc
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema IN ('production', 'sales', 'person', 'humanresources', 'purchasing')
  AND NOT EXISTS (
      SELECT 1
      FROM information_schema.table_constraints tc2
      WHERE tc2.constraint_type = 'FOREIGN KEY'
        AND tc2.table_schema = tc.table_schema
        AND tc2.table_name = tc.table_name
  )
ORDER BY esquema, tabla;
```

---

## Progresión de ejercicios multitabla

### Ejercicio 1 — Personal técnico reciente

**Orden:** RR.HH. necesita una lista rápida de personal técnico. Mostrar nombre completo, puesto y fecha de contratación de los empleados contratados después del 1 de enero de 2011, cuyo puesto contenga "Engineer" o "Manager".

**Tablas:** humanresources.employee, person.person

```sql
-- Escribir consulta aquí
```

### Ejercicio 2 — Proveedores de riesgo

**Orden:** Compras necesita ubicar proveedores de riesgo. Mostrar razón social, calificación de crédito y si son preferidos, para proveedores activos con calificación 3 o peor, o que no sean preferidos.

**Tablas:** purchasing.vendor, purchasing.productvendor

```sql
-- Escribir consulta aquí
```

### Ejercicio 3 — Catálogo por categoría

**Orden:** Producción quiere revisar el catálogo por categoría. Mostrar producto, subcategoría, categoría y precio de lista, para productos de categoría "Bikes" o "Components" con precio mayor a 500.

**Tablas:** production.product, production.productsubcategory, production.productcategory

```sql
-- Escribir consulta aquí
```

### Ejercicio 4 — Pedidos grandes por territorio

**Orden:** Ventas necesita identificar pedidos grandes de clientes particulares. Mostrar nombre completo del cliente, número de orden y monto total, para pedidos con totaldue mayor a 5000 realizados en el territorio "Northwest" o "Southwest".

**Tablas:** sales.salesorderheader, sales.customer, person.person, sales.salesterritory

```sql
-- Escribir consulta aquí
```

### Ejercicio 5 — Gasto por proveedor y producto

**Orden:** Compras quiere saber qué proveedores concentran el gasto en un producto puntual. Mostrar proveedor, producto y monto total comprado, agrupando por ambos, y quedándose solo con combinaciones donde el total comprado supere 10000 y haya más de 3 órdenes.

**Tablas:** purchasing.purchaseorderheader, purchasing.vendor, purchasing.purchaseorderdetail, production.product

```sql
-- Escribir consulta aquí
```

### Ejercicio 6 — Cumplimiento de órdenes de trabajo por categoría

**Orden:** Producción quiere medir cumplimiento por categoría. Mostrar categoría, cantidad total de órdenes de trabajo y cantidad de órdenes retrasadas (enddate > duedate), considerando solo órdenes con startdate en 2013, y mostrando únicamente categorías con más de 50 órdenes de trabajo en total.

**Tablas:** production.workorder, production.product, production.productsubcategory, production.productcategory

```sql
-- Escribir consulta aquí
```

### Ejercicio 7 — Desempeño de vendedores por departamento

**Orden:** Gerencia comercial quiere ver el desempeño de cada vendedor junto a su ubicación organizacional. Mostrar nombre completo del vendedor, departamento actual (asignación vigente) y total vendido en 2013, filtrando vendedores con más de 20 órdenes en ese año.

**Tablas:** sales.salesperson, person.person, humanresources.employeedepartmenthistory, humanresources.department, sales.salesorderheader

```sql
-- Escribir consulta aquí
```

### Ejercicio 8 — Inventario cruzado con proveedores

**Orden:** Logística quiere cruzar inventario con proveedores. Mostrar producto, ubicación de almacenamiento, cantidad en inventario y proveedor preferido para ese producto, filtrando solo ubicaciones con costo (costrate) mayor a 0 y productos con más de 100 unidades en esa ubicación.

**Tablas:** production.product, production.productinventory, production.location, purchasing.productvendor, purchasing.vendor

```sql
-- Escribir consulta aquí
```

### Ejercicio 9 — Productos sin ventas

**Orden:** Producción quiere detectar productos muertos en catálogo. Listar productos que nunca registraron una venta, junto con su categoría, excluyendo productos discontinuados (discontinueddate no nulo).

**Tablas:** production.product, sales.salesorderdetail, production.productsubcategory, production.productcategory

```sql
-- Escribir consulta aquí
```

### Ejercicio 10 — Empleados sin dirección registrada

**Orden:** RR.HH. necesita depurar datos de contacto. Listar empleados que no tienen ninguna dirección registrada en el sistema, mostrando su nombre completo y fecha de contratación.

**Tablas:** humanresources.employee, person.person, person.businessentityaddress

```sql
-- Escribir consulta aquí
```
