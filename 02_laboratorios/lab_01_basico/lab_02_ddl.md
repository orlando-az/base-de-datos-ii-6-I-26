# Laboratorio 02 — DDL: Sistema de Clínica Médica

**Asignatura:** Base de Datos II — SIS-0126 | **Sesión:** 3 | **Modalidad:** Individual

---

## Descripción

A partir del diagrama entidad-relación desarrollado en la sesión 2,
implementar en PostgreSQL la base de datos del sistema de clínica médica.

---

## Requerimientos

### 1. Esquema
Crear el esquema `clinica`.

### 2. Tablas
Crear todas las tablas identificadas en el DER con sus atributos
y tipos de datos correspondientes.

### 3. Restricciones de integridad
Aplicar las restricciones que correspondan según el dominio
de cada atributo:

| Constraint | Uso |
|---|---|
| `NOT NULL` | Atributos obligatorios |
| `UNIQUE` | Atributos que no pueden repetirse |
| `CHECK` | Atributos con valores restringidos o rangos |
| `DEFAULT` | Atributos con valor predeterminado |

### 4. Relaciones
Definir todas las relaciones entre tablas mediante claves foráneas
respetando el orden de creación según las dependencias.

### 5. Datos de prueba
Insertar al menos 3 registros por tabla respetando
las restricciones definidas.

---

## Entregable

Archivo: `lab_02_ddl_[apellido].sql`
