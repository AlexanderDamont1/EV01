CREATE DATABASE evobike;
USE evobike;

CREATE TABLE Modelos (
    id_modelo VARCHAR(64) PRIMARY KEY,
    nombre_modelo VARCHAR(15),
    descripcion VARCHAR(64),
    foto_modelo MEDIUMBLOB
);
CREATE TABLE Color_Modelo(
    id_colorM VARCHAR(64) PRIMARY KEY,
    id_modelo VARCHAR(64),
    nombre_color VARCHAR(32),
    FOREIGN KEY(id_modelo) REFERENCES Modelos(id_modelo)
    );

CREATE TABLE Colores (
    id_color VARCHAR(64) PRIMARY KEY,
    id_modelo VARCHAR(64),
    nombre_color VARCHAR(32),
    descripcion_general VARCHAR(32),
    FOREIGN KEY(id_modelo) REFERENCES Modelos(id_modelo)
);

CREATE TABLE Piezas (
    id_pieza VARCHAR(64) PRIMARY KEY,
    id_modelo VARCHAR(64),
    id_color VARCHAR(64),
    foto_pieza MEDIUMBLOB,
    descripcion_general VARCHAR(64),
    FOREIGN KEY (id_modelo) REFERENCES Modelos(id_modelo),
    FOREIGN KEY (id_color) REFERENCES Colores(id_color)
);

CREATE TABLE Area (
    id_area VARCHAR(64) PRIMARY KEY,
    nombre_area VARCHAR(32)
);

CREATE TABLE Personal (
    id_personal VARCHAR(64) PRIMARY KEY,
    id_area VARCHAR(64),
    nombre VARCHAR(50),
    apellido VARCHAR(32),
    telefono VARCHAR(10),
    foto_personal MEDIUMBLOB,
    direccion VARCHAR(255),
    antiguedad DATE,
    salario DECIMAL(8,2),
    FOREIGN KEY (id_area) REFERENCES Area(id_area)
);

CREATE TABLE Errores_produccion (
    id_error VARCHAR(64) PRIMARY KEY,
    id_personal VARCHAR(64),
    descripcion VARCHAR(255),
    fecha DATE,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

CREATE TABLE Lote (
    id_lote VARCHAR(64) PRIMARY KEY,
    fecha_produccion DATE
);

CREATE TABLE Tipo_stock (
    id_tipoStock VARCHAR(64) PRIMARY KEY,
    nombre_stock VARCHAR(32)
);

CREATE TABLE Bicicleta (
    num_chasis VARCHAR(64) PRIMARY KEY,
    id_modelo VARCHAR(64),
    id_color VARCHAR(64),
    id_lote VARCHAR(64),
    id_tipoStock VARCHAR(64),
    voltaje VARCHAR(10),
    num_motor VARCHAR(64),
    error_iden_produccion VARCHAR(255),
    descripcion_general VARCHAR(255),
    FOREIGN KEY (id_modelo) REFERENCES Modelos(id_modelo),
    FOREIGN KEY (id_color) REFERENCES Color_Modelo(id_color),
    FOREIGN KEY (id_lote) REFERENCES Lote(id_lote),
    FOREIGN KEY (id_tipoStock) REFERENCES Tipo_stock(id_tipoStock)
);

CREATE TABLE Errores_bicicleta (
    id_errorbicicleta VARCHAR(64) PRIMARY KEY,
    id_error VARCHAR(64),
    num_chasis VARCHAR(64),
    FOREIGN KEY (id_error) REFERENCES Errores_produccion(id_error),
    FOREIGN KEY (num_chasis) REFERENCES Bicicleta(num_chasis)
);

CREATE TABLE Tipo_precio (
    id_tipoprecio VARCHAR(64) PRIMARY KEY,
    nombre_tipo VARCHAR(32)
);

CREATE TABLE Precio (
    id_precio VARCHAR(64) PRIMARY KEY,
    id_tipoprecio VARCHAR(64),
    id_modelo VARCHAR(64),
    precio DECIMAL(10,2),
    FOREIGN KEY (id_tipoprecio) REFERENCES Tipo_precio(id_tipoprecio),
    FOREIGN KEY (id_modelo) REFERENCES Modelos(id_modelo)
);

CREATE TABLE Membresia (
    id_membresia VARCHAR(64) PRIMARY KEY,
    id_precio VARCHAR(64),
    descripcion_general VARCHAR(255),
    FOREIGN KEY (id_precio) REFERENCES Precio(id_precio)
);

CREATE TABLE Clientes (
    id_cliente VARCHAR(64) PRIMARY KEY,
    id_membresia VARCHAR(64),
    nombre VARCHAR(50),
    apellido VARCHAR(32),
    telefono VARCHAR(10),
    foto_persona MEDIUMBLOB,
    descripcion_general VARCHAR(255),
    FOREIGN KEY (id_membresia) REFERENCES Membresia(id_membresia)
);

CREATE TABLE Ruta (
    id_ruta VARCHAR(64) PRIMARY KEY,
    localizacion VARCHAR(255)
);

CREATE TABLE Sucursales (
    id_sucursal VARCHAR(64) PRIMARY KEY,
    id_ruta VARCHAR(64),
    id_cliente VARCHAR(64),
    nombre_sucursal VARCHAR(64),
    foto_fachada MEDIUMBLOB,
    FOREIGN KEY (id_ruta) REFERENCES Ruta(id_ruta),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Envios (
    id_envio VARCHAR(64) PRIMARY KEY,
    id_sucursal VARCHAR(64),
    id_personal VARCHAR(64),
    fecha_envio DATE,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal),
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

CREATE TABLE Envios_bicicleta (
    id_enviobici VARCHAR(64) PRIMARY KEY,
    id_envio VARCHAR(64),
    num_chasis VARCHAR(64),
    FOREIGN KEY (id_envio) REFERENCES Envios(id_envio),
    FOREIGN KEY (num_chasis) REFERENCES Bicicleta(num_chasis)
);
