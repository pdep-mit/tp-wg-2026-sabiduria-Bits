import wollok.game.*

class Comida {
    var property position = game.at(8, 8)

    method puntaje() = 0 
    method image() = ""

    method chocarCon(serpiente) {
        serpiente.comer(self)
        self.reposicionar()
    }

    method reposicionar() {
        var nuevaPos = self.posicionAleatoria()
        // Nos aseguramos de que no aparezca sobre la serpiente u obstáculos
        while (!(self.posicionEsLibre(nuevaPos))) {
            nuevaPos = self.posicionAleatoria()
        }
        position = nuevaPos
    }

    method posicionAleatoria() {
        const x = (0 .. game.width() - 1).anyOne()
        const y = (0 .. game.height() - 1).anyOne()
        return game.at(x, y)
    }

    method posicionEsLibre(pos) {
        return game.getObjectsIn(pos).isEmpty()
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
    override method puntaje() = 20
    override method image() = "banana.png" // Falta poner las imagenes
}

class Cereza inherits Comida {
    override method puntaje() = 30
    override method image() = "cereza.png"
}

class FrutaDorada inherits Comida {
    override method puntaje() = 50
    override method image() = "frutadorada.png"
}

const comida = new Manzana()