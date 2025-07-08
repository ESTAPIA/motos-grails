<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${!tipoPersonaInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el tipo de persona solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <div class="form-horizontal">
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Tipo de Persona:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${tipoPersonaInstance?.descripcion ?: 'N/A'}</p>
                </div>
            </div>
        </div>
    </div>
</g:else>
