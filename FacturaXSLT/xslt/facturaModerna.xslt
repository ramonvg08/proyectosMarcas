<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
        <head>
            <title>Factura Electrónica - Estilo Corporativo</title>
            <style>
                body {
                    font-family: 'Arial', sans-serif;
                    background-color: #f4f7f9;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }

                .invoice-box {
                    width: 700px;
                    background: white;
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                }

                h2 {
                    text-align: center;
                    color: #2980b9;
                    border-bottom: 2px solid #2980b9;
                    padding-bottom: 10px;
                    margin-bottom: 20px;
                }

                .header, .client-info {
                    margin-bottom: 20px;
                    padding: 15px;
                    background-color: #ecf0f1;
                    border-radius: 8px;
                }

                .header strong, .client-info strong {
                    color: #2980b9;
                }

                .header div, .client-info div {
                    margin-bottom: 10px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }

                table, th, td {
                    border: 1px solid #ddd;
                    padding: 12px;
                    text-align: center;
                    background-color: #f9f9f9;
                }

                th {
                    background-color: #2980b9;
                    color: white;
                    text-transform: uppercase;
                }

                .totals {
                    display: flex;
                    flex-direction: column;
                    gap: 15px;
                    margin-top: 30px;
                    font-size: 1.2em;
                    font-weight: bold;
                    text-align: left;
                }

                .totals-item {
                    display: flex;
                    justify-content: space-between;
                    padding: 10px 0;
                    background-color: #ecf0f1;
                    border-radius: 8px;
                    border-bottom: 1px solid #dcdfe1;
                }

                .totals-item strong {
                    color: #2980b9;
                }

                .totals-item span {
                    color: #333;
                }

                .total-amount {
                    background-color: #27ae60;
                    color: white;
                    font-size: 1.5em;
                    padding: 15px 30px;
                    border-radius: 15px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    font-weight: bold;
                    display: flex;
                    justify-content: space-between;
                    margin-top: 20px;
                }
            </style>
        </head>
        <body>
            <div class="invoice-box">
                <h2>Factura Electrónica</h2>

                <div class="header">
                    <div><strong>Empresa:</strong> <xsl:value-of select="Factura/Emisor/Nombre" /></div>
                    <div><strong>NIF:</strong> <xsl:value-of select="Factura/Emisor/NIF" /></div>
                    <div><strong>Fecha:</strong> <xsl:value-of select="Factura/Detalles/Fecha" /></div>
                </div>

                <div class="client-info">
                    <div><strong>Cliente:</strong> <xsl:value-of select="Factura/Receptor/Nombre" /></div>
                    <div><strong>Dirección:</strong> <xsl:value-of select="Factura/Receptor/Direccion" /></div>
                </div>

                <table>
                    <tr>
                        <th>Descripción</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                        <th>Subtotal</th>
                    </tr>
                    <xsl:for-each select="Factura/Productos/Producto">
                        <tr>
                            <td><xsl:value-of select="Descripcion" /></td>
                            <td><xsl:value-of select="Cantidad" /></td>
                            <td><xsl:value-of select="PrecioUnitario" /> €</td>
                            <td><xsl:value-of select="Total" /> €</td>
                        </tr>
                    </xsl:for-each>
                </table>

                <div class="totals">
                    <div class="totals-item">
                        <strong>Subtotal:</strong>
                        <span><xsl:value-of select="Factura/Totales/Subtotal" /> €</span>
                    </div>
                    <div class="totals-item">
                        <strong>IVA:</strong>
                        <span><xsl:value-of select="Factura/Totales/IVA" /> €</span>
                    </div>
                    <div class="totals-item">
                        <strong>Total:</strong>
                        <span><xsl:value-of select="Factura/Totales/TotalFactura" /> €</span>
                    </div>
                </div>

                <div class="total-amount">
                    <strong>Total a Pagar:</strong>
                    <span><xsl:value-of select="Factura/Totales/TotalFactura" /> €</span>
                </div>
            </div>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
