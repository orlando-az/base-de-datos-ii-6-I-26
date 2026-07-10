# Laboratorio — Sistema de Gestión de Condominio

**Base de Datos II (SIS-0126)** · Ingeniería de Sistemas · UPDS

---

## JOINs: concepto y tipos

Un **JOIN** combina filas de dos o más tablas a partir de una condición de relación, generalmente entre una clave primaria y su clave foránea correspondiente. Sin JOINs, cada consulta quedaría limitada a una sola tabla, lo cual resulta insuficiente en un modelo relacional normalizado como el de este condominio (departamentos, propietarios, expensas, pagos, alquileres).

Sintaxis general:

```sql
SELECT columnas
FROM tabla_a a
[TIPO DE JOIN] tabla_b b ON a.columna = b.columna;
```

| Tipo         | Devuelve                                                                   | Filas sin coincidencia                 |
| ------------ | -------------------------------------------------------------------------- | -------------------------------------- |
| `INNER JOIN` | Solo las filas donde existe coincidencia en ambas tablas                   | Se excluyen de ambos lados             |
| `LEFT JOIN`  | Todas las filas de la tabla izquierda, más las coincidencias de la derecha | Lado derecho aparece con `NULL`        |
| `RIGHT JOIN` | Todas las filas de la tabla derecha, más las coincidencias de la izquierda | Lado izquierdo aparece con `NULL`      |
| `FULL JOIN`  | Todas las filas de ambas tablas, coincidan o no                            | Ambos lados pueden aparecer con `NULL` |
| `CROSS JOIN` | Producto cartesiano: cada fila de A combinada con cada fila de B           | No aplica condición `ON`               |

**INNER JOIN** — el más común; se usa cuando solo interesan los registros relacionados en ambas tablas.

```sql
SELECT d.numero, p.nombre
FROM departamento d
INNER JOIN propietario p ON d.propietario_id = p.id;
```

**LEFT JOIN** — se usa cuando se necesita conservar todos los registros de la tabla principal, tengan o no relación. Es la base para detectar ausencias (por ejemplo, propietarios sin departamentos, o expensas sin pagos).

```sql
SELECT p.nombre, d.numero
FROM propietario p
LEFT JOIN departamento d ON d.propietario_id = p.id;
```

**RIGHT JOIN** — equivalente a un `LEFT JOIN` con las tablas invertidas; se prefiere mantener siempre el mismo orden de tablas y usar `LEFT JOIN` por legibilidad, salvo que el enunciado exija explícitamente `RIGHT JOIN`.

**FULL JOIN** — combina el comportamiento de `LEFT` y `RIGHT`; útil para auditorías donde interesa ver huérfanos en ambos sentidos.

**CROSS JOIN** — no usa condición de relación; multiplica todas las filas de una tabla por todas las de otra. Se usa poco en consultas de negocio y mucho para generar combinaciones (por ejemplo, todas las fechas contra todos los departamentos).

Puntos clave a tener en cuenta:

- El tipo de JOIN se elige según si los registros "huérfanos" (sin relación) deben mostrarse o no.
- Es posible encadenar varios JOINs en una misma consulta, mezclando tipos según la necesidad de cada tabla.
- Cuando se filtra sobre una columna del lado "opcional" de un `LEFT JOIN`, la condición debe ir en el `ON` y no en el `WHERE`, para no convertir el `LEFT JOIN` en un `INNER JOIN` de forma implícita.

---

## Parte A — Repaso de filtros (sin JOIN)

Los siguientes cuatro ejercicios no requieren combinar tablas: son un repaso de filtros (`WHERE`, `BETWEEN`, `LIKE`, `IN`) antes de introducir JOINs en la Parte B.

## Ejercicio 1

Listar todos los departamentos del piso 2 o 3 mostrando su número, piso y superficie, ordenados por piso ascendente y superficie descendente.

```sql

```

---

## Ejercicio 2

Mostrar los propietarios cuyo nombre contenga la letra 'o' y tengan teléfono registrado, ordenados alfabéticamente.

```sql

```

---

## Ejercicio 3

Listar las expensas con estado 'pendiente' o 'vencida' cuyo monto esté entre 400 y 700 Bs, mostrando id de departamento, monto, fecha de vencimiento y estado, ordenadas por fecha de vencimiento ascendente.

```sql

```

---

## Ejercicio 4

Mostrar los pagos cuyo monto pagado sea mayor a 400 Bs y menor a 650 Bs, realizados con método 'transferencia' o 'QR', ordenados por fecha descendente.

```sql

```

---

## Parte B — JOINs

A partir de aquí cada ejercicio combina dos o más tablas. El orden avanza de INNER JOIN simple (5), a LEFT JOIN simple (6), a LEFT JOIN combinado con INNER JOIN en 3+ tablas (7), a JOIN + agregación (8), a JOIN múltiple de 4 tablas (9), hasta el ejercicio integrador final (10).

## Ejercicio 5

Listar número de departamento, piso, superficie y nombre del condominio para departamentos del piso 3 o con superficie menor a 60 m², ordenados por nombre del condominio ascendente.

```sql

```

---

## Ejercicio 6

Mostrar todos los propietarios y — si tienen — sus departamentos con el nombre del condominio. Los propietarios sin departamentos deben aparecer con NULL.

```sql

```

---

## Ejercicio 7

Mostrar todas las expensas y — si tienen — sus pagos registrados, incluyendo número de departamento, nombre del condominio y nombre del propietario del departamento. Las expensas sin pagos deben aparecer con NULL en los campos del pago. (Requiere combinar LEFT JOIN con expensa→pago e INNER JOIN con departamento→condominio y departamento→propietario.)

```sql

```

---

## Ejercicio 8

Contar cuántas expensas tiene cada departamento por estado, mostrando número de departamento, nombre del condominio, estado y cantidad, ordenado por cantidad descendente.

```sql

```

---

## Ejercicio 9

Mostrar nombre del inquilino, número de departamento, nombre del condominio, nombre del propietario y fecha de inicio y fin, solo para alquileres que ya hayan finalizado (activo = FALSE), ordenados por fecha de fin descendente.

```sql

```

---

## Ejercicio 10

Mostrar nombre del condominio, número de departamento, nombre del propietario, nombre del inquilino activo y el total de expensas pendientes del departamento, solo para condominios ubicados en La Paz.

```sql

```
