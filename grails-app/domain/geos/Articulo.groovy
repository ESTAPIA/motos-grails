package geos

class Articulo {
    String nombre
    String descripcion
    BigDecimal precioBase
    TipoAccesorio tipoAccesorio
    String imagen
    Integer stock = 0

    static mapping = {
        table 'artc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'artc__id'
            nombre column: 'artcnmbr'
            descripcion column: 'artcdscr', type: 'text'
            precioBase column: 'artcprbs'
            tipoAccesorio column: 'tpac__id'
            imagen column: 'artcimgn'
            stock column: 'artcstock'
        }
    }

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..100,
               attributes: [title: 'Nombre del artículo'])
        descripcion(blank: true, nullable: true,
                   attributes: [title: 'Descripción del artículo'])
        precioBase(min: 0.0, scale: 2,
                  attributes: [title: 'Precio base'])
        tipoAccesorio(nullable: false,
                     attributes: [title: 'Tipo de accesorio'])
        imagen(blank: true, nullable: true, size: 0..100,
               attributes: [title: 'Ruta de imagen'])
        stock(min: 0, nullable: false, attributes: [title: 'Stock disponible'])
    }

    String toString() {
        return "${this.nombre}"
    }
}
