<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Mis Facturas</title>
    <meta name="layout" content="main">
</head>
<body>
    <h2>Mis Facturas</h2>
    <!-- Formulario para filtrar por rango de fechas -->
    <form method="get" style="margin-bottom: 18px;">
        <label for="fechaInicio">Desde:</label>
        <input type="date" name="fechaInicio" id="fechaInicio" value="${params.fechaInicio ?: ''}" style="margin-right: 12px;"/>
        <label for="fechaFin">Hasta:</label>
        <input type="date" name="fechaFin" id="fechaFin" value="${params.fechaFin ?: ''}" style="margin-right: 12px;"/>
        <button type="submit" class="btn btn-primary btn-sm">Filtrar</button>
        <a href="${createLink(controller: 'cliente', action: 'facturas')}" class="btn btn-default btn-sm">Limpiar</a>
    </form>
    <g:if test="${flash.message}">
        <div class="alert alert-warning">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Fecha de Emisión</th>
                <th>Total</th>
                <th>Pedido</th>
                <th>Detalle</th>
            </tr>
        </thead> 
        <tbody>
            <g:each in="${facturas}" var="factura">
                <tr>
                    <td>${factura.id}</td>
                    <td>${factura.fechaEmision?.format('dd/MM/yyyy')}</td>
                    <td>$${factura.total}</td>
                    <td>${factura.pedido?.id}</td>
                    <td>
                        <g:link controller="cliente" action="verFactura" id="${factura.id}" class="btn btn-info btn-sm">
                            Ver Detalle
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <a href="${createLink(controller: 'cliente', action: 'index')}" class="btn btn-secondary">Volver</a>
</body>
</html>
