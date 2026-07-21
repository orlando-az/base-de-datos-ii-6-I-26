# Base de Datos II (SIS-0126) — CTEs (Common Table Expressions)

**Tema:** Expresiones de tabla comunes (`WITH`)

---

## Ejercicio 1 — Meses por encima del promedio anual

Orden: La gerencia quiere identificar los meses que vendieron por encima del promedio de su propio año. Calculá el total vendido por mes y compará cada mes contra el promedio de los meses de ese mismo año. Mostrá año, mes y monto de los meses que superen ese promedio, ordenados por año y monto descendente.

**Tablas:** sales.salesorderheader

```sql
-- Escribe tu consulta aquí
```

## Ejercicio 2 — Antigüedad de empleados activos

Orden: Recursos Humanos necesita un listado de los empleados que aún se encuentran activos (asignación vigente, sin fecha de finalización). Mostrá su identificador, la fecha de inicio y la cantidad de días trabajados hasta la fecha actual, ordenados de mayor a menor antigüedad.

**Tablas:** humanresources.employeedepartmenthistory

```sql
-- Escribe tu consulta aquí
```

## Ejercicio 3 — Clientes por encima del gasto promedio

Orden: Se quiere comparar el gasto de cada cliente contra el promedio general de gasto. Calculá el monto total comprado por cada cliente y listá únicamente aquellos cuyo gasto total supere el promedio general, mostrando nombre completo y monto.

**Tablas:** sales.salesorderheader, sales.customer, person.person

```sql
-- Escribe tu consulta aquí
```

## Ejercicio 4 — Vendedores contra su cuota

Orden: El área de ventas quiere comparar el desempeño de cada vendedor contra su cuota asignada. Calculá el monto total vendido por cada vendedor y mostrá su nombre, el monto vendido, su cuota de ventas y la diferencia entre ambos. Considerá solo las órdenes que tienen vendedor asignado.

**Tablas:** sales.salesorderheader, sales.salesperson, person.person

```sql
-- Escribe tu consulta aquí
```

## Ejercicio 5 — Top 3 productos por subcategoría

Orden: Se necesita el top 3 de productos más vendidos dentro de cada subcategoría. Calculá la cantidad vendida por producto y su posición dentro de su subcategoría según esa cantidad, de mayor a menor. Mostrá únicamente los productos cuya posición sea menor o igual a 3, con nombre del producto, subcategoría, cantidad vendida y posición.

**Tablas:** sales.salesorderdetail, production.product, production.productsubcategory

```sql
-- Escribe tu consulta aquí
```

## Ejercicio 6 — Vendedores por encima del promedio de su territorio

Orden: La dirección comercial quiere saber qué vendedores rinden por encima del promedio de su propio territorio. Calculá el monto total vendido por cada vendedor junto a su territorio y el promedio de ventas de ese territorio. Mostrá el territorio, el nombre del vendedor, su monto vendido y el promedio del territorio, listando únicamente a los vendedores cuyo monto supere ese promedio.

**Tablas:** sales.salesorderheader, sales.salesperson, sales.salesterritory, person.person

```sql
-- Escribe tu consulta aquí
```
