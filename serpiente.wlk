import direccion.*

object serpiente {
    var property position = game.at(5, 5)
    var property direccion = derecha

    // 1. Cambio de dirección con validación de 180°
    method cambiarDireccion(nuevaDireccion) {
        if (!direccion.esOpuesta(nuevaDireccion)) {
            direccion = nuevaDireccion
        }
    }

    // 2. Movimiento
    method avanzar() {
        position = direccion.siguientePosicion(position)
        // Coordinar el movimiento del cuerpo aquí
    }

    // 3. Contrato para interactuar con la comida / crecimiento
    method crecer() {
        // Definir la acción básica (ej: sumar un elemento al cuerpo o encargarle a Persona 2)
    }
}