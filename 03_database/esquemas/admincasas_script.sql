-- ============================================================
-- SISTEMA DE GESTIÓN DE CONDOMINIO
-- ============================================================

-- 1. Tablas independientes
-- ------------------------------------------------------------
CREATE TABLE condominio (
    id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre    VARCHAR(100) NOT NULL,
    direccion TEXT         NOT NULL,
    num_pisos INTEGER      NOT NULL CHECK (num_pisos > 0)
);

CREATE TABLE propietario (
    id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre   VARCHAR(100) NOT NULL,
    ci       VARCHAR(20)  NOT NULL UNIQUE,
    telefono VARCHAR(20)
);

CREATE TABLE inquilino (
    id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre   VARCHAR(100) NOT NULL,
    ci       VARCHAR(20)  NOT NULL UNIQUE,
    telefono VARCHAR(20)
);

-- ------------------------------------------------------------
-- 2. Tablas dependientes (con FK)
-- ------------------------------------------------------------
CREATE TABLE departamento (
    id             INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_condominio  INTEGER      NOT NULL REFERENCES condominio(id),
    id_propietario INTEGER      NOT NULL REFERENCES propietario(id),
    numero         VARCHAR(10)  NOT NULL,
    piso           INTEGER      NOT NULL CHECK (piso >= 0),
    superficie_m2  NUMERIC(7,2) NOT NULL CHECK (superficie_m2 > 0),
    UNIQUE (id_condominio, numero)
);

CREATE TABLE alquiler (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_departamento INTEGER NOT NULL REFERENCES departamento(id),
    id_inquilino    INTEGER NOT NULL REFERENCES inquilino(id),
    fecha_inicio    DATE    NOT NULL,
    fecha_fin       DATE,
    activo          BOOLEAN NOT NULL DEFAULT TRUE,
    CHECK (fecha_fin IS NULL OR fecha_fin > fecha_inicio)
);

CREATE TABLE expensa (
    id                INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_departamento   INTEGER       NOT NULL REFERENCES departamento(id),
    monto             NUMERIC(10,2) NOT NULL CHECK (monto > 0),
    fecha_emision     DATE          NOT NULL DEFAULT CURRENT_DATE,
    fecha_vencimiento DATE          NOT NULL,
    estado            VARCHAR(20)   NOT NULL DEFAULT 'pendiente'
        CHECK (estado IN ('pendiente', 'pagada', 'vencida')),
    CHECK (fecha_vencimiento > fecha_emision)
);

CREATE TABLE pago (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_expensa   INTEGER       NOT NULL REFERENCES expensa(id),
    fecha_pago   DATE          NOT NULL DEFAULT CURRENT_DATE,
    monto_pagado NUMERIC(10,2) NOT NULL CHECK (monto_pagado > 0),
    metodo_pago  VARCHAR(20)   NOT NULL
        CHECK (metodo_pago IN ('efectivo', 'transferencia', 'QR'))
);