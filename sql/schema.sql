DROP DATABASE IF EXISTS nexshop;
CREATE DATABASE nexshop;
USE nexshop;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    fecha_nacimiento DATE,
    fecha_registro DATE
);

CREATE TABLE sede (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo ENUM('tienda', 'almacen', 'sede central') NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    id_sede INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    email_corporativo VARCHAR(100) NOT NULL UNIQUE,
    fecha_incorporacion DATE NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

CREATE TABLE direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_direccion ENUM('domicilio', 'trabajo', 'otra') NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    piso VARCHAR(20),
    codigo_postal VARCHAR(10) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE subcategoria (
    id_subcategoria INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_subcategoria INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    referencia VARCHAR(50) UNIQUE,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_subcategoria) REFERENCES subcategoria(id_subcategoria)
);

CREATE TABLE historico_precio (
    id_precio INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE promocion (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE producto_promocion (
    id_producto INT NOT NULL,
    id_promocion INT NOT NULL,
    PRIMARY KEY (id_producto, id_promocion),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_promocion) REFERENCES promocion(id_promocion)
);

CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    id_representante INT,
    nombre VARCHAR(100) NOT NULL,
    cif VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(150),
    FOREIGN KEY (id_representante) REFERENCES empleado(id_empleado)
);

CREATE TABLE condicion_suministro (
    id_condicion INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    precio_coste DECIMAL(10,2) NOT NULL,
    plazo_entrega_dias INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE stock (
    id_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sede INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 0,
    UNIQUE (id_producto, id_sede),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

CREATE TABLE transferencia_stock (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sede_origen INT NOT NULL,
    id_sede_destino INT NOT NULL,
    id_empleado_autoriza INT NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_sede_origen) REFERENCES sede(id_sede),
    FOREIGN KEY (id_sede_destino) REFERENCES sede(id_sede),
    FOREIGN KEY (id_empleado_autoriza) REFERENCES empleado(id_empleado)
);

CREATE TABLE pedido_online (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_direccion_envio INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado VARCHAR(30) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_direccion_envio) REFERENCES direccion(id_direccion)
);

CREATE TABLE linea_pedido (
    id_linea_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descuento_aplicado DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (id_pedido) REFERENCES pedido_online(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE envio (
    id_envio INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_sede_origen INT NOT NULL,
    numero_seguimiento VARCHAR(100) UNIQUE,
    transportista VARCHAR(100),
    fecha_envio DATE,
    fecha_estimada_entrega DATE,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido_online(id_pedido),
    FOREIGN KEY (id_sede_origen) REFERENCES sede(id_sede)
);

CREATE TABLE venta_presencial (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NULL,
    id_empleado INT NOT NULL,
    id_sede INT NOT NULL,
    fecha_venta DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

CREATE TABLE linea_venta (
    id_linea_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descuento_aplicado DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (id_venta) REFERENCES venta_presencial(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE devolucion (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    fecha_devolucion DATE NOT NULL,
    motivo TEXT,
    estado VARCHAR(30),
    FOREIGN KEY (id_venta) REFERENCES venta_presencial(id_venta)
);

CREATE TABLE ticket_incidencia (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pedido INT NULL,
    id_empleado_agente INT NOT NULL,
    asunto VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_apertura DATE NOT NULL,
    fecha_cierre DATE,
    estado VARCHAR(30),
    resolucion TEXT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido_online(id_pedido),
    FOREIGN KEY (id_empleado_agente) REFERENCES empleado(id_empleado)
);

CREATE TABLE valoracion (
    id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    puntuacion INT NOT NULL,
    comentario TEXT,
    fecha_valoracion DATE NOT NULL,
    verificada BOOLEAN DEFAULT FALSE,
    UNIQUE (id_cliente, id_producto),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE movimiento_puntos (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pedido INT NULL,
    fecha_movimiento DATE NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL,
    puntos INT NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido_online(id_pedido)
);