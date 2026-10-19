import wollok.game.*
import obstaculo.*

class Comida {
    var property position = game.at(8, 8)

    method puntaje() = 10 
    method image() = "manzana_64.png"

    method aumentarRapidez(serpiente) {
        // La manzana no hace nada
    }

    method chocarCon(serpiente) {
        serpiente.comer(self)
        self.reposicionar(serpiente)
    }

    method reposicionar(serpiente) {
        const x = (0 .. game.width() - 1).anyOne()
        const y = (0 .. game.height() - 1).anyOne()
        const nuevaPos = game.at(x, y)

        // Si la posición está libre, la asignamos
        if (self.posicionLibre(nuevaPos, serpiente)) {
            position = nuevaPos
        } else {
            // Si está ocupada, volvemos a intentar (recursividad)
            self.reposicionar(serpiente)
        }
    }

    method posicionLibre(pos, serpiente) {
        const libreDeSerpiente = !(pos.x() == serpiente.position().x() && pos.y() == serpiente.position().y())
        
        const libreDeObstaculos = !(pos.x() == piedra.position().x() && pos.y() == piedra.position().y()) &&
                                  !(pos.x() == cactus.position().x() && pos.y() == cactus.position().y()) &&
                                  !(pos.x() == lava.position().x() && pos.y() == lava.position().y())
        
        return libreDeSerpiente && libreDeObstaculos
    }

    method resetear() {
        position = game.at(5, 5)
    }
}

class Manzana inherits Comida {
    override method puntaje() = 10
    override method image() = "manzana_64.png"
}

class Banana inherits Comida {
    override method puntaje() = super() + 10    // 20 puntos en total
    override method image() = "banana.png"

    override method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(1) // <-- Acelera 1
    }
}

class Cereza inherits Comida {
    override method puntaje() = super() + 20    // 30 puntos en total
    override method image() = "cereza.png"

    override method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(2) // <-- Acelera 2
    }
}

class FrutaDorada inherits Comida {
    override method puntaje() = super() + 40    // 50 puntos en total
    override method image() = "frutadorada.png"

    override method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(4) // <-- Acelera 4
    }
}