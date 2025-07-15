# 📋 DOCUMENTACIÓN - MEJORAS PARA EL APARTADO DE ADMINISTRADOR

## 🎯 OBJETIVO GENERAL
Implementar mejoras en el módulo de administrador para incluir:
1. **Exportación a Excel** para Artículos y Facturas (siguiendo el patrón de Personas)
2. **Dashboard con estadísticas** en la página de inicio con gráficos interactivos

---

## 📊 PARTE 1: EXPORTACIÓN A EXCEL

### 🔍 ANÁLISIS DE LA IMPLEMENTACIÓN EXISTENTE (Personas)

#### Estructura actual en PersonaController:
- **Librerías importadas**: Apache POI (XSSFWorkbook, Sheet, Row, Cell)
- **Método**: `reporteExcel()` con anotación `@Transactional(readOnly = true)`
- **Proceso**: Crear workbook → Encabezados → Datos → Autoajustar → Respuesta HTTP

#### Botón en la vista:
```gsp
<g:link controller="persona" action="reporteExcel" class="btn btn-success">
    <i class="fa fa-file-excel"></i> Exportar a Excel
</g:link>
```

### 📝 PLAN DE IMPLEMENTACIÓN

---

## 🛠️ MEJORA 1: EXPORTACIÓN A EXCEL PARA ARTÍCULOS

### **Paso 1.1: Modificar ArticuloController**

#### 1.1.1 Agregar imports necesarios
```groovy
// Agregar al inicio del archivo después de package geos
import org.apache.poi.ss.usermodel.*
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Cell
import grails.gorm.transactions.Transactional
```

#### 1.1.2 Implementar método reporteExcel()
```groovy
@Transactional(readOnly = true)
def reporteExcel() {
    List<Articulo> articulos = Articulo.list(sort: 'nombre')
    
    // Crear libro y hoja
    XSSFWorkbook wb = new XSSFWorkbook()
    Sheet sheet = wb.createSheet('Articulos')
    
    // Encabezados
    String[] cols = ['Código', 'Nombre', 'Descripción', 'Precio', 'Stock', 
                    'Tipo de Accesorio', 'Fecha Creación', 'Fecha Actualización']
    Row header = sheet.createRow(0)
    cols.eachWithIndex { label, idx -> header.createCell(idx).setCellValue(label) }
    
    // Datos
    int rowNum = 1
    articulos.each { art ->
        Row row = sheet.createRow(rowNum++)
        row.createCell(0).setCellValue(art.codigo ?: '')
        row.createCell(1).setCellValue(art.nombre ?: '')
        row.createCell(2).setCellValue(art.descripcion ?: '')
        row.createCell(3).setCellValue(art.precio ?: 0.0)
        row.createCell(4).setCellValue(art.stock ?: 0)
        row.createCell(5).setCellValue(art.tipoAccesorio?.tipoDeAccesorio ?: '')
        row.createCell(6).setCellValue(art.dateCreated ? art.dateCreated.format('dd/MM/yyyy') : '')
        row.createCell(7).setCellValue(art.lastUpdated ? art.lastUpdated.format('dd/MM/yyyy') : '')
    }
    
    // Autoajustar columnas
    cols.indices.each { sheet.autoSizeColumn(it) }
    
    // Configurar respuesta HTTP
    String fileName = "reporte_articulos_${new Date().format('yyyyMMdd_HHmm')}.xlsx"
    response.contentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    response.setHeader 'Content-Disposition', "attachment; filename=${fileName}"
    
    // Enviar archivo
    wb.write(response.outputStream)
    wb.close()
    response.outputStream.flush()
    return
}
```

### **Paso 1.2: Modificar vista articulo/list.gsp**

#### 1.2.1 Agregar botón de exportación
Localizar la sección de botones (toolbar) y agregar:
```gsp
<!-- Botón exportar Excel -->
<div class="btn-group">
    <g:link controller="articulo" action="reporteExcel" class="btn btn-success">
        <i class="fa fa-file-excel"></i> Exportar a Excel
    </g:link>
</div>
```

---

## 🛠️ MEJORA 2: EXPORTACIÓN A EXCEL PARA FACTURAS

### **Paso 2.1: Modificar FacturaController**

#### 2.1.1 Agregar imports necesarios
```groovy
// Agregar al inicio del archivo después de package geos
import org.apache.poi.ss.usermodel.*
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Cell
import grails.gorm.transactions.Transactional
```

