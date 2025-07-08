<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${!facturaInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró la factura solicitada
    </div>
</g:if>
<g:else>
    <div class="modal-contenido">
        <div class="form-horizontal">
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>ID:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${facturaInstance?.id ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Pedido:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">
                        ${facturaInstance?.pedido?.id ?: 'N/A'}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Fecha de Emisión:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">
                        ${facturaInstance?.fechaEmision?.format('dd/MM/yyyy') ?: 'N/A'}
                    </p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Total:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">$${facturaInstance?.total ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-12">
                    <label class="control-label"><strong>Detalle de la Factura:</strong></label>
                    <table class="table table-bordered table-sm">
                        <thead>
                            <tr>
                                <th>Artículo</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${facturaInstance?.detalles}" var="det">
                                <tr>
                                    <td>${det.articulo?.nombre ?: 'N/A'}</td>
                                    <td>${det.cantidad}</td>
                                    <td>$${det.precioUnitario}</td>
                                    <td>$${det.subtotal}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</g:else>
