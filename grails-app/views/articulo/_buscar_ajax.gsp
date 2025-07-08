<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${articulos && articulos.size() > 0}">
    <tr data-total="${totalSQL}" style="display:none"></tr>
    <g:each in="${articulos}" var="articulo">
        <tr data-id="${articulo.id}">
            <td>
                <strong>${articulo.nombre ?: ''}</strong>
            </td>
            <td>
                ${articulo.tipoAccesorio?.tipoDeAccesorio ?: ''}
            </td>
            <td>
                ${articulo.precioBase ?: ''}
            </td>
            <td>
                <div class="btn-group btn-group-sm" role="group">
                    <a href="#" data-id="${articulo.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a href="#" data-id="${articulo.id}" class="btn btn-danger btn-sm btn-borrar btn-ajax" title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                    <a href="#" data-id="${articulo.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                        <i class="fa fa-eye"></i>
                    </a>
                </div>
            </td>
        </tr>
    </g:each>
</g:if>
<g:else>
    <tr class="danger">
        <td class="text-center" colspan="4">
            <i class="fa fa-exclamation-triangle"></i> No se encontraron registros que mostrar
        </td>
    </tr>
</g:else>
