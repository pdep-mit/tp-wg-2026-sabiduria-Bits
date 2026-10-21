import direccion.*
import wollok.game.*
import segmento.*
import nivel.*

object serpiente {
    var property position = game.at(5, 5)
    var property direccion = derecha
    var direccionActual = derecha
    var property puntaje = 0
    var property velocidad = 20
    var property contador = 0

    var viva = true
    var pausada = true 

    const property cuerpo = []

    method cambiarDireccion(nuevaDireccion) {
        if (nuevaDireccion != direccionActual.opuesta()) { 
            direccion = nuevaDireccion
        }
    }

    method avanzar() {
        if (viva and not pausada) {
            contador += 1
            if (contador >= velocidad) {
                direccionActual = direccion
                const posicionAnterior = position
                position = direccion.siguientePosicion(position)
                self.verificarBorde()
                self.moverCuerpo(posicionAnterior)
                contador = 0
            }
        }
    }

    method moverCuerpo(posCabezaAnterior) {
        var posPrevia = posCabezaAnterior
        
        cuerpo.forEach({ segmento =>
            const posActual = segmento.position()
            segmento.position(posPrevia)
            posPrevia = posActual
        })
    }

    method verificarBorde() {
        const x = position.x()
        const y = position.y()
        if (x < 0 || x >= game.width() || y < 0 || y >= game.height()) {
            self.morir()
        }
    }

    method comer(comida) {
        puntaje += comida.puntaje()
        self.crecer()
        comida.aumentarRapidez(self) 
        
        gestorDeNiveles.verificarProgreso(puntaje)
    }

    method aumentarVelocidad(cuanto) {
        velocidad = (velocidad - cuanto).max(1) 
    }

    method crecer() {
        const nuevoSegmento = new Segmento(position = game.at(-1, -1))
        cuerpo.add(nuevoSegmento)
        game.addVisual(nuevoSegmento)
    }

    method ocupa(unaPosicion){
        const ocupaCabeza = position == unaPosicion
        const ocupaCuerpo = cuerpo.any({ segmento => segmento.position() == unaPosicion})

        return ocupaCabeza or ocupaCuerpo
    }

    method pausar() {
        pausada = true
    }

    method reanudar() {
        self.resetear()
        pausada = false
    }

    method resetear() {
        position = game.at(5, 5)
        direccion = derecha
        direccionActual = derecha
        puntaje = 0
        velocidad = 20
        viva = true
        pausada = true 
        contador = 0
        
        cuerpo.forEach({ segmento => game.removeVisual(segmento) })
        cuerpo.clear()

        if (game.hasVisual(pantallaGameOver)) {
            game.removeVisual(pantallaGameOver)
        }
    }

    method morir() {
        viva = false
        game.addVisual(pantallaGameOver)
    }

    method estaViva() = viva

    method image() = "cabeza.png"
}