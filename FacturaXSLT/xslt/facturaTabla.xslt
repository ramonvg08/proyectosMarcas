<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Factura - <xsl:value-of select="/Factura/Detalles/Numero"/></title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 40px; }
                    .factura-container { max-width: 700px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
                    h2, h3 { color: #333; text-align: center; }
                    .info { display: flex; justify-content: space-between; margin-bottom: 20px; }
                    .info div { width: 48%; }
                    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
                    th { background-color: #f4f4f4; }
                    .totales { text-align: right; margin-top: 20px; }
                    .totales p { font-size: 16px; margin: 5px 0; }
                    .total-final { font-size: 18px; font-weight: bold; color: #d9534f; }
                </style>
            </head>
            <body>
                <div class="factura-container">
                    <h2>Factura: <xsl:value-of select="/Factura/Detalles/Numero"/></h2>
                    <h3>Fecha: <xsl:value-of select="/Factura/Detalles/Fecha"/></h3>

                    <div class="info">
                        <div>
                            <h3>Emisor</h3>
                            <p><strong>Nombre:</strong> <xsl:value-of select="/Factura/Emisor/Nombre"/></p>
                            <p><strong>NIF:</strong> <xsl:value-of select="/Factura/Emisor/NIF"/></p>
                            <p><strong>Dirección:</strong> <xsl:value-of select="/Factura/Emisor/Direccion"/></p>
                        </div>
                        <div>
                            <h3>Receptor</h3>
                            <p><strong>Nombre:</strong> <xsl:value-of select="/Factura/Receptor/Nombre"/></p>
                            <p><strong>NIF:</strong> <xsl:value-of select="/Factura/Receptor/NIF"/></p>
                            <p><strong>Dirección:</strong> <xsl:value-of select="/Factura/Receptor/Direccion"/></p>
                        </div>
                    </div>

                    <h3>Productos</h3>
                    <table>
                        <tr>
                            <th>Descripción</th>
                            <th>Cantidad</th>
                            <th>Precio Unitario (€)</th>
                            <th>Total (€)</th>
                        </tr>
                        <xsl:for-each select="/Factura/Productos/Producto">
                            <tr>
                                <td><xsl:value-of select="Descripcion"/></td>
                                <td><xsl:value-of select="Cantidad"/></td>
                                <td><xsl:value-of select="PrecioUnitario"/></td>
                                <td><xsl:value-of select="Total"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>

                    <div class="totales">
                        <p><strong>Subtotal:</strong> <xsl:value-of select="/Factura/Totales/Subtotal"/> €</p>
                        <p><strong>IVA:</strong> <xsl:value-of select="/Factura/Totales/IVA"/> €</p>
                        <p class="total-final"><strong>Total a Pagar:</strong> <xsl:value-of select="/Factura/Totales/TotalFactura"/> €</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