#### 2.1.2 Implementar método reporteExcel()
```groovy
@Transactional(readOnly = true)
def reporteExcel() {
    // Aplicar filtros si existen
    def fechaInicio = params.fechaInicio ? Date.parse('yyyy-MM-dd', params.fechaInicio) : null
    def fechaFin = params.fechaFin ? Date.parse('yyyy-MM-dd', params.fechaFin) : null
    def fechaFinMasUno = fechaFin ? fechaFin + 1 : null
    
    def facturas = Factura.createCriteria().list {
        if (fechaInicio) {
            ge("fechaEmision", fechaInicio)
        }
        if (fechaFinMasUno) {
            lt("fechaEmision", fechaFinMasUno)
        }
        order("fechaEmision", "desc")
    }
    
    // Crear libro y hoja
    XSSFWorkbook wb = new XSSFWorkbook()
    Sheet sheet = wb.createSheet('Facturas')
    
    // Encabezados
    String[] cols = ['ID', 'Fecha Emisión', 'Cliente', 'Cédula Cliente', 
                    'Pedido ID', 'Total', 'Detalles']
    Row header = sheet.createRow(0)
    cols.eachWithIndex { label, idx -> header.createCell(idx).setCellValue(label) }
    
    // Datos
    int rowNum = 1
    facturas.each { fact ->
        Row row = sheet.createRow(rowNum++)
        row.createCell(0).setCellValue(fact.id ?: '')
        row.createCell(1).setCellValue(fact.fechaEmision ? fact.fechaEmision.format('dd/MM/yyyy') : '')
        row.createCell(2).setCellValue("${fact.pedido?.persona?.nombre ?: ''} ${fact.pedido?.persona?.apellido ?: ''}")
        row.createCell(3).setCellValue(fact.pedido?.persona?.cedula ?: '')
        row.createCell(4).setCellValue(fact.pedido?.id ?: '')
        row.createCell(5).setCellValue(fact.total ?: 0.0)
        
        // Detalles (resumen de productos)
        def detalles = fact.pedido?.detalles?.collect { det ->
            "${det.cantidad}x ${det.articulo?.nombre}"
        }?.join(', ')
        row.createCell(6).setCellValue(detalles ?: '')
    }
    
    // Autoajustar columnas
    cols.indices.each { sheet.autoSizeColumn(it) }
    
    // Configurar respuesta HTTP
    String fileName = "reporte_facturas_${new Date().format('yyyyMMdd_HHmm')}.xlsx"
    response.contentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    response.setHeader 'Content-Disposition', "attachment; filename=${fileName}"
    
    // Enviar archivo
    wb.write(response.outputStream)
    wb.close()
    response.outputStream.flush()
    return
}
```

### **Paso 2.2: Modificar vista factura/list.gsp**

#### 2.2.1 Agregar botón de exportación
Localizar la sección de botones (toolbar) y agregar:
```gsp
<!-- Botón exportar Excel -->
<div class="btn-group">
    <g:link controller="factura" action="reporteExcel" class="btn btn-success" 
            params="${params}">
        <i class="fa fa-file-excel"></i> Exportar a Excel
    </g:link>
</div>
```

---

## 📊 PARTE 2: DASHBOARD CON ESTADÍSTICAS

### 🔍 ANÁLISIS DE REQUERIMIENTOS

#### Estadísticas propuestas:
1. **Tipos de accesorios más vendidos** (gráfico de barras/pastel)
2. **Artículos más vendidos** (gráfico de barras)
3. **Artículos con poco stock** (tabla con alertas)
4. **Resumen de ventas por mes** (gráfico de líneas)

### 📝 PLAN DE IMPLEMENTACIÓN

---

## 🛠️ MEJORA 3: DASHBOARD DE ESTADÍSTICAS

### **Paso 3.1: Modificar InicioController**

#### 3.1.1 Agregar imports necesarios
```groovy
import groovy.sql.Sql
import grails.converters.JSON
```

#### 3.1.2 Inyectar DataSource
```groovy
def dataSource
```

