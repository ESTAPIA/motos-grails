<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${personas && personas.size() > 0}">
    <g:each in="${personas}" var="persona">
        <tr data-id="${persona.id}">
            <td>
                <strong>${persona.login ?: ''}</strong>
            </td>
            <td>
                <span class="nombre-completo">
                    ${persona.nombre ?: ''} ${persona.apellido ?: ''}
                </span>
            </td>
            <td>
                <i class="fa fa-envelope"></i> ${persona.mail ?: 'Sin email'}
            </td>
            <td>
                <span class="label ${persona.activo ? 'label-success' : 'label-danger'}">
                    <i class="fa ${persona.activo ? 'fa-check' : 'fa-times'}"></i>
                    ${persona.activo ? 'Activo' : 'Inactivo'}
                </span>
            </td>
            <td>
                <div class="btn-group btn-group-sm" role="group">
                    <a href="#" data-id="${persona.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a href="#" data-id="${persona.id}" class="btn btn-danger btn-sm btn-borrar btn-ajax" title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                    <a href="#" data-id="${persona.id}" class="btn btn-info btn-sm btn-show btn-ajax" title="Ver">
                        <i class="fa fa-eye"></i>
                    </a>
                </div>
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

<!-- Script para actualizar contador -->
<script>
    <g:if test="${filtro}">
        $("#resultados").text("Mostrando ${totalSQL} resultado(s) para '${filtro}'");
    </g:if>
    <g:else>
        $("#resultados").text("Mostrando ${totalSQL} persona(s)");
    </g:else>
    console.log("📊 Conteo SQL desde servidor:", ${totalSQL});
</script>
