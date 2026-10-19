object marcador {
    method position() = game.at(1, 1) 
    
    var property texto = "Puntos: 0"
    method text() = texto
    
    // Acá definís el color. "FFFFFF" es blanco.
    method textColor() = "#FFFFFF" 
    
    method actualizar(nuevoPuntaje) {
        texto = "Puntos: " + nuevoPuntaje
    }

    // Agregar chocarCon para que no falle
    method chocarCon(serpiente) {
        // No hace nada (es un marcador)
    }
}