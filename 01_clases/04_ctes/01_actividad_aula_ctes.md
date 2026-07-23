# Common Table Expressions (CTEs) — AdventureWorks (PostgreSQL)

**Base de Datos II — SIS-0126**
Bloque 2 — Consultas y Manipulación de Datos
Docente: Orlando Isaac Aguilera Zambrana · UPDS Tarija

---

## Ejercicio 1 — Meses con ventas por encima del promedio de su propio año

**Orden:** La gerencia quiere identificar los meses que vendieron por encima del promedio de su propio año. Calculá el total vendido por mes y compará cada mes contra el promedio de los meses de ese mismo año. Mostrá año, mes y monto de los meses que superen ese promedio, ordenados por año y monto descendente.

```sql
WITH ventas_mes AS (
SELECT EXTRACT(YEAR FROM soh.orderdate) AS anio ,
		EXTRACT(MONTH FROM soh.orderdate) AS mes,
		ROUND(sum(soh.totaldue),2) AS total
FROM sales.salesorderheader soh
GROUP BY anio,mes
ORDER BY anio,mes
),
promedio AS (
SELECT vm.anio, ROUND(AVG(vm.total),2) AS promedio
FROM ventas_mes vm
GROUP BY vm.anio
)
SELECT
vm.anio,
vm.mes ,
vm.total ,
		p.promedio
FROM ventas_mes vm
INNER JOIN promedio p
ON vm.anio = p.anio
WHERE vm.total > p.promedio

```

---

## Ejercicio 2 — Primer y último pedido de cada cliente

**Orden:** Ventas quiere saber cuánto tiempo lleva cada cliente activo en la plataforma. Mostrar cliente, fecha de su primer pedido, fecha de su último pedido y la cantidad de días transcurridos entre ambos.

```sql
WITH fechas_venta AS (
SELECT soh.customerid ,
	MIN(soh.orderdate)::DATE AS fecha_min,
	MAX(soh.orderdate)::DATE AS fecha_max
	FROM sales.salesorderheader soh
	GROUP BY soh.customerid
	ORDER BY 1
)
SELECT p.firstname , p.lastname , fv.fecha_min ,fv.fecha_max
FROM sales.customer c
INNER JOIN person.person p
ON c.personid = p.businessentityid
INNER JOIN fechas_venta fv
ON c.customerid = fv.customerid ;
```

---

## Ejercicio 3 — Introducción a Ranking: Top 3 productos más vendidos por categoría

**Orden:** El área comercial quiere ver, dentro de cada categoría, cuáles son los 3 productos con mayor cantidad vendida. Mostrar el nombre del producto, la categoría, la cantidad total vendida y la posición que ocupa dentro de su categoría.

```sql
-- Escribe tu consulta aquí
```

---

## Ejercicio 4 — Brecha con el líder de ventas por categoría

**Orden:** El área comercial quiere medir qué tan lejos está cada producto del líder de ventas dentro de su categoría. Mostrar el nombre del producto, su categoría, la cantidad total vendida y la diferencia respecto al producto más vendido de esa misma categoría. Ordenar por categoría y luego por la diferencia ascendente (los más cercanos al líder primero).

```sql
-- Escribe tu consulta aquí
```

---

## Ejercicio 5 — Productos que subieron de precio en el último año

**Orden:** El área comercial quiere identificar qué productos tuvieron un aumento de precio en el último año. Mostrar el nombre del producto, el precio de hace un año, el precio actual y la diferencia entre ambos, únicamente para los productos cuyo precio haya aumentado.

```sql
-- Escribe tu consulta aquí
```