#### 3.1.3 Implementar método index() con estadísticas
```groovy
def index() {
    def sql = new Sql(dataSource)
    
    try {
        // 1. Tipos de accesorios más vendidos
        def tiposAccesorioVendidos = sql.rows("""
            SELECT ta.tpactpac as tipo, 
                   SUM(dp.dtpdcant) as total_vendido
            FROM dtpd dp
            JOIN artc a ON dp.artc__id = a.artc__id
            JOIN tpac ta ON a.tpac__id = ta.tpac__id
            JOIN pddo p ON dp.pddo__id = p.pddo__id
            WHERE p.pddoestd = 'COMPLETADO'
            GROUP BY ta.tpactpac
            ORDER BY total_vendido DESC
            LIMIT 10
        """)
        
        // 2. Artículos más vendidos
        def articulosMasVendidos = sql.rows("""
            SELECT a.artcnmbr as nombre,
                   SUM(dp.dtpdcant) as total_vendido
            FROM dtpd dp
            JOIN artc a ON dp.artc__id = a.artc__id
            JOIN pddo p ON dp.pddo__id = p.pddo__id
            WHERE p.pddoestd = 'COMPLETADO'
            GROUP BY a.artc__id, a.artcnmbr
            ORDER BY total_vendido DESC
            LIMIT 10
        """)
        
        // 3. Artículos con poco stock (menos de 10)
        def articulosPocoStock = sql.rows("""
            SELECT a.artcnmbr as nombre,
                   a.artcstck as stock,
                   ta.tpactpac as tipo
            FROM artc a
            JOIN tpac ta ON a.tpac__id = ta.tpac__id
            WHERE a.artcstck < 10
            ORDER BY a.artcstck ASC
        """)
        
        // 4. Ventas por mes (últimos 12 meses)
        def ventasPorMes = sql.rows("""
            SELECT TO_CHAR(f.fctremis, 'YYYY-MM') as mes,
                   COUNT(*) as total_facturas,
                   SUM(f.fctrtotl) as total_ventas
            FROM fctr f
            WHERE f.fctremis >= CURRENT_DATE - INTERVAL '12 months'
            GROUP BY TO_CHAR(f.fctremis, 'YYYY-MM')
            ORDER BY mes DESC
        """)
        
        // 5. Resumen general
        def resumenGeneral = [
            totalPersonas: sql.firstRow("SELECT COUNT(*) as total FROM prsn").total,
            totalArticulos: sql.firstRow("SELECT COUNT(*) as total FROM artc").total,
            totalFacturas: sql.firstRow("SELECT COUNT(*) as total FROM fctr").total,
            totalVentasHoy: sql.firstRow("""
                SELECT COALESCE(SUM(fctrtotl), 0) as total 
                FROM fctr 
                WHERE DATE(fctremis) = CURRENT_DATE
            """).total
        ]
        
        return [
            tiposAccesorioVendidos: tiposAccesorioVendidos,
            articulosMasVendidos: articulosMasVendidos,
            articulosPocoStock: articulosPocoStock,
            ventasPorMes: ventasPorMes,
            resumenGeneral: resumenGeneral
        ]
        
    } catch (Exception e) {
        log.error "Error al generar estadísticas: ${e.message}", e
        return [error: "Error al cargar estadísticas"]
    } finally {
        sql.close()
    }
}
```

### **Paso 3.2: Modificar vista inicio/index.gsp**

#### 3.2.1 Agregar librerías de gráficos
```gsp
<head>
    <!-- Librerías existentes -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
</head>
```

#### 3.2.2 Crear estructura del dashboard
```gsp
<body>
    <div class="container-fluid">
        <!-- Encabezado -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="text-center">Dashboard de Administración</h1>
            </div>
        </div>
        
        <!-- Tarjetas de resumen -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <h5>Total Personas</h5>
                        <h3>${resumenGeneral?.totalPersonas ?: 0}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <h5>Total Artículos</h5>
                        <h3>${resumenGeneral?.totalArticulos ?: 0}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <h5>Total Facturas</h5>
                        <h3>${resumenGeneral?.totalFacturas ?: 0}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <h5>Ventas Hoy</h5>
                        <h3>$${resumenGeneral?.totalVentasHoy ?: 0}</h3>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Gráficos -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Tipos de Accesorios Más Vendidos</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="chartTiposAccesorio"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Artículos Más Vendidos</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="chartArticulos"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5>Ventas por Mes</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="chartVentasMes"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5>Artículos con Poco Stock</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
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
                                        <tr class="${art.stock < 5 ? 'table-danger' : 'table-warning'}">
                                            <td>${art.nombre}</td>
                                            <td>${art.stock}</td>
                                            <td>${art.tipo}</td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Botones de navegación -->
        <div class="row">
            <div class="col-12">
                <div class="btn-group-center">
                    <a href="${createLink(controller: 'persona', action: 'list')}" class="btn btn-warning">Personas</a>
                    <a href="${createLink(controller: 'articulo', action: 'list')}" class="btn btn-primary">Artículos</a>
                    <a href="${createLink(controller: 'factura', action: 'list')}" class="btn btn-danger">Facturas</a>
                    <a href="${createLink(controller: 'login', action: 'logout')}" class="btn btn-secondary">Salir</a>
                </div>
            </div>
        </div>
    </div>
</body>
```

