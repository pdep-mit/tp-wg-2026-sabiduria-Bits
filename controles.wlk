import wollok.game.*
import serpiente.*
import direccion.*
import nivel.*

object controles {
    method configurar() {
        // Movimiento con WASD
        keyboard.w().onPressDo { serpiente.cambiarDireccion(arriba) }
        keyboard.s().onPressDo { serpiente.cambiarDireccion(abajo) }
        keyboard.a().onPressDo { serpiente.cambiarDireccion(izquierda) }
        keyboard.d().onPressDo { serpiente.cambiarDireccion(derecha) }

        // Movimiento con Flechas
        keyboard.up().onPressDo { serpiente.cambiarDireccion(arriba) }
        keyboard.down().onPressDo { serpiente.cambiarDireccion(abajo) }
        keyboard.left().onPressDo { serpiente.cambiarDireccion(izquierda) }
        keyboard.right().onPressDo { serpiente.cambiarDireccion(derecha) }

        // Reiniciar y Salir
        keyboard.r().onPressDo {
            serpiente.resetear()
            gestorDeNiveles.resetear()
        }
        keyboard.f().onPressDo { game.stop() }

        //faltaria poner una tecla de pausa P (a futuro)
    }
}