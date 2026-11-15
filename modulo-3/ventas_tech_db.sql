--Seccion 1 

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS regiones;



-- Tabla de dimensión: categorias
CREATE TABLE categorias (
    id_categoria     INT          PRIMARY KEY,
    nombre_categoria VARCHAR(50)  NOT NULL,
    descripcion      VARCHAR(200)
);


-- Tabla de dimensión: regiones
CREATE TABLE regiones (
    id_region     INT         PRIMARY KEY,
    nombre_region VARCHAR(50) NOT NULL,
    pais          VARCHAR(50)
);


 
-- Tabla de dimensión: clientes
CREATE TABLE clientes (
    id_cliente     INT          PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    ciudad         VARCHAR(50),
    fecha_registro DATE         NOT NULL
);
 
-- Tabla de dimensión: productos (depende de categorias)
CREATE TABLE productos (
    id_producto     INT           PRIMARY KEY,
    nombre_producto VARCHAR(100)  NOT NULL,
    id_categoria    INT           REFERENCES categorias(id_categoria),
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT           DEFAULT 0,
    activo          BOOLEAN       DEFAULT TRUE
);
 
-- Tabla de hechos: ventas (depende de clientes y productos)

CREATE TABLE ventas (
    id_venta        INT           PRIMARY KEY,
    id_cliente      INT           REFERENCES clientes(id_cliente),
    id_producto     INT           REFERENCES productos(id_producto),
    id_region       INT           REFERENCES regiones(id_region),
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta     DATE          NOT NULL
);



-- categorias — 4 registros
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

-- regiones -- 3 registros
INSERT INTO regiones (id_region, nombre_region, pais) VALUES
  (1, 'Centro',  'Argentina'),
  (2, 'Cuyo',    'Argentina'),
  (3, 'Litoral', 'Argentina');
 
-- clientes — 7 registros
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
  (1, 'María López',   'maria@mail.com',  'Buenos Aires', '2024-01-05'),
  (2, 'Carlos Ruiz',   'carlos@mail.com', 'Córdoba',      '2024-01-10'),
  (3, 'Ana Gómez',     'ana@mail.com',    'Rosario',      '2024-02-01'),
  (4, 'Pedro Sanz',    'pedro@mail.com',  'Mendoza',      '2024-02-15'),
  (5, 'Laura Torres',  'laura@mail.com',  'Tucumán',      '2024-03-01'),
  (6, 'Diego Mora',    'diego@mail.com',  'La Plata',     '2024-03-20'),
  (7, 'Sofía Blanco',  'sofia@mail.com',  'Salta',        '2024-03-25');
 
-- productos — 8 registros
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES
  (1, 'Laptop Pro 15',      1, 1200.00, 15, TRUE),
  (2, 'Mouse Inalámbrico',  2,   28.00, 80, TRUE),
  (3, 'Monitor 4K 27',      1,  450.00, 12, TRUE),
  (4, 'Auriculares BT Pro', 3,  120.00, 35, TRUE),
  (5, 'SSD Externo 1TB',    4,  130.00, 18, TRUE),
  (6, 'Teclado Mecánico',   2,   95.00, 40, TRUE),
  (7, 'Webcam HD 1080',     2,   65.00, 25, TRUE),
  (8, 'Parlante Bluetooth', 3,   85.00, 30, TRUE);
 
-- ventas — 10 registros (con id_region incluida)
INSERT INTO ventas (id_venta, id_cliente, id_producto, id_region, cantidad, precio_unitario, fecha_venta) VALUES
  ( 1, 1, 1, 1, 2, 1200.00, '2024-03-05'),
  ( 2, 2, 2, 1, 5,   28.00, '2024-03-06'),
  ( 3, 3, 3, 3, 1,  450.00, '2024-03-07'),
  ( 4, 1, 4, 1, 2,  120.00, '2024-03-08'),
  ( 5, 4, 5, 2, 3,  130.00, '2024-03-10'),
  ( 6, 2, 6, 1, 4,   95.00, '2024-03-11'),
  ( 7, 5, 1, 2, 1, 1200.00, '2024-03-12'),
  ( 8, 3, 2, 3, 8,   28.00, '2024-03-13'),
  ( 9, 4, 4, 2, 1,  120.00, '2024-03-14'),
  (10, 5, 3, 2, 2,  450.00, '2024-03-15');



SELECT * FROM categorias;   -- esperado: 4 filas
SELECT * FROM regiones;     -- esperado: 3 filas
SELECT * FROM clientes;     -- esperado: 7 filas
SELECT * FROM productos;    -- esperado: 8 filas
SELECT * FROM ventas;       -- esperado: 10 filas
