object arriba {
    method siguientePosicion(posicion) = posicion.up(1)
    method opuesta() = abajo
}

object abajo {
    method siguientePosicion(posicion) = posicion.down(1)
    method opuesta() = arriba
}

object izquierda {
    method siguientePosicion(posicion) = posicion.left(1)
    method opuesta() = derecha
}

object derecha {
    method siguientePosicion(posicion) = posicion.right(1)
    method opuesta() = izquierda
}