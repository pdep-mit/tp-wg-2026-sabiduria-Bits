import direccion.*


object serpiente {
    var property position = game.at(5, 5)
    var property direccion = derecha
    var property puntaje = 0
    var viva = true


    // 1. Cambio de dirección con validación de 180°
    method cambiarDireccion(nuevaDireccion) {
        if (!direccion.esOpuesta(nuevaDireccion)) {
            direccion = nuevaDireccion
        }
    }


    // 2. Movimiento
    method avanzar() {
        if (viva) {
            position = direccion.siguientePosicion(position)
            self.verificarBorde()
        }
    }
/*
    method verificarBorde() {
        const x = position.x()
        const y = position.y()
       
        if (x < 0) {
            position = game.at(game.width() - 1, y)
        } else if (x >= game.width()) {
            position = game.at(0, y)
        } else if (y < 0) {
            position = game.at(x, game.height() - 1)
        } else if (y >= game.height()) {
            position = game.at(x, 0)
        }
    }
*/
    method verificarBorde() {
    const x = position.x()
    const y = position.y()
   
    if (x < 0 || x >= game.width() || y < 0 || y >= game.height()) {
        self.morir()
    }
}


    // 3. Comer
    method comer(comida) {
        puntaje += comida.puntaje()
        self.crecer()
    }


    // 4. Crecer (por ahora no hace nada)
    method crecer() {
        // TODO: agregar un segmento al cuerpo (Checkpoint 2)
    }


    method resetear() {
        position = game.at(5, 5)
        direccion = derecha
        puntaje = 0
        viva = true
    }


    // 5. Morir
    method morir() {
        viva = false
        game.say(self, "¡Game Over! Presiona R para reiniciar o F para salir")
        //game.stop()
        console.println("================================")
        console.println("         ¡GAME OVER!            ")
        console.println("================================")
        console.println("Presiona R para reiniciar")
        console.println("Presiona F para salir")
        console.println("================================")
    }


    // 6. Consulta de estado
    method estaViva() = viva


    // 7. Imagen para Wollok Game
    method image() = "snake_cabeza_64.png"


    //method imageSize() = game.at(0.5, 0.5)
}



