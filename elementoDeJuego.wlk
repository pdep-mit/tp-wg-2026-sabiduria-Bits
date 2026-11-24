import wollok.game.*
import nivel.*

class ElementoDeJuego {
    var property position = game.at(0, 0)

    // Metodos abstractos: cada subclase los define
    method image() { }
    method chocarCon(serpiente) { }

    // Logica comun para todos los elementos
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