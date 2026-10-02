object arriba {
    method siguientePosicion(posicion) = posicion.up(1)
    method esOpuesta(otraDireccion) = otraDireccion == abajo
}

object abajo {
    method siguientePosicion(posicion) = posicion.down(1)
    method esOpuesta(otraDireccion) = otraDireccion == arriba
}

object izquierda {
    method siguientePosicion(posicion) = posicion.left(1)
    method esOpuesta(otraDireccion) = otraDireccion == derecha
}

object derecha {
    method siguientePosicion(posicion) = posicion.right(1)
    method esOpuesta(otraDireccion) = otraDireccion == izquierda
}