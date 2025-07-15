    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">CT    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <style> html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="layout" content="main">
    <title>Dashboard - Administrador</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>>
    <style>
        .dashboard-card {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .metric-card {
            text-align: center;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .metric-number {
            font-size: 2.5em;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .metric-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        .chart-container {
            position: relative;
            height: 300px;
            margin-bottom: 20px;
        }
        .btn-admin {
            margin: 5px;
            min-width: 120px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center mb-4">Dashboard - Administrador</h1>
            </div>
        </div>

        <g:if test="${error}">
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-triangle"></i> ${error}
            </div>
        </g:if>
        <g:else>
            <!-- Métricas generales -->
            <div class="row">
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-number">${resumenGeneral.totalPersonas}</div>
                        <div class="metric-label">Personas</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-number">${resumenGeneral.totalArticulos}</div>
                        <div class="metric-label">Artículos</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-number">${resumenGeneral.totalFacturas}</div>
                        <div class="metric-label">Facturas</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-number">$${resumenGeneral.totalVentasHoy}</div>
                        <div class="metric-label">Ventas Hoy</div>
                    </div>
                </div>
            </div>

            <!-- Gráficos -->
            <div class="row">
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h4>Tipos de Accesorios Más Vendidos</h4>
                        <div class="chart-container">
                            <canvas id="tiposAccesorioChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h4>Artículos Más Vendidos</h4>
                        <div class="chart-container">
                            <canvas id="articulosChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="dashboard-card">
                        <h4>Ventas por Mes</h4>
                        <div class="chart-container">
                            <canvas id="ventasChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-card">
                        <h4>Artículos con Poco Stock</h4>
                        <div style="max-height: 300px; overflow-y: auto;">
                            <g:if test="${articulosPocoStock}">
                                <table class="table table-sm">
                                    <thead>
                                        <tr>
                                            <th>Artículo</th>
                                            <th>Stock</th>
                                            <th>Tipo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${articulosPocoStock}" var="art">
                                            <tr class="${art.stock == 0 ? 'table-danger' : 'table-warning'}">
                                                <td>${art.nombre}</td>
                                                <td>${art.stock}</td>
                                                <td>${art.tipo}</td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                            </g:if>
                            <g:else>
                                <p class="text-muted">No hay artículos con poco stock</p>
                            </g:else>
                        </div>
                    </div>
                </div>
            </div>
        </g:else>

        <!-- Botones de navegación -->
        <div class="row">
            <div class="col-md-12">
                <div class="dashboard-card">
                    <h4>Navegación del Sistema</h4>
                    <div class="text-center">
                        <a href="${createLink(controller: 'persona', action: 'list')}" class="btn btn-warning btn-admin">Personas</a>
                        <a href="${createLink(controller: 'articulo', action: 'list')}" class="btn btn-primary btn-admin">Artículos</a>
                        <a href="${createLink(controller: 'tipoAccesorio', action: 'list')}" class="btn btn-success btn-admin">Tipos Accesorio</a>
                        <a href="${createLink(controller: 'tipoPersona', action: 'list')}" class="btn btn-info btn-admin">Tipos Persona</a>
                        <a href="${createLink(controller: 'perfil', action: 'list')}" class="btn btn-dark btn-admin">Perfiles</a>
                        <a href="${createLink(controller: 'pedido', action: 'list')}" class="btn btn-secondary btn-admin">Pedidos</a>
                        <a href="${createLink(controller: 'factura', action: 'list')}" class="btn btn-danger btn-admin">Facturas</a>
                        <a href="${createLink(controller: 'sesion', action: 'list')}" class="btn btn-info btn-admin">Sesiones</a>
                        <a href="${createLink(controller: 'login', action: 'logout')}" class="btn btn-secondary btn-admin">Salir</a>
                    </div>
                </div>
    <script>
        // Función para generar colores aleatorios
        function generarColores(cantidad) {
            const colores = [];
            for (let i = 0; i < cantidad; i++) {
                colores.push(`hsl(${Math.floor(Math.random() * 360)}, 70%, 60%)`);
            }
            return colores;
        }

        // Configuración global de Chart.js
        Chart.defaults.global.defaultFontFamily = 'Arial, sans-serif';
        Chart.defaults.global.defaultFontSize = 12;

        // Gráfico de Tipos de Accesorios
        <g:if test="${tiposAccesorioVendidos}">
            const tiposAccesorioData = {
                labels: [<g:each in="${tiposAccesorioVendidos}" var="tipo" status="i">'${tipo.nombre}'<g:if test="${i < tiposAccesorioVendidos.size() - 1}">,</g:if></g:each>],
                datasets: [{
                    data: [<g:each in="${tiposAccesorioVendidos}" var="tipo" status="i">${tipo.cantidad}<g:if test="${i < tiposAccesorioVendidos.size() - 1}">,</g:if></g:each>],
                    backgroundColor: generarColores(${tiposAccesorioVendidos.size()}),
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            };

            const tiposAccesorioConfig = {
                type: 'pie',
                data: tiposAccesorioData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                        },
                        datalabels: {
                            formatter: (value, context) => {
                                const total = context.dataset.data.reduce((sum, val) => sum + val, 0);
                                const percentage = ((value / total) * 100).toFixed(1);
                                return percentage + '%';
                            },
                            color: '#fff',
                            font: {
                                weight: 'bold',
                                size: 12
                            }
                        }
                    }
                }
            };

            new Chart(document.getElementById('tiposAccesorioChart'), tiposAccesorioConfig);
        </g:if>

        // Gráfico de Artículos Más Vendidos
        <g:if test="${articulosMasVendidos}">
            const articulosData = {
                labels: [<g:each in="${articulosMasVendidos}" var="art" status="i">'${art.nombre}'<g:if test="${i < articulosMasVendidos.size() - 1}">,</g:if></g:each>],
                datasets: [{
                    label: 'Cantidad Vendida',
                    data: [<g:each in="${articulosMasVendidos}" var="art" status="i">${art.cantidad}<g:if test="${i < articulosMasVendidos.size() - 1}">,</g:if></g:each>],
                    backgroundColor: 'rgba(54, 162, 235, 0.8)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            };

            const articulosConfig = {
                type: 'bar',
                data: articulosData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        },
                        datalabels: {
                            anchor: 'end',
                            align: 'top',
                            formatter: (value) => value,
                            color: '#333',
                            font: {
                                weight: 'bold'
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    }
                }
            };

            new Chart(document.getElementById('articulosChart'), articulosConfig);
        </g:if>

        // Gráfico de Ventas por Mes
        <g:if test="${ventasPorMes}">
            const ventasData = {
                labels: [<g:each in="${ventasPorMes}" var="venta" status="i">'${venta.mes}'<g:if test="${i < ventasPorMes.size() - 1}">,</g:if></g:each>],
                datasets: [{
                    label: 'Ventas ($)',
                    data: [<g:each in="${ventasPorMes}" var="venta" status="i">${venta.total}<g:if test="${i < ventasPorMes.size() - 1}">,</g:if></g:each>],
                    backgroundColor: 'rgba(75, 192, 192, 0.6)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4
                }]
            };

            const ventasConfig = {
                type: 'line',
                data: ventasData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        },
                        datalabels: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return '$' + value.toLocaleString();
                                }
                            }
                        }
                    }
                }
            };

            new Chart(document.getElementById('ventasChart'), ventasConfig);
        </g:if>

        // Función para mostrar notificaciones de stock bajo
        function mostrarNotificacionesStock() {
            <g:if test="${articulosPocoStock}">
                const stockCero = ${articulosPocoStock.count { it.stock == 0 }};
                const stockBajo = ${articulosPocoStock.count { it.stock > 0 && it.stock <= 5 }};
                
                if (stockCero > 0) {
                    toastr.error(`¡Atención! ${stockCero} artículos sin stock`, 'Stock Agotado');
                }
                if (stockBajo > 0) {
                    toastr.warning(`${stockBajo} artículos con poco stock`, 'Stock Bajo');
                }
            </g:if>
        }

        // Inicializar notificaciones al cargar la página
        document.addEventListener('DOMContentLoaded', function() {
            // Configurar toastr si está disponible
            if (typeof toastr !== 'undefined') {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    timeOut: 5000
                };
                mostrarNotificacionesStock();
            }
        });
    </script>
</body>
</html>