<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${pedidos && pedidos.size() > 0}">
    <tr data-total="${totalSQL}" style="display:none"></tr>
    <g:each in="${pedidos}" var="pedido">
        <tr>
            <td>${pedido.id}</td>
            <td>${pedido.persona?.nombre} ${pedido.persona?.apellido}</td>
            <td>${pedido.fechaPedido?.format('dd/MM/yyyy')}</td>
            <td>${pedido.estado}</td>
            <td>
                <a href="#" class="btn btn-info btn-sm btn-show" data-id="${pedido.id}">
                    <i class="fa fa-eye"></i> Ver
                </a>
            </td>
        </tr>
    </g:each>
</g:if>
<g:else>
    <tr class="danger">
        <td class="text-center" colspan="5">
            <i class="fa fa-exclamation-triangle"></i> No se encontraron registros que mostrar
        </td>
    </tr>
</g:else>
