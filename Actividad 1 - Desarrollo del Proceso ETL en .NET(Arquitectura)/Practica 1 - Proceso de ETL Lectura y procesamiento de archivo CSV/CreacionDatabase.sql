-- Creación de la base de datos con el archivo primario (mdf) y log (ldf)
CREATE DATABASE SistemaPedidosVenta
ON PRIMARY
(
    NAME = 'SistemaPedidosVenta_Data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaPedidosVenta_Data.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON
(
    NAME = 'SistemaPedidosVenta_Log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaPedidosVenta_Log.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
);
GO

-- Agregar filegroup para datos actuales
ALTER DATABASE SistemaPedidosVenta ADD FILEGROUP Currrent;
GO

-- Agregar un archivo de datos al filegroup Current (ndf)
ALTER DATABASE SistemaPedidosVenta
ADD FILE
(
    NAME = 'SistemaPedidosVenta_Currrent_Data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaPedidosVenta_Currrent_Data.ndf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP Currrent;
GO


-- Agregar filegroup para datos históricos
ALTER DATABASE SistemaPedidosVenta ADD FILEGROUP History;
GO

-- Agregar un archivo de datos al filegroup histórico (ndf)
ALTER DATABASE SistemaPedidosVenta
ADD FILE
(
    NAME = 'SistemaPedidosVenta_History_Data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaPedidosVenta_History_Data.ndf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP History;
GO
