<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${!articuloInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el artículo solicitado
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
                    <p class="form-control-static">${articuloInstance?.nombre ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Descripción:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${articuloInstance?.descripcion ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Tipo de Accesorio:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${articuloInstance?.tipoAccesorio?.tipoDeAccesorio ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Precio Base:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${articuloInstance?.precioBase ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Stock:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${articuloInstance?.stock ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Imagen:</strong></label>
                </div>
                <div class="col-md-8">
                    <g:if test="${articuloInstance?.imagen}">
                        <img src="${articuloInstance.imagen}" alt="Imagen" style="max-width: 120px; max-height: 80px; border-radius: 6px;"/>
                    </g:if>
                    <g:else>
                        <span class="text-muted">N/A</span>
                    </g:else>
                </div>
            </div>
        </div>
    </div>
</g:else>
