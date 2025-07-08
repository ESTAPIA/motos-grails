<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${facturas && facturas.size() > 0}">
    <tr data-total="${totalSQL}" style="display:none"></tr>
    <g:each in="${facturas}" var="factura">
        <tr>
            <td>${factura.id}</td>
            <td>${factura.pedido?.id}</td>
            <td>${factura.fechaEmision?.format('dd/MM/yyyy')}</td>
            <td>$${factura.total}</td>
            <td>
                <a href="#" class="btn btn-info btn-sm btn-show" data-id="${factura.id}">
                    <i class="fa fa-eye"></i> Ver
                </a>
                <a href="#" class="btn btn-danger btn-sm btn-borrar" data-id="${factura.id}">
                    <i class="fa fa-trash"></i> Eliminar
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
