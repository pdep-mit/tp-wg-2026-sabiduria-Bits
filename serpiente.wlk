import direccion.*
import wollok.game.*
import segmento.*

object serpiente {
    var property position = game.at(5, 5)
    var property direccion = derecha
    var property puntaje = 0
    var property velocidad = 20
    var property contador = 0

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
            contador += 1
            // Avanza solo si el contador llega a la velocidad actual
            if (contador >= velocidad) {
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
        comida.aumentarRapidez(self) // <-- Le avisa a la fruta que aumente la velocidad
    
        // Muestra en puntaje por consola por el tema que se ve muy pequeño en el marcador, y así se ve más claro
        console.println("==================================")
        console.println("🍎 ¡Comiste! Puntaje actual: " + puntaje)
        console.println("==================================") 
    }

    method aumentarVelocidad(cuanto) {
        // Restamos para que vaya más rápido (menos ticks de espera)
        // El max(1) asegura que nunca sea menor a 1 (que no colapse)
        velocidad = (velocidad - cuanto).max(1) 
    }

    // Se crea un segmento invisible debajo de la cabeza. Al avanzar, quedará revelado.
    method crecer() {
        const nuevoSegmento = new Segmento(position = game.at(-1, -1))
        cuerpo.add(nuevoSegmento)
        game.addVisual(nuevoSegmento)
    }

    method ocupa(unaPosicion){
        //Devuelve true si la cabeza o algun segmento del cuerpo esta en esa posicion
        const ocupaCabeza = position == unaPosicion
        const ocupaCuerpo = cuerpo.any({ segmento => segmento.position() == unaPosicion})

        return ocupaCabeza or ocupaCuerpo
    }

    method resetear() {
        position = game.at(5, 5)
        direccion = derecha
        puntaje = 0
        velocidad = 20    // <-- Vuelve a la velocidad lenta inicial
        viva = true
        contador = 0
        
        cuerpo.forEach({ segmento => game.removeVisual(segmento) })
        cuerpo.clear()
    }

    method morir() {
        viva = false
        game.say(self, "¡Game Over! Presiona R para reiniciar")
        console.println("==================================")
        console.println("         ¡GAME OVER!            ")
        console.println("   Puntaje final: " + puntaje)  
        console.println("==================================")
    }

    method estaViva() = viva

    method image() = "cabeza.png"
}