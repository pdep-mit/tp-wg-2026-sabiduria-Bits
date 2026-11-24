import wollok.game.*
import elementoDeJuego.*
import nivel.* 

class Comida inherits ElementoDeJuego {
    // Ya no ponemos 'var property position' porque lo hereda de ElementoDeJuego

    method puntaje() = 10 
    
    // 'image()' queda abstracto aca, lo definen las subclases (Manzana, etc)
    
    method aumentarRapidez(serpiente) {
        serpiente.aumentarVelocidad(1)
    }

    override method chocarCon(serpiente) {
        serpiente.comer(self)
        self.reposicionar(serpiente)
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
        serpiente.aumentarVelocidad(2)
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