# Laboratorio 4 — CTEs

**Asignatura:** Base de Datos II (SIS-0126)
**Bloque:** 3 — Objetos de Base de Datos
**Tema:** Expresiones de tabla comunes (CTEs) encadenadas y funciones de ventana
**Base de datos:** AdventureWorks (PostgreSQL)
**Modalidad:** Trabajo en grupos
**Docente:** Orlando Isaac Aguilera Zambrana

## Objetivo

Resolver problemas que requieren combinar más de un CTE en una misma consulta, incluyendo el uso de funciones de ventana (`DENSE_RANK`) sobre resultados ya agregados o filtrados.

## Instrucciones generales

- Formar grupos según lo indicado en clase.
- Resolver los tres ejercicios usando exclusivamente CTEs (`WITH`);
- Cada consulta final debe ejecutarse sin errores contra la base AdventureWorks.
- Entregar un único script `.sql` con las tres consultas, identificadas con su número de ejercicio como comentario.

---

### Ejercicio 1 — Cuota máxima histórica y variación respecto a la cuota actual

Orden: Para cada vendedor, identificá el período de su historial en que alcanzó la cuota de venta más alta, sin dejar saltos en la numeración cuando haya empates. A partir de ese valor, calculá la diferencia entre esa cuota histórica máxima y la cuota que tiene asignada actualmente. Mostrá únicamente a los vendedores cuya cuota máxima histórica sea mayor a la cuota actual, indicando su nombre completo, la fecha de ese período, la cuota máxima, la cuota actual y la diferencia entre ambas.

**Tablas:** sales.salespersonquotahistory, sales.salesperson, person.person

---

### Ejercicio 2 — Productos con ventas por encima del promedio general

Orden: A partir del historial de transacciones, calculá para cada producto el total de unidades vendidas, compradas y fabricadas. Luego, calculá el promedio general de unidades vendidas considerando todos los productos con movimiento registrado. Mostrá únicamente los productos cuyo total vendido supere tanto al total comprado del mismo producto como al promedio general de ventas, junto con el nombre del producto, ambos totales y el promedio general utilizado como referencia.

**Tablas:** production.transactionhistory, production.product

---

### Ejercicio 3 — Oferta con mayor descuento por categoría, entre las de mayor alcance

Orden: Calculá cuántos productos distintos alcanza cada oferta especial cuya fecha de fin sea posterior al 1 de enero de 2013. Entre esas ofertas, quedate solo con las que superen los cinco productos alcanzados y asigná una posición dentro de cada categoría de oferta según su porcentaje de descuento, de manera que descuentos iguales compartan el mismo puesto. Mostrá únicamente la oferta con el descuento más alto de cada categoría, junto con la categoría, la descripción, el porcentaje de descuento y la cantidad de productos alcanzados.

**Tablas:** sales.specialoffer, sales.specialofferproduct
