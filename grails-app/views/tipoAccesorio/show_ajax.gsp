<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${!tipoAccesorioInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el tipo de accesorio solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <div class="form-horizontal">
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Tipo de Accesorio:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${tipoAccesorioInstance?.tipoDeAccesorio ?: 'N/A'}</p>
                </div>
            </div>
        </div>
    </div>
</g:else>
