import wollok.game.*

object piedra {
    var property position = game.at(10, 10)
    method image() = "piedra_64.png"
    method chocarCon(serpiente) {
        serpiente.morir()
    }
}

object cactus {
    var property position = game.at(15, 15)
    method image() = "cactus_64.png"
    method chocarCon(serpiente) {
        serpiente.morir()
    }
}

object lava {
    var property position = game.at(20, 20)
    method image() = "lava_64.png"
    method chocarCon(serpiente) {
        serpiente.morir()
        serpiente.puntaje(0)    // solo resetea puntaje
    }
}