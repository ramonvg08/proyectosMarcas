<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
        <head>
            <title>Factura Electrónica - Estilo Ticket</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Courier New', Courier, monospace;
                    background-color: #f8f8f8;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    padding: 20px;
                    height: 100vh;
                    margin: 0;
                }

                .ticket {
                    width: 300px;
                    padding: 20px;
                    background-color: #ffffff;
                    border: 1px solid #ccc;
                    border-radius: 8px;
                    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                    font-size: 0.9em;
                }

                h2 {
                    text-align: center;
                    font-size: 1.5em;
                    margin-bottom: 10px;
                    color: #333;
                }

                .header, .footer {
                    text-align: center;
                    margin-bottom: 15px;
                    font-weight: bold;
                    color: #333;
                }

                .header {
                    font-size: 1.1em;
                }

                .footer {
                    font-size: 0.8em;
                    color: #777;
                }

                .details {
                    margin-bottom: 20px;
                    font-size: 0.9em;
                }

                .details div {
                    margin-bottom: 8px;
                }

                .line-items {
                    margin-bottom: 20px;
                }

                .line-items div {
                    display: flex;
                    justify-content: space-between;
                    padding: 5px 0;
                    border-bottom: 1px dashed #ccc;
                }

                .line-items .total {
                    font-weight: bold;
                }

                .total {
                    font-size: 1.2em;
                    text-align: right;
                    font-weight: bold;
                    margin-top: 15px;
                }

                .total span {
                    display: inline-block;
                    width: 80%;
                    text-align: left;
                }

                .total .amount {
                    width: 20%;
                    text-align: right;
                }

                .divider {
                    border-top: 1px solid #ccc;
                    margin: 10px 0;
                }
            </style>
        </head>
        <body>
            <div class="ticket">
                <!-- Título -->
                <h2>Factura Electrónica</h2>

                <!-- Encabezado: Empresa -->
                <div class="header">
                    <xsl:value-of select="/Factura/Emisor/Nombre"/>
                    <br/>
                    <xsl:value-of select="/Factura/Emisor/NIF"/>
                </div>

                <!-- Datos del Cliente -->
                <div class="details">
                    <div><strong>Cliente:</strong> <xsl:value-of select="/Factura/Receptor/Nombre"/></div>
                    <div><strong>Dirección:</strong> <xsl:value-of select="/Factura/Receptor/Direccion"/></div>
                    <div><strong>Fecha:</strong> <xsl:value-of select="/Factura/Detalles/Fecha"/></div>
                    <div><strong>Factura No:</strong> <xsl:value-of select="/Factura/Detalles/Numero"/></div>
                </div>

                <!-- Productos -->
                <div class="line-items">
                    <xsl:for-each select="/Factura/Productos/Producto">
                        <div>
                            <span><xsl:value-of select="Descripcion"/></span>
                            <span><xsl:value-of select="Cantidad"/></span>
                            <span><xsl:value-of select="PrecioUnitario"/> €</span>
                            <span><xsl:value-of select="Total"/> €</span>
                        </div>
                    </xsl:for-each>
                </div>

                <!-- Divisor -->
                <div class="divider"></div>

                <!-- Total -->
                <div class="total">
                    <div><span>Subtotal:</span> <span class="amount"><xsl:value-of select="/Factura/Totales/Subtotal"/> €</span></div>
                    <div><span>IVA:</span> <span class="amount"><xsl:value-of select="/Factura/Totales/IVA"/> €</span></div>
                    <div><span>Total:</span> <span class="amount"><xsl:value-of select="/Factura/Totales/TotalFactura"/> €</span></div>
                </div>

                <!-- Pie de página -->
                <div class="footer">
                    <p>¡Gracias por su compra!</p>
                    <p>www.empresa.com</p>
                </div>
            </div>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
