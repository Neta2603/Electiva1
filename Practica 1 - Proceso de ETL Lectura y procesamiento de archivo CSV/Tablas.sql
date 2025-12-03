USE SistemaPedidosVenta;
GO

CREATE SCHEMA ventas;
GO

-- 3. Creación de la tabla Productos en el esquema ventas y en el filegroup "Currrent"
CREATE TABLE ventas.Productos
(
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    InventarioDisponible INT NOT NULL,
    Coste DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL
)
ON Currrent;  -- Se especifica el filegroup "Currrent"
GO

-- 4. Creación de la tabla Clientes en el esquema ventas y en el filegroup "Currrent"
CREATE TABLE ventas.Clientes
(
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCompleto NVARCHAR(150) NOT NULL,
    Direccion NVARCHAR(250) NOT NULL,
    CalificacionCredito TINYINT NOT NULL  -- Por ejemplo, del 1 al 10
)
ON Currrent;
GO

-- 5. Creación de la tabla Facturas (cabecera) en el esquema ventas y en el filegroup "Currrent"
CREATE TABLE ventas.Facturas
(
    FacturaID INT IDENTITY(1,1) PRIMARY KEY,
    NumeroFactura NVARCHAR(50) NOT NULL UNIQUE,
    FechaFactura DATE NOT NULL,
    ClienteID INT NOT NULL,
    Comercial NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Facturas_Clientes FOREIGN KEY (ClienteID)
         REFERENCES ventas.Clientes(ClienteID)
)
ON Currrent;
GO

-- 6. Creación de la tabla FacturaDetalles en el esquema ventas y en el filegroup "History"
CREATE TABLE ventas.FacturaDetalles
(
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    FacturaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    Coste DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_FacturaDetalles_Facturas FOREIGN KEY (FacturaID)
         REFERENCES ventas.Facturas(FacturaID),
    CONSTRAINT FK_FacturaDetalles_Productos FOREIGN KEY (ProductoID)
         REFERENCES ventas.Productos(ProductoID)
)
ON History;
GO