<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Nuevo Pedido</title>
    <meta name="layout" content="main">
    <!-- Incluimos jQuery para facilitar el manejo de AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>Nuevo Pedido</h2>
    <!-- Filtros combinados -->
    <div style="display: flex; gap: 12px; align-items: center; margin-bottom: 16px;">
        <!-- Select para tipo de accesorio -->
        <select id="filtroTipo" class="form-control" style="max-width: 200px;">
            <option value="">Todos los tipos</option>
            <g:each in="${tipos}" var="tipo">
                <option value="${tipo.id}">${tipo.tipoDeAccesorio}</option>
            </g:each>
        </select>
        <!-- Input para búsqueda por nombre -->
        <input type="text" id="busquedaArticulo" class="form-control" placeholder="Buscar artículo..." style="max-width: 300px;"/>
    </div>
    <g:form controller="cliente" action="guardarPedido">
        <!-- Contenedor donde se renderiza la tabla de artículos -->
        <div id="tablaArticulos">
            <!-- Renderiza el template de la tabla con los artículos disponibles -->
            <g:render template="tablaArticulos" model="[articulos: articulos]" />
        </div>
        <button type="submit" class="btn btn-success">Realizar Pedido</button>
        <a href="${createLink(controller: 'cliente', action: 'index')}" class="btn btn-secondary">Cancelar</a>
    </g:form>
    <script>
        // Función para actualizar la tabla con ambos filtros
        function actualizarTablaArticulos() {
            var filtro = $('#busquedaArticulo').val();
            var tipoId = $('#filtroTipo').val();
            // Realizamos una petición AJAX al controlador ArticuloController, acción buscar_cliente_ajax
            $.ajax({
                url: "${createLink(controller:'articulo', action:'buscar_cliente_ajax')}", // URL de la acción AJAX
                data: { filtro: filtro, tipoId: tipoId }, // Enviamos el filtro y tipoId como parámetros
                success: function(data) {
                    // Cuando la petición es exitosa, reemplazamos el contenido de la tabla con el resultado
                    $('#tablaArticulos').html(data);
                }
            });
        }
        // Cuando el documento esté listo...
        $(function() {
            // Al escribir en el campo de búsqueda o cambiar el select...
            $('#busquedaArticulo').on('keyup', actualizarTablaArticulos);
            $('#filtroTipo').on('change', actualizarTablaArticulos);
        });
    </script>
</body>
</html>
