<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Factura #${factura.id}</title>
    <meta name="layout" content="main">
    <style>
        .factura-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .factura-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #007bff;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        
        .empresa-info h1 {
            color: #007bff;
            font-size: 28px;
            margin: 0;
            font-weight: bold;
        }
        
        .empresa-info p {
            margin: 2px 0;
            color: #666;
            font-size: 14px;
        }
        
        .factura-numero {
            text-align: right;
        }
        
        .factura-numero h2 {
            color: #333;
            font-size: 24px;
            margin: 0;
        }
        
        .factura-numero p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .info-section h4 {
            color: #007bff;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 8px;
            margin-bottom: 15px;
            font-size: 16px;
        }
        
        .info-section p {
            margin: 5px 0;
            color: #333;
            font-size: 14px;
        }
        
        .info-section strong {
            color: #495057;
            font-weight: 600;
        }
        
        .productos-section {
            margin-bottom: 30px;
        }
        
        .productos-section h4 {
            color: #007bff;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 8px;
            margin-bottom: 20px;
            font-size: 16px;
        }
        
        .productos-tabla {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .productos-tabla th {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 12px 8px;
            text-align: left;
            font-weight: 600;
            border: none;
        }
        
        .productos-tabla td {
            padding: 12px 8px;
            border-bottom: 1px solid #e9ecef;
            color: #333;
        }
        
        .productos-tabla tr:hover {
            background-color: #f8f9fa;
        }
        
        .productos-tabla .text-right {
            text-align: right;
        }
        
        .totales-section {
            margin-left: auto;
            width: 300px;
            margin-bottom: 30px;
        }
        
        .totales-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .totales-table td {
            padding: 8px 12px;
            border-bottom: 1px solid #e9ecef;
            font-size: 14px;
        }
        
        .totales-table .total-row {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            font-weight: bold;
            font-size: 16px;
        }
        
        .totales-table .total-row td {
            border: none;
        }
        
        .acciones {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .btn-profesional {
            padding: 12px 24px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            color: white;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            color: white;
        }
        
        .factura-footer {
            text-align: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
            color: #666;
            font-size: 12px;
        }
        
        @media print {
            .factura-container {
                box-shadow: none;
                border: none;
                margin: 0;
                padding: 20px;
            }
            .acciones {
                display: none;
            }
        }
        
        @media (max-width: 768px) {
            .factura-header {
                flex-direction: column;
                text-align: center;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .totales-section {
                width: 100%;
                margin-left: 0;
            }
            
            .acciones {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="factura-container">
        <!-- Encabezado empresa -->
        <div class="factura-header">
            <div class="empresa-info">
                <h1>${datosEmpresa.nombre}</h1>
                <p><strong>Dirección:</strong> ${datosEmpresa.direccion}</p>
                <p><strong>Teléfono:</strong> ${datosEmpresa.telefono}</p>
                <p><strong>Email:</strong> ${datosEmpresa.email}</p>
                <p><strong>RUC:</strong> ${datosEmpresa.ruc}</p>
            </div>
            <div class="factura-numero">
                <h2>FACTURA</h2>
                <p><strong>N°:</strong> ${factura.id}</p>
                <p><strong>Fecha:</strong> ${factura.fechaEmision?.format('dd/MM/yyyy')}</p>
                <p><strong>Estado:</strong> <span class="badge badge-success">PAGADA</span></p>
            </div>
        </div>

        <!-- Información de factura y cliente -->
        <div class="info-grid">
            <div class="info-section">
                <h4><i class="fa fa-building"></i> Información de la Empresa</h4>
                <p><strong>Razón Social:</strong> ${datosEmpresa.nombre}</p>
                <p><strong>RUC:</strong> ${datosEmpresa.ruc}</p>
                <p><strong>Dirección:</strong> ${datosEmpresa.direccion}</p>
                <p><strong>Teléfono:</strong> ${datosEmpresa.telefono}</p>
                <p><strong>Email:</strong> ${datosEmpresa.email}</p>
            </div>
            
            <div class="info-section">
                <h4><i class="fa fa-user"></i> Datos del Cliente</h4>
                <p><strong>Nombre:</strong> ${factura.pedido.persona.nombre} ${factura.pedido.persona.apellido}</p>
                <p><strong>Cédula:</strong> ${factura.pedido.persona.cedula}</p>
                <p><strong>Teléfono:</strong> ${factura.pedido.persona.telefono ?: 'No especificado'}</p>
                <p><strong>Email:</strong> ${factura.pedido.persona.mail ?: 'No especificado'}</p>
                <p><strong>Dirección:</strong> ${factura.pedido.persona.direccion ?: 'No especificada'}</p>
            </div>
        </div>

        <!-- Tabla de productos -->
        <div class="productos-section">
            <h4><i class="fa fa-shopping-cart"></i> Detalle de Productos</h4>
            <table class="productos-tabla">
                <thead>
                    <tr>
                        <th>Descripción</th>
                        <th class="text-right">Cantidad</th>
                        <th class="text-right">Precio Unit.</th>
                        <th class="text-right">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${factura.detalles}" var="det">
                        <tr>
                            <td>
                                <strong>${det.articulo?.nombre}</strong>
                                <g:if test="${det.articulo?.descripcion}">
                                    <br><small class="text-muted">${det.articulo.descripcion}</small>
                                </g:if>
                            </td>
                            <td class="text-right">${det.cantidad}</td>
                            <td class="text-right">$<g:formatNumber number="${det.precioUnitario}" type="currency" currencyCode="USD"/></td>
                            <td class="text-right">$<g:formatNumber number="${det.subtotal}" type="currency" currencyCode="USD"/></td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>

        <!-- Totales -->
        <div class="totales-section">
            <table class="totales-table">
                <tr>
                    <td><strong>Subtotal:</strong></td>
                    <td class="text-right">$<g:formatNumber number="${factura.total}" type="currency" currencyCode="USD"/></td>
                </tr>
                <tr>
                    <td><strong>Impuestos:</strong></td>
                    <td class="text-right">$0.00</td>
                </tr>
                <tr class="total-row">
                    <td><strong>TOTAL:</strong></td>
                    <td class="text-right">$<g:formatNumber number="${factura.total}" type="currency" currencyCode="USD"/></td>
                </tr>
            </table>
        </div>

        <!-- Botones de acción -->
        <div class="acciones">
            <a href="${createLink(action: 'facturas')}" class="btn-profesional btn-secondary">
                <i class="fa fa-arrow-left"></i> Volver a Facturas
            </a>
            <a href="#" class="btn-profesional btn-danger" onclick="window.print()">
                <i class="fa fa-print"></i> Imprimir Factura
            </a>
        </div>

        <!-- Pie de factura -->
        <div class="factura-footer">
            <p><strong>Términos y Condiciones:</strong> Esta factura debe ser pagada dentro de los 30 días siguientes a su emisión.</p>
            <p>Para cualquier consulta, comuníquese con nosotros al ${datosEmpresa.telefono} o ${datosEmpresa.email}</p>
            <p><small>Gracias por su preferencia - ${datosEmpresa.nombre}</small></p>
        </div>
    </div>
</body>
</html>
