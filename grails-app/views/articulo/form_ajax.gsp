<g:if test="${!articuloInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el artículo solicitado
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmArticulo"
                controller="articulo" action="save_ajax"
                method="POST" role="form">

            <g:hiddenField name="id" value="${articuloInstance?.id}" />

            <!-- Nombre -->
            <div class="form-group row">
                <label for="nombre" class="col-12 control-label">Nombre</label>
                <div class="col-12">
                    <g:textField name="nombre" class="form-control input-sm required"
                                 maxlength="100" minlength="3" required=""
                                 value="${articuloInstance?.nombre}" />
                </div>
            </div>

            <!-- Descripción -->
            <div class="form-group row">
                <label for="descripcion" class="col-12 control-label">Descripción</label>
                <div class="col-12">
                    <g:textArea name="descripcion" rows="2" maxlength="255"
                                class="form-control input-sm" style="resize:none;"
                                value="${articuloInstance?.descripcion}" />
                </div>
            </div>

            <!-- Precio Base -->
            <div class="form-group row">
                <label for="precioBase" class="col-12 control-label">Precio Base</label>
                <div class="col-12">
                    <g:field type="number" name="precioBase" step="0.01" min="0"
                             class="form-control input-sm required"
                             required="" value="${articuloInstance?.precioBase}" />
                </div>
            </div>

            <!-- Tipo de Accesorio -->
            <div class="form-group row">
                <label for="tipoAccesorio" class="col-12 control-label">Tipo de Accesorio</label>
                <div class="col-12">
                    <g:select name="tipoAccesorio" from="${tiposAccesorio}"
                              optionKey="id" optionValue="tipoDeAccesorio"
                              value="${articuloInstance?.tipoAccesorio?.id}"
                              class="form-control input-sm required" required="" />
                </div>
            </div>

            <!-- Imagen -->
            <div class="form-group row">
                <label for="imagen" class="col-12 control-label">Imagen (ruta)</label>
                <div class="col-12">
                    <g:textField name="imagen" maxlength="255"
                                 class="form-control input-sm"
                                 value="${articuloInstance?.imagen}" />
                </div>
            </div>

            <!-- Stock -->
            <div class="form-group row">
                <label for="stock" class="col-12 control-label">Stock</label>
                <div class="col-12">
                    <g:field type="number" name="stock" min="0"
                             class="form-control input-sm required" required=""
                             value="${articuloInstance?.stock}" />
                    <span class="help-block">Cantidad disponible en inventario.</span>
                </div>
            </div>


        </g:form>
    </div>
</g:else>
