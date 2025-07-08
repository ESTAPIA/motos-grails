<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${!perfilInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el perfil solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <div class="form-horizontal">
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Nombre:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${perfilInstance?.nombre ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Descripción:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${perfilInstance?.descripcion ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Código:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${perfilInstance?.codigo ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Perfil Padre:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${perfilInstance?.padre?.nombre ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Observaciones:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${perfilInstance?.observaciones ?: 'N/A'}</p>
                </div>
            </div>
        </div>
    </div>
</g:else>
