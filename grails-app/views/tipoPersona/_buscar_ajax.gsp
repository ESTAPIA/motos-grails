<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${tipoPersonas && tipoPersonas.size() > 0}">
    <g:each in="${tipoPersonas}" var="tipo">
        <tr data-id="${tipo.id}">
            <td>
                <span class="nombre-tipo">
                    ${tipo.descripcion ?: ''}
                </span>
            </td>
            <td>
                <div class="btn-group btn-group-sm" role="group">
                    <a href="#" data-id="${tipo.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a href="#" data-id="${tipo.id}" class="btn btn-danger btn-sm btn-borrar btn-ajax" title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                    <a href="#" data-id="${tipo.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                        <i class="fa fa-eye"></i>
                    </a>
                </div>
            </td>
        </tr>
    </g:each>
</g:if>
<g:else>
    <tr class="danger">
        <td class="text-center" colspan="2">
            <i class="fa fa-exclamation-triangle"></i> No se encontraron registros que mostrar
        </td>
    </tr>
</g:else>

<script>
    <g:if test="${filtro}">
        $("#resultados").text("Mostrando ${totalSQL} resultado(s) para '${filtro}'");
    </g:if>
    <g:else>
        $("#resultados").text("Mostrando ${totalSQL} tipo(s) de persona");
    </g:else>
</script>