#### 3.2.3 Implementar scripts de gráficos
```gsp
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 1. Gráfico de tipos de accesorios (Dona/Pastel)
    const tiposData = ${raw((tiposAccesorioVendidos as JSON).toString())};
    const ctxTipos = document.getElementById('chartTiposAccesorio').getContext('2d');
    new Chart(ctxTipos, {
        type: 'doughnut',
        data: {
            labels: tiposData.map(item => item.tipo),
            datasets: [{
                data: tiposData.map(item => item.total_vendido),
                backgroundColor: [
                    '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', 
                    '#9966FF', '#FF9F40', '#FF6384', '#C9CBCF'
                ]
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
    
    // 2. Gráfico de artículos más vendidos (Barras)
    const articulosData = ${raw((articulosMasVendidos as JSON).toString())};
    const ctxArticulos = document.getElementById('chartArticulos').getContext('2d');
    new Chart(ctxArticulos, {
        type: 'bar',
        data: {
            labels: articulosData.map(item => item.nombre),
            datasets: [{
                label: 'Cantidad Vendida',
                data: articulosData.map(item => item.total_vendido),
                backgroundColor: '#36A2EB'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    
    // 3. Gráfico de ventas por mes (Líneas)
    const ventasData = ${raw((ventasPorMes as JSON).toString())};
    const ctxVentas = document.getElementById('chartVentasMes').getContext('2d');
    new Chart(ctxVentas, {
        type: 'line',
        data: {
            labels: ventasData.map(item => item.mes),
            datasets: [{
                label: 'Total Ventas ($)',
                data: ventasData.map(item => item.total_ventas),
                borderColor: '#4BC0C0',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: true
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
});
</script>
```

---

## 📋 CHECKLIST DE IMPLEMENTACIÓN

### ✅ Exportación a Excel - Artículos
- [ ] Agregar imports de Apache POI en ArticuloController
- [ ] Implementar método reporteExcel() en ArticuloController
- [ ] Agregar botón de exportación en vista articulo/list.gsp
- [ ] Probar descarga de Excel con datos de muestra

### ✅ Exportación a Excel - Facturas
- [ ] Agregar imports de Apache POI en FacturaController
- [ ] Implementar método reporteExcel() en FacturaController
- [ ] Agregar botón de exportación en vista factura/list.gsp
- [ ] Probar descarga de Excel con filtros de fecha

### ✅ Dashboard de Estadísticas
- [ ] Modificar InicioController con método index() actualizado
- [ ] Agregar consultas SQL para estadísticas
- [ ] Actualizar vista inicio/index.gsp con estructura del dashboard
- [ ] Integrar Chart.js para gráficos
- [ ] Implementar gráficos: tipos de accesorios, artículos, ventas
- [ ] Crear tabla de artículos con poco stock
- [ ] Agregar tarjetas de resumen general
- [ ] Probar responsividad y funcionalidad

### ✅ Pruebas Finales
- [ ] Verificar que todos los gráficos carguen correctamente
- [ ] Probar exportación Excel en diferentes navegadores
- [ ] Validar que los datos mostrados sean correctos
- [ ] Verificar seguridad (solo admin)
- [ ] Optimizar rendimiento de consultas

---

## 🔧 CONSIDERACIONES TÉCNICAS

### Dependencias necesarias:
- **Apache POI**: Ya está incluido en el proyecto
- **Chart.js**: Se carga desde CDN
- **Bootstrap**: Ya incluido en el layout main

### Seguridad:
- Todos los controllers ya tienen `beforeInterceptor` para validar admin
- Las consultas SQL usan parámetros seguros
- Los exports respetan los permisos del usuario

### Rendimiento:
- Usar `@Transactional(readOnly = true)` para consultas
- Implementar caché si es necesario
- Limitar resultados con LIMIT en consultas

---

## 🎯 RESULTADO ESPERADO

Al finalizar la implementación, el administrador tendrá:

1. **Botones de Excel** en las vistas de Artículos y Facturas
2. **Dashboard interactivo** con:
   - Tarjetas de resumen
   - Gráfico de dona para tipos de accesorios
   - Gráfico de barras para artículos más vendidos
   - Gráfico de líneas para ventas mensuales
   - Tabla de alertas para stock bajo
3. **Navegación mejorada** desde el dashboard
4. **Exportes funcionales** con datos completos y bien formateados

Esta documentación proporciona una guía completa y secuencial para implementar todas las mejoras solicitadas de manera organizada y estructurada.
