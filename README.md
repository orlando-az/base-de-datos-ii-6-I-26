# Base de Datos II (SIS-0126)

**Carrera:** Ingeniería de Sistemas — 5to semestre
**Facultad:** Ingeniería — Universidad Privada Domingo Savio (UPDS), Tarija
**Docente:** Orlando Isaac Aguilera Zambrana (`tj.orlando.aguilera.z@upds.net.bo`)

Repositorio oficial de apoyo para la asignatura Base de Datos II. Contiene el
material docente (clases, laboratorios, evaluaciones y proyecto final)
utilizado durante el desarrollo del módulo.

---

## Stack tecnológico

- **Motor de base de datos:** PostgreSQL 16+
- **Cliente / IDE:** DBeaver Community Edition
- **Base de datos de ejemplo:** AdventureWorks (adaptada a PostgreSQL)
- **Lenguaje:** SQL estándar (ANSI SQL) + extensiones de PostgreSQL / PL-pgSQL
- **Control de versiones:** Git / GitHub

---

## Plan de aula (20 sesiones, 3h c/u, lunes a viernes)

> ⚠️ **Fechas pendientes de actualizar** para esta gestión. La secuencia y
> duración de bloques se mantiene respecto a la edición anterior del curso.

| # | Sesión | Bloque |
|---|--------|--------|
| 1 | Presentación | — |
| 2 | DER — repaso | Bloque 1 |
| 3 | DDL — repaso | Bloque 1 |
| 4–5 | SQL Simple | Bloque 2 |
| 6–10 | SQL Avanzado (JOINs, agregaciones/window functions, subconsultas básicas, subconsultas avanzadas, consolidación) | Bloque 2 |
| 11–12 | Vistas | Bloque 3 |
| 13–14 | CTEs | Bloque 2 |
| 15–16 | Procedimientos almacenados | Bloque 3 |
| 17 | Funciones (UDFs) | Bloque 3 |
| 18 | Triggers | Bloque 3 |
| 19 | Presentación proyecto final | — |
| 20 | Evaluación de conocimientos | — |

---

## Sistema de evaluación (100 pts)

| Componente | Puntos |
|---|---|
| Proyecto — Fase 1 | 5 |
| Proyecto — Entrega Final | 20 |
| Examen Final | 35 |
| Evaluación de Conocimientos | 15 |
| Actividad Autónoma | 5 |
| Laboratorio Práctico | 10 |
| Producción en Aula | 10 |
| **Total** | **100** |

**Escala valorativa institucional:**

| Escala conceptual | Rango |
|---|---|
| Estratégico | 85–100 |
| Autónomo | 70–84 |
| Resolutivo | 51–69 |
| Receptivo | 25–50 |
| Preformal | 1–24 |

---

## Estructura del repositorio

```
.
├── 01_clases/                 # Scripts y guías del docente, por sesión
├── 02_laboratorios/           # Ejercicios prácticos para estudiantes (.sql)
├── 03_database/               # Scripts/dumps de la base de datos AdventureWorks
├── 04_evaluaciones/
│   ├── evaluacion_conocimiento/
│   │   ├── grupo_a/
│   │   └── grupo_b/
│   └── examen_final/
├── 05_proyecto_final/
│   ├── fase1/
│   └── entrega_final/
└── 06_recursos/                # Material de apoyo, bibliografía, guías externas
```

---

## Convención de nombres de archivo

```
BD2_[TIPO]_[##]_[descripcion].[ext]
```

Ejemplos: `BD2_CLASE_08_joins_multitabla.sql`, `BD2_LAB_05_subconsultas.sql`,
`BD2_EVAL_GRUPOA_conocimiento.docx`

**Tipos usados:** `CLASE`, `LAB`, `EVAL`, `PROYECTO`, `RECURSO`

Cada material de sesión (`01_clases/`, `02_laboratorios/`) se entrega como
par de archivos `.md`: consigna del estudiante (bloques SQL vacíos) +
solución del docente (con rúbrica).

---

## Estándares de código SQL

- Palabras reservadas en **MAYÚSCULAS** (`SELECT`, `FROM`, `WHERE`, ...).
- Nombres de tablas, columnas y objetos en `snake_case`.
- Esquema explícito siempre que sea relevante (`sales.customer`, no solo `customer`).
- `INTEGER` sobre `INT`; `GENERATED ALWAYS AS IDENTITY PRIMARY KEY` sobre `SERIAL`.
- `TEXT` para campos de longitud abierta; `VARCHAR(n)` solo si hay un límite
  de negocio definido.
- Comentarios en español (`--` o `/* */`).
- Scripts idempotentes: `CREATE OR REPLACE` o `DROP ... IF EXISTS` antes de `CREATE`.
- Toda lógica de negocio en PL/pgSQL incluye manejo explícito de excepciones.
- Formato DDL: `FOREIGN KEY (col) REFERENCES tabla(col)` como línea aparte al
  final de la tabla; `CHECK` en línea con la columna, sin la palabra clave
  `CONSTRAINT`.

---

## Licencia / uso

Material de uso académico interno para la asignatura Base de Datos II — UPDS.
