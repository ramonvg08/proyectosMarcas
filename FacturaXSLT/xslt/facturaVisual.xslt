<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Factura Electrónica</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; padding: 20px; color: #333; }
                    .container { width: 80%; margin: auto; border: 1px solid #ddd; padding: 20px; border-radius: 10px; box-shadow: 2px 2px 12px #aaa; }
                    .header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 10px; }
                    .section { margin-top: 20px; }
                    .title { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
                    .factura-info, .cliente-info { background: #f9f9f9; padding: 10px; border-radius: 5px; }
                    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
                    th, td { border: 1px solid black; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                    td { text-align: right; }
                    .total { font-weight: bold; text-align: right; }
                    .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #777; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Factura Electrónica</h1>
                    </div>
                    <!-- Datos de la Factura -->
                    <div class="section factura-info">
                        <div class="title">Datos de la Factura</div>
                        <p><strong>Número:</strong> <xsl:value-of select="/Factura/Detalles/Numero"/></p>
                        <p><strong>Fecha:</strong> <xsl:value-of select="/Factura/Detalles/Fecha"/></p>
                    </div>
                    <!-- Información del Emisor -->
                    <div class="section emisor-info">
                        <div class="title">Datos del Emisor</div>
                        <p><strong>Nombre:</strong> <xsl:value-of select="/Factura/Emisor/Nombre"/></p>
                        <p><strong>NIF:</strong> <xsl:value-of select="/Factura/Emisor/NIF"/></p>
                        <p><strong>Dirección:</strong> <xsl:value-of select="/Factura/Emisor/Direccion"/></p>
                    </div>
                    <!-- Información del Receptor -->
                    <div class="section receptor-info">
                        <div class="title">Datos del Receptor</div>
                        <p><strong>Nombre:</strong> <xsl:value-of select="/Factura/Receptor/Nombre"/></p>
                        <p><strong>NIF:</strong> <xsl:value-of select="/Factura/Receptor/NIF"/></p>
                        <p><strong>Dirección:</strong> <xsl:value-of select="/Factura/Receptor/Direccion"/></p>
                    </div>
                    <!-- Detalles de los Productos -->
                    <div class="section productos-info">
                        <div class="title">Detalles de los Productos</div>
                        <table>
                            <tr>
                                <th>Descripción</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Total</th>
                            </tr>
                            <xsl:for-each select="/Factura/Productos/Producto">
                                <tr>
                                    <td><xsl:value-of select="Descripcion"/></td>
                                    <td><xsl:value-of select="Cantidad"/></td>
                                    <td><xsl:value-of select="PrecioUnitario"/> €</td>
                                    <td><xsl:value-of select="Total"/> €</td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                    <!-- Totales de la Factura -->
                    <div class="section totales-info">
                        <div class="title">Totales</div>
                        <p><strong>Subtotal:</strong> <xsl:value-of select="/Factura/Totales/Subtotal"/> €</p>
                        <p><strong>IVA:</strong> <xsl:value-of select="/Factura/Totales/IVA"/> €</p>
                        <p><strong>Total Factura:</strong> <xsl:value-of select="/Factura/Totales/TotalFactura"/> €</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
