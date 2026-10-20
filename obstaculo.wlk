import wollok.game.*

class Obstaculo {
    var property position = game.at(0, 0)

    method image()

    method chocarCon(serpiente) {
        serpiente.morir()
    }

    method reposicionar(serpiente) {
        const x = (0 .. game.width() - 1).anyOne()
        const y = (0 .. game.height() - 1).anyOne()
        const nuevaPos = game.at(x, y)

        if (self.posicionLibre(nuevaPos, serpiente)) {
            position = nuevaPos
        } else {
            self.reposicionar(serpiente)
        }
    }

    method posicionLibre(pos, serpiente) {
        // Evita aparecer donde está la cabeza de la serpiente
        return !(pos.x() == serpiente.position().x() && pos.y() == serpiente.position().y())
    }
}

class Piedra inherits Obstaculo {
    override method image() = "piedra_64.png"
}

class Cactus inherits Obstaculo {
    override method image() = "cactus_64.png"
}

class Lava inherits Obstaculo {
    override method image() = "lava_64.png"

    override method chocarCon(serpiente) {
        super(serpiente)
        serpiente.puntaje(0) // Resetea puntaje al chocar con la lava
    }
}

// Instancias únicas de los obstáculos si las manejan como objetos globales
object piedra inherits Piedra { }
object cactus inherits Cactus { }
object lava inherits Lava { }