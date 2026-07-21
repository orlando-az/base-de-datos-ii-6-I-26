# Evaluación de Conocimientos — Base de Datos II (SIS-0126)

## Ejercicio 1 — Clientes preferentes por territorio y método de envío

**Orden:** Logística y ventas quieren identificar clientes de alto valor según su método de envío dentro de cada territorio. Mostrar el ID de cliente, nombre completo, territorio, método de envío, cantidad de órdenes con ese método y el total gastado. Considerar solo combinaciones cliente-método con más de 3 órdenes. Clasificar cada combinación como "Preferente" si el total gastado supera 100000, o "Regular" en caso contrario. Ordenar por territorio y total gastado descendente.

**Tablas:** sales.customer, person.person, sales.salesorderheader, purchasing.shipmethod, sales.salesterritory

```sql
SELECT
    c.customerid,
    p.firstname,
    p.lastname,
    st.name AS territorio,
    sm.name AS metodo_envio,
    COUNT(soh.salesorderid) AS ordenes_con_metodo,
    SUM(soh.totaldue) AS total_gastado,
    CASE
        WHEN SUM(soh.totaldue) > 100000 THEN 'Preferente'
        ELSE 'Regular'
    END AS clasificacion
FROM sales.customer c
INNER JOIN person.person p ON p.businessentityid = c.personid
INNER JOIN sales.salesorderheader soh ON soh.customerid = c.customerid
INNER JOIN purchasing.shipmethod sm ON sm.shipmethodid = soh.shipmethodid
INNER JOIN sales.salesterritory st ON st.territoryid = soh.territoryid
GROUP BY c.customerid, p.firstname, p.lastname, st.name, sm.name
HAVING COUNT(soh.salesorderid) > 3
ORDER BY st.name, total_gastado DESC;
```

---

## Ejercicio 2 — Proveedores con mayor tasa de rechazo

**Orden:** Control de calidad necesita identificar proveedores con mayor proporción de unidades rechazadas. Mostrar razón social del proveedor, cantidad de órdenes de compra, unidades totales pedidas, unidades totales rechazadas y el porcentaje que representan las unidades rechazadas sobre las pedidas. Considerar solo proveedores con más de 4 órdenes y donde ese porcentaje supere el 1%. Ordenar por porcentaje descendente.

**Tablas:** purchasing.vendor, purchasing.purchaseorderheader, purchasing.purchaseorderdetail

```sql
SELECT
    v.name AS proveedor,
    COUNT(DISTINCT poh.purchaseorderid) AS total_ordenes,
    SUM(pod.orderqty) AS unidades_pedidas,
    SUM(pod.rejectedqty) AS unidades_rechazadas,
    ROUND(SUM(pod.rejectedqty) * 100.0 / SUM(pod.orderqty), 2) AS pct_rechazo
FROM purchasing.vendor v
INNER JOIN purchasing.purchaseorderheader poh ON poh.vendorid = v.businessentityid
INNER JOIN purchasing.purchaseorderdetail pod ON pod.purchaseorderid = poh.purchaseorderid
GROUP BY v.name
HAVING COUNT(DISTINCT poh.purchaseorderid) > 4
   AND SUM(pod.rejectedqty) * 100.0 / SUM(pod.orderqty) > 1
ORDER BY pct_rechazo DESC;
```

---

## Ejercicio 3 — Productos con scrap significativo por categoría

**Orden:** Producción quiere identificar productos con un nivel de desperdicio relevante. Mostrar nombre del producto, categoría y cantidad de órdenes de trabajo con motivo de scrap registrado, únicamente para productos con más de 5 órdenes con scrap. Ordenar por categoría y cantidad de scrap descendente.

**Tablas:** production.workorder, production.product, production.productsubcategory, production.productcategory

```sql
SELECT
    p.name AS producto,
    pc.name AS categoria,
    COUNT(*) AS total_scrap
FROM production.workorder w
INNER JOIN production.product p ON p.productid = w.productid
INNER JOIN production.productsubcategory psc ON psc.productsubcategoryid = p.productsubcategoryid
INNER JOIN production.productcategory pc ON pc.productcategoryid = psc.productcategoryid
WHERE w.scrapreasonid IS NOT NULL
GROUP BY p.productid, p.name, pc.name
HAVING COUNT(*) > 5
ORDER BY pc.name, total_scrap DESC;
```

---

## Ejercicio 4 — Productos por encima del promedio de su categoría

**Orden:** El área comercial quiere identificar productos destacados dentro de cada categoría. Obtener el nombre del producto, su categoría y su precio de lista, únicamente de aquellos cuyo precio supere el promedio general de precios de su misma categoría. Ordenar por categoría y luego por precio descendente.

**Tablas:** production.product, production.productsubcategory, production.productcategory

```sql
SELECT
    p.name AS producto,
    pc.name AS categoria,
    p.listprice
FROM production.product p
INNER JOIN production.productsubcategory psc ON psc.productsubcategoryid = p.productsubcategoryid
INNER JOIN production.productcategory pc ON pc.productcategoryid = psc.productcategoryid
WHERE p.listprice > (
    SELECT AVG(p2.listprice)
    FROM production.product p2
    INNER JOIN production.productsubcategory psc2 ON psc2.productsubcategoryid = p2.productsubcategoryid
    WHERE psc2.productcategoryid = pc.productcategoryid
)
ORDER BY pc.name, p.listprice DESC;
```

---

**Total: 100 puntos**
