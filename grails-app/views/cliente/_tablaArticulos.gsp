<!-- _tablaArticulos.gsp -->
<table class="table table-bordered">
    <thead>
        <tr>
            <th>Imagen</th>
            <th>Artículo</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Tipo</th>
            <th>Cantidad</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${articulos}" var="art">
            <tr>
                <!-- Columna Imagen -->
                <td>
                    <g:if test="${art.imagen}">
                        <img src="${art.imagen}" alt="Imagen" style="width:60px; height:auto;"/>
                    </g:if>
                </td>

                <!-- Columna Artículo (checkbox) -->
                <td>
                    <input type="checkbox"
                           name="articuloId"
                           value="${art.id}"
                           ${art.stock == 0 ? 'disabled' : ''}/>
                    ${art.nombre}
                    <g:if test="${art.stock == 0}">
                        <span class="badge bg-danger ms-1">Sin stock</span>
                    </g:if>
                </td>

                <!-- Columna Precio -->
                <td>$${art.precioBase}</td>

                <!-- Columna Stock -->
                <td>${art.stock}</td>

                <!-- Columna Tipo -->
                <td>${art.tipoAccesorio}</td>

                <!-- Columna Cantidad (input numérico) -->
                <td>
                    <input type="number"
                           name="cantidad"
                           min="1"
                           max="${art.stock ?: 1}"
                           value="1"
                           style="width: 60px;"
                           ${art.stock == 0 ? 'disabled' : ''}/>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>
