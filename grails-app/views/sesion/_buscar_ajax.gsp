<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${sesiones && sesiones.size() > 0}">
    <g:each in="${sesiones}" var="sesion">
        <tr>
            <td>${sesion.id}</td>
            <td>${sesion.usuario?.nombre} ${sesion.usuario?.apellido}</td>
            <td>${sesion.perfil?.nombre}</td>
            <td>${sesion.fechaInicio?.format('dd/MM/yyyy HH:mm')}</td>
            <td>${sesion.fechaFin ? sesion.fechaFin.format('dd/MM/yyyy HH:mm') : '-'}</td>
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
