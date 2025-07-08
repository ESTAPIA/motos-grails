<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Mis Pedidos</title>
    <meta name="layout" content="main">
</head>
<body>
    <h2>Mis Pedidos</h2>
    <!-- Formulario para filtrar por estado -->
    <form method="get" style="margin-bottom: 18px;">
        <label for="estado">Filtrar por estado:</label>
        <select name="estado" id="estado" onchange="this.form.submit()" style="margin-left: 8px;">
            <option value="">Todos</option>
            <option value="PENDIENTE" ${params.estado == 'PENDIENTE' ? 'selected' : ''}>Pendiente</option>
            <option value="CONFIRMADO" ${params.estado == 'CONFIRMADO' ? 'selected' : ''}>Confirmado</option>
        </select>
    </form>
    <g:if test="${flash.message}">
        <div class="alert alert-success">${flash.message}</div>
    </g:if>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Fecha</th>
                <th>Estado</th>
                <th>Detalle</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${pedidos}" var="pedido">
                <tr>
                    <td>${pedido.id}</td>
                    <td>${pedido.fechaPedido?.format('dd/MM/yyyy')}</td>
                    <td>${pedido.estado}</td>
                    <td>
                        <ul>
                            <g:each in="${pedido.detalles}" var="det">
                                <li>
                                    ${det.cantidad} x ${det.articulo?.nombre} @ $${det.precioUnitario}
                                    <br>
                                    <span style="font-size: 12px; color: #888;">
                                        Stock actual: ${det.articulo?.stock} |
                                        Tipo: ${det.articulo?.tipoAccesorio}
                                    </span>
                                </li>
                            </g:each>
                        </ul>
                    </td>
                    <td>
                        <g:if test="${pedido.estado == 'PENDIENTE'}">
                            <g:link controller="cliente" action="confirmarPedido" id="${pedido.id}" class="btn btn-success btn-sm">
                                Confirmar
                            </g:link>
                        </g:if>
                        <g:if test="${pedido.estado == 'CONFIRMADO'}">
                            <g:set var="factura" value="${facturasPorPedido[pedido.id]}"/>
                            <g:if test="${factura}">
                                <g:link controller="cliente" action="verFactura" id="${factura.id}" class="btn btn-info btn-sm" style="margin-left: 4px;">
                                    Ver Factura
                                </g:link>
                            </g:if>
                        </g:if>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <a href="${createLink(controller: 'cliente', action: 'index')}" class="btn btn-secondary">Volver</a>
</body>
</html>
