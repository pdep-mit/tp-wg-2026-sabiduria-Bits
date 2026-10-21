import wollok.game.*
import obstaculo.*
import nivel.* // Necesario para consultar al gestor

class Comida {
    var property position = game.at(8, 8)

    method puntaje() = 10 
    method image() = "manzana.png"

    method aumentarRapidez(serpiente) {}

    method chocarCon(serpiente) {
        serpiente.comer(self)
        self.reposicionar(serpiente)
    }

    method reposicionar(serpiente) {
        const x = (0 .. game.width() - 1).anyOne()
        const y = (0 .. game.height() - 1).anyOne()
        const nuevaPosicion = game.at(x, y)

        if (self.posicionLibre(nuevaPosicion, serpiente)) {
            position =  nuevaPosicion
        } else {
            self.reposicionar(serpiente)
        }
    }

    method posicionLibre(posicion, serpiente) {
        const libreDeSerpiente = not serpiente.ocupa(posicion)
        const libreDeOtros = not gestorDeNiveles.nivelActual().ocupa(posicion, self)
        
        return libreDeSerpiente and libreDeOtros
    }

    method resetear() {
        position = game.at(5, 5)
    }
}

class Manzana inherits Comida {
    override method puntaje() = 10
    override method image() = "manzana.png"
}

class Banana inherits Comida {
    override method puntaje() = super() + 10  
    override method image() = "banana.png"

    override method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(1)
    }
}

class Cereza inherits Comida {
    override method puntaje() = super() + 20   
    override method image() = "cereza.png"

    override method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(3) 
    }
}

class FrutaDorada inherits Comida {
    override method puntaje() = super() + 40    
    override method image() = "manzana_dorada.png"

    override method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(5)
    }
}