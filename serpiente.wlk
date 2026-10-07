import direccion.*
import wollok.game.*
import segmento.*

object serpiente {
    var property position = game.at(5, 5)
    var property direccion = derecha
    var property puntaje = 0
    var viva = true
    
    // Lista para guardar el rastro del cuerpo
    const property cuerpo = []

    method cambiarDireccion(nuevaDireccion) {
        if (nuevaDireccion != direccion.opuesta()) {
            direccion = nuevaDireccion
        }
    }

    method avanzar() {
        if (viva) {
            const posicionAnterior = position
            position = direccion.siguientePosicion(position)
            self.verificarBorde()
            self.moverCuerpo(posicionAnterior)
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
    }

    // Se crea un segmento invisible debajo de la cabeza. Al avanzar, quedará revelado.
    method crecer() {
    const nuevoSegmento = new Segmento(position = game.at(-1, -1))
    cuerpo.add(nuevoSegmento)
    game.addVisual(nuevoSegmento)
    }

    method resetear() {
        position = game.at(5, 5)
        direccion = derecha
        puntaje = 0
        viva = true
        
        // Limpiamos los visuales del cuerpo del tablero y vaciamos la lista
        cuerpo.forEach({ segmento => game.removeVisual(segmento) })
        cuerpo.clear()
    }

    method morir() {
        viva = false
        game.say(self, "¡Game Over! Presiona R para reiniciar")
        console.println("================================")
        console.println("         ¡GAME OVER!            ")
        console.println("================================")
    }

    method estaViva() = viva

    method image() = "cabeza.png"
}