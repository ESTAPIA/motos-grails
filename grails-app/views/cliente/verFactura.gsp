<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Detalle de Factura</title>
    <meta name="layout" content="main">
</head>
<body>
    <h2>Factura #${factura.id}</h2>
    <p><strong>Fecha de emisión:</strong> ${factura.fechaEmision?.format('dd/MM/yyyy')}</p>
    <p><strong>Total:</strong> $${factura.total}</p>
    <h4>Detalle:</h4>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Artículo</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${factura.detalles}" var="det">
                <tr>
                    <td>${det.articulo?.nombre}</td>
                    <td>${det.cantidad}</td>
                    <td>$${det.precioUnitario}</td>
                    <td>$${det.subtotal}</td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <a href="${createLink(controller: 'cliente', action: 'facturas')}" class="btn btn-secondary">Volver</a>
</body>
</html>
