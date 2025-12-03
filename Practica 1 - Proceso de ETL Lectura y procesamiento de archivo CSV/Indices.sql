USE SistemaPedidosVenta
GO

CREATE NONCLUSTERED INDEX IDX_Facturas_FechaFactura
ON ventas.Facturas(FechaFactura)
ON Currrent;
GO

CREATE NONCLUSTERED INDEX IDX_Clientes_CalificacionCredito
ON ventas.Clientes(CalificacionCredito)
ON Currrent;
GO

CREATE NONCLUSTERED INDEX IDX_Productos_Nombre
ON ventas.Productos(Nombre)
ON Currrent;
GO