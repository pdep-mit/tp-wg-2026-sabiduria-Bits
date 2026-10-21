import wollok.game.*
import nivel.* 

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
        const libreDeSerpiente = not serpiente.ocupa(pos)
        
        const libreDeOtros = not gestorDeNiveles.nivelActual().ocupa(pos, self)
        
        return libreDeSerpiente and libreDeOtros
    }
}

class Piedra inherits Obstaculo {
    override method image() = "piedra.png"
}

class Cactus inherits Obstaculo {
    override method image() = "cactus.png"
}

class Lava inherits Obstaculo {
    override method image() = "lava.png"

    override method chocarCon(serpiente) {
        super(serpiente)
        serpiente.puntaje(0) 
    }
}