<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${!pedidoInstance}">
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> No se encontró el pedido solicitado
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
                    <p class="form-control-static">${pedidoInstance?.id ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Cliente:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${pedidoInstance?.persona?.nombre} ${pedidoInstance?.persona?.apellido}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Fecha:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${pedidoInstance?.fechaPedido?.format('dd/MM/yyyy') ?: 'N/A'}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4">
                    <label class="control-label"><strong>Estado:</strong></label>
                </div>
                <div class="col-md-8">
                    <p class="form-control-static">${pedidoInstance?.estado}</p>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-12">
                    <label class="control-label"><strong>Detalle del Pedido:</strong></label>
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
                            <g:each in="${pedidoInstance?.detalles}" var="det">
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
