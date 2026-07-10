# Laboratorio 3 — Sistema de Gestión de Condominio

**Nombre:** **********************\_\_\_**********************

---

## Ejercicio 1

Listar todos los departamentos del piso 2 o 3 mostrando su número, piso y superficie, ordenados por piso ascendente y superficie descendente.

## Ejercicio 2

Mostrar los propietarios cuyo nombre contenga la letra 'o' y tengan teléfono registrado, ordenados alfabéticamente.

## Ejercicio 3

Listar las expensas con estado 'pendiente' o 'vencida' cuyo monto esté entre 400 y 700 Bs, mostrando id de departamento, monto, fecha de vencimiento y estado, ordenadas por fecha de vencimiento ascendente.

## Ejercicio 4

Mostrar los pagos cuyo monto pagado sea mayor a 400 Bs y menor a 650 Bs, realizados con método 'transferencia' o 'QR', ordenados por fecha descendente.

## Ejercicio 5

Listar número de departamento, piso, superficie y nombre del condominio para departamentos del piso 3 o con superficie menor a 60 m², ordenados por nombre del condominio ascendente.

## Ejercicio 6

Mostrar todos los propietarios y — si tienen — sus departamentos con el nombre del condominio. Los propietarios sin departamentos deben aparecer con NULL.

## Ejercicio 7

Mostrar todas las expensas y — si tienen — sus pagos registrados, incluyendo número de departamento y nombre del condominio. Las expensas sin pagos deben aparecer con NULL en los campos del pago.

## Ejercicio 8

Mostrar nombre del inquilino, número de departamento, nombre del condominio, nombre del propietario y fecha de inicio y fin, solo para alquileres que ya hayan finalizado (activo = FALSE), ordenados por fecha de fin descendente.

## Ejercicio 9

Contar cuántas expensas tiene cada departamento por estado, mostrando número de departamento, nombre del condominio, estado y cantidad, ordenado por cantidad descendente.

## Ejercicio 10

Mostrar nombre del condominio, número de departamento, nombre del propietario, nombre del inquilino activo y el total de expensas pendientes del departamento, solo para condominios ubicados en La Paz.

---

## Entregable

Subir un único archivo con el siguiente formato de nombre:

```
lab_3_consultas_basicas.sql
```

El archivo debe contener las 10 consultas SQL. Cada ejercicio debe incluir obligatoriamente la consigna copiada como comentario, seguida de la consulta. Ejemplo:

```sql
-- Ejercicio 1
-- Listar todos los departamentos del piso 2 o 3 mostrando su número, piso y superficie,
-- ordenados por piso ascendente y superficie descendente.
SELECT ...

-- Ejercicio 2
-- Mostrar los propietarios cuyo nombre contenga la letra 'o' ...
SELECT ...
```
