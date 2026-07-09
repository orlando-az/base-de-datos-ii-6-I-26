# Construcción de base de datos: AdmiCasas

**Asignatura:** Base de Datos II — SIS-0126 | **Sesión:** 4 | **Docente:** Orlando Isaac Aguilera

---

## Caso de estudio

AdmiCasas es una empresa que administra condominios en la ciudad.
Cada condominio tiene varios departamentos, cada departamento pertenece
a un propietario y puede ser ocupado por un inquilino mediante un
contrato de alquiler. Mensualmente se generan expensas por departamento
y los propietarios (o inquilinos) registran sus pagos.

---

## Requerimientos

### 1. Esquema

Crear el esquema `admicasas`.

---

### 2. Tablas

| Entidad        | Atributos                                           |
| -------------- | --------------------------------------------------- |
| `condominio`   | id, nombre, direccion, num_pisos                    |
| `propietario`  | id, nombre, ci, telefono                            |
| `inquilino`    | id, nombre, ci, telefono                            |
| `departamento` | id, numero, piso, superficie_m2                     |
| `alquiler`     | id, fecha_inicio, fecha_fin, activo                 |
| `expensa`      | id, monto, fecha_emision, fecha_vencimiento, estado |
| `pago`         | id, fecha_pago, monto_pagado, metodo_pago           |

> Las claves primarias (`id`) deben definirse como
> `INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY`, no como `SERIAL`.

---

### 3. Restricciones de integridad

| Entidad        | Restricción                                                                   |
| -------------- | ----------------------------------------------------------------------------- |
| `condominio`   | `nombre` no puede ser nulo                                                    |
|                | `num_pisos` debe ser mayor a 0                                                |
| `propietario`  | `nombre` no puede ser nulo                                                    |
|                | `ci` no puede ser nulo ni repetirse entre registros                           |
| `inquilino`    | `nombre` no puede ser nulo                                                    |
|                | `ci` no puede ser nulo ni repetirse entre registros                           |
| `departamento` | `numero` no puede ser nulo                                                    |
|                | `piso` debe ser mayor o igual a 0                                             |
|                | `superficie_m2` debe ser mayor a 0                                            |
|                | La combinación de `id_condominio` y `numero` debe ser única                   |
| `alquiler`     | `fecha_inicio` no puede ser nula                                              |
|                | `fecha_fin`, si existe, debe ser posterior a `fecha_inicio`                   |
|                | `activo` tiene como valor por defecto `TRUE`                                  |
| `expensa`      | `monto` debe ser mayor a 0                                                    |
|                | `estado` solo puede tomar los valores `pendiente`, `pagada` o `vencida`       |
|                | `estado` tiene como valor por defecto `pendiente`                             |
|                | `fecha_vencimiento` debe ser posterior a `fecha_emision`                      |
| `pago`         | `monto_pagado` debe ser mayor a 0                                             |
|                | `metodo_pago` solo puede tomar los valores `efectivo`, `transferencia` o `QR` |

---

### 4. Relaciones

Definir las relaciones entre tablas mediante claves foráneas.
Tener en cuenta el orden de creación según las dependencias:

1. `condominio`, `propietario`, `inquilino` (tablas independientes)
2. `departamento` (referencia a `condominio` y `propietario`)
3. `alquiler` (referencia a `departamento` e `inquilino`)
4. `expensa` (referencia a `departamento`)
5. `pago` (referencia a `expensa`)
