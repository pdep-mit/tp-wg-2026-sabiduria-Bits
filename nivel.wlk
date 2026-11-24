import wollok.game.*
import obstaculo.*
import serpiente.*
import comida.*

object pantallaGameOver {
    method position() = game.at(0, 0)
    method image() = "game_over.png"
}

object pantallaFinDelJuego {
    method position() = game.at(0, 0)
    method image() = "fin_del_juego.png"
}

object pantallaTransicion {
    method position() = game.at(0, 0)
    method image() = gestorDeNiveles.nivelActual().imagen()
}

class Nivel {
    const property elementos = []
    const property puntajeObjetivo 
    const property imagen 

    method iniciar() {
        elementos.forEach({ elem =>
            elem.reposicionar(serpiente)
            game.addVisual(elem)
        })
    }

    method terminar() {
        elementos.forEach({ elem => 
            if (game.hasVisual(elem)) { 
                game.removeVisual(elem) 
            }
        })
    }

    //El nivel sabe si una posición está ocupada por otro elemento
    method ocupa(posicion, elementoIgnorado) {
        return elementos.any({ elem => elem != elementoIgnorado and elem.position() == posicion })
    }
}

object gestorDeNiveles {
    var property indiceNivelActual = 0

    const niveles = [
        // Nivel 1: Ahora tiene manzana, banana y cereza para variar mas  y dos obstaculos
        new Nivel (
			elementos = [new Manzana(), new Banana(), new Cereza(), new Piedra(), new Piedra()],
			puntajeObjetivo = 100,
			imagen = "nivell.png"
		),
    // Nivel 2: Ahora tiene manzana, banana y cereza, más dos piedras y un cactus
		new Nivel (
			elementos = [new Manzana(), new Banana(), new Cereza(), new Piedra(), new Piedra(), new Cactus()],
			puntajeObjetivo = 200,
			imagen = "nivel2.png"
		),
        // Nivel 3: Ya tiene que esquivar más cosas
        new Nivel(elementos = [new Manzana(), new Piedra(), new Cactus(), new Cactus(), new FrutaDorada()], puntajeObjetivo = 300, imagen = "nivel3.png"),

        // Nivel 4: Aparecen bananas y cerezas
        new Nivel(elementos = [new Banana(), new Cereza(), new Piedra(), new Piedra(), new Cactus(), new Lava()], puntajeObjetivo = 400, imagen = "nivel4.png"),

        // Nivel 5: Nivel final, mucha fruta buena pero mucho peligro
        new Nivel(elementos = [new Manzana(), new Banana(), new Cereza(), new FrutaDorada(), new Piedra(), new Piedra(), new Cactus(), new Cactus(), new Lava(), new Lava()], puntajeObjetivo = 500, imagen = "nivel5.png")
    ]

    method nivelActual() = niveles.get(indiceNivelActual)

    method tiempoDeJuego() = (300 - (indiceNivelActual * 40)).max(60)

    method verificarProgreso(puntajeActual) {
        if (puntajeActual >= self.nivelActual().puntajeObjetivo()) {
            if (indiceNivelActual < niveles.size() - 1) {
                self.efectoTransicion()
            } else {
                self.efectoFinDelJuego()
            }
        }
    }

    method efectoFinDelJuego() {
        serpiente.pausar()
        self.nivelActual().terminar()
        game.addVisual(pantallaFinDelJuego)
    }

    method iniciarJuego() {
        self.mostrarPantallaTransicion()
    }

    method efectoTransicion() {
        serpiente.pausar()
        self.nivelActual().terminar()
        indiceNivelActual = (indiceNivelActual + 1).min(niveles.size() - 1)
        self.mostrarPantallaTransicion()
    }

    method mostrarPantallaTransicion() {
        serpiente.pausar()
        game.addVisual(pantallaTransicion)
        
        game.schedule(2000, {
            game.removeVisual(pantallaTransicion)
            self.cargarNivelActual()
            serpiente.reanudar() 
        })
    }

    method cargarNivelActual() {
        self.nivelActual().iniciar()
    }

    method resetear() {
        self.nivelActual().terminar()
        if (game.hasVisual(pantallaTransicion)) {
            game.removeVisual(pantallaTransicion)
        }
        if (game.hasVisual(pantallaFinDelJuego)) {
            game.removeVisual(pantallaFinDelJuego)
        }
        indiceNivelActual = 0
        self.iniciarJuego()
    }
}