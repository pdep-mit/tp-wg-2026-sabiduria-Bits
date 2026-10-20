import wollok.game.*
import obstaculo.*
import serpiente.*

object nivel {
    var property nivelActual = 1
    const obstaculosEnPantalla = []

    method tiempoDeJuego() {
        return (300 - (nivelActual * 40)).max(60)
    }

    method avanzarNivel() {
        nivelActual += 1
        self.cargarObstaculos()
    }

    method cargarObstaculos() {
        // Remover los obstáculos previos de la pantalla
        obstaculosEnPantalla.forEach({ obs => game.removeVisual(obs) })
        obstaculosEnPantalla.clear()

        // Nivel 2: Agregar Piedra
        if (nivelActual == 2) {
            piedra.reposicionar(serpiente)
            game.addVisual(piedra)
            obstaculosEnPantalla.add(piedra)
        } else {
            // Nivel 3 en adelante: Agregar Piedra, Cactus y Lava
            if (nivelActual >= 3) {
                [piedra, cactus, lava].forEach({ obs =>
                    obs.reposicionar(serpiente)
                    game.addVisual(obs)
                    obstaculosEnPantalla.add(obs)
                })
            }
        }
    }

    method resetear() {
        nivelActual = 1
        obstaculosEnPantalla.forEach({ obs => game.removeVisual(obs) })
        obstaculosEnPantalla.clear()
    }
}