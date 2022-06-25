USE Estudiante_39;
------------ Modelo de Hecho_Movimiento

CREATE TABLE Producto (
ID_Producto SMALLINT, 
Nombre VARCHAR(100),
Marca VARCHAR(30), 
Paquete_de_compra VARCHAR(20), 
Color VARCHAR(10), 
Necesita_refrigeracion BOOLEAN, 
Dias_tiempo_entrega SMALLINT, 
cantidad_por_salida INT, 
Precio_minorista_recomendado FLOAT, 
Paquete_de_venta VARCHAR(20), 
Precio_unitario FLOAT,
PRIMARY KEY(ID_Producto));

CREATE TABLE Fecha (
Fecha DATETIME, 
Dia TINYINT, 
Mes VARCHAR(20), 
Anio SMALLINT,
Numero_semana_ISO TINYINT,
PRIMARY KEY(Fecha));

CREATE TABLE TipoTransaccion (
ID_Tipo_transaccion TINYINT, 
Tipo VARCHAR(20) ,
PRIMARY KEY(ID_Tipo_transaccion));

CREATE TABLE Proveedor (
ID_Proveedor INT, 
Nombre VARCHAR(20),
Categoria VARCHAR(20),
Contacto_principal VARCHAR(30),
Referencia VARCHAR(30),  
Dias_pago INT,
Codigo_postal INT,
PRIMARY KEY(ID_Proveedor));

CREATE TABLE Cliente (
ID_Cliente INT, 
Cliente_Factura INT,
Categoria VARCHAR(20),
Nombre VARCHAR(20),
Codigo_postal INT,
Contacto_principal VARCHAR(30),
PRIMARY KEY(ID_Cliente));

CREATE TABLE Movimiento (
Fecha_movimiento DATETIME,
ID_Producto SMALLINT,
ID_Proveedor INT,  
ID_Cliente INT,
ID_Tipo_transaccion TINYINT,
Cantidad INT,
PRIMARY KEY(ID_Producto,Fecha_movimiento, ID_Proveedor, ID_Cliente, ID_Tipo_transaccion));

------- Registro de fechas
INSERT INTO Fecha 
    ( Fecha, Dia, Mes, Anio, Numero_semana_ISO )
VALUES 
    ( '2022-06-20 12:45:56', 20, 'Jun', 2022, 6),
    ( '2022-06-24 12:45:56', 24, 'Jun', 2022, 6);
    
------- Registro de TipoTransaccion
INSERT INTO TipoTransaccion 
    ( ID_Tipo_transaccion, Tipo )
VALUES 
    ( 1,  'Entrada'),
    ( 2,  'Salida');
    
------- Registro de Clientes
------- Se crea un cliente 0 que representara un movimiento "Sin Cliente"


INSERT INTO Cliente 
    ( ID_Cliente, Cliente_Factura, Categoria, Nombre, Codigo_postal, Contacto_principal )
VALUES 
    ( 0,  0, '', '', 0, ''),
    ( 1,  1044235, 'Individual', 'Wenceslao Paez', 12001, 'wcpaez@gmail.com'),
    ( 2,  2056890, 'Empresa', 'Empresa Peruana', 12001, 'contacto@empresaperuana.com');
    
------- Registro de Proveedores
------- Se crea un proveedor 0 que representara un movimiento "Sin Proveedor"

INSERT INTO Proveedor 
    ( ID_Proveedor, Nombre, Categoria, Contacto_principal, Referencia, Dias_pago, Codigo_postal )
VALUES 
    ( 0,  '', '', '', '', 0, 0),
    ( 1,  'Procter & Gamble', 'Higiene', 'Raul Dian', 'prov-1', 10, 12001),
    ( 2,  'Backus', 'Bebidas', 'Maria Chavez', 'prov-2', 100, 12002);
    
------- Registro de Productos  
INSERT INTO Producto 
    ( ID_Producto, Nombre, Marca, Paquete_de_compra, Color, Necesita_refrigeracion, Dias_tiempo_entrega, cantidad_por_salida, Precio_minorista_recomendado, Paquete_de_venta, Precio_unitario  ) 
VALUES 
    ( 20, 'Desodorante Roll Old Spice', 'Old Spice', 'Each', 'Rojo', False, 14, 10, 6.13, 'Each', 4.10),
    ( 21, 'Cerveza Budweiser', 'Budweiser', 'Sixpack', 'Rojo', True, 5, 6, 25.5, 'Sixpack', 30.10);
    
------- Registro de Movimientos
------- Los ingresos no tienen cliente, se representa con 0
------- Las salidas no tienen proveedor, se representa con 0
INSERT INTO Movimiento
    ( Fecha_movimiento, ID_Producto, ID_Proveedor, ID_Cliente, ID_Tipo_transaccion, Cantidad )
VALUES 
    ( '2022-06-20 12:45:56',  20, 1, 0, 1, 100),
    ( '2022-06-24 12:45:56',  21, 0, 1, 2, -1500);


------- Visualizar el número de productos que se movieron en el inventario en un rango de fechas por cliente, proveedor, y/o tipo de transacció  
SELECT 
    Fecha_movimiento, 
    productos.Nombre AS producto,
    clientes.Nombre AS cliente,
    proveedores.Nombre AS proveedor,
    tipo_transacciones.Tipo AS tipo_transaccion,
    Cantidad    
FROM 
    Estudiante_39.Movimiento AS movimientos, 
    Estudiante_39.Producto AS productos,
    Estudiante_39.Cliente AS clientes, 
    Estudiante_39.Proveedor AS proveedores, 
    Estudiante_39.TipoTransaccion AS tipo_transacciones 
WHERE 
    movimientos.Fecha_movimiento BETWEEN '2022-06-19' AND '2022-06-25' 
    AND movimientos.ID_Producto = productos.ID_Producto
    AND movimientos.ID_Cliente = clientes.ID_Cliente
    AND movimientos.ID_Proveedor = proveedores.ID_Proveedor
    AND movimientos.ID_Tipo_transaccion = tipo_transacciones.ID_Tipo_transaccion;   
    
    
 


