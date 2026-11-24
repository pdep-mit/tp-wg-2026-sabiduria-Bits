import wollok.game.*
import elementoDeJuego.*
import nivel.*

class Obstaculo inherits ElementoDeJuego {
    // Ya no ponemos position, ni reposicionar, ni posicionLibre
    
    // 'image()' queda abstracto, lo definen las subclases

    override method chocarCon(serpiente) {
        serpiente.morir()
    }
}

class Piedra inherits Obstaculo {
    override method image() = "piedra.png"
}

class Cactus inherits Obstaculo {
    override method image() = "cactus.png"

    override method chocarCon(serpiente) {
        serpiente.restarPuntaje(5) 
        serpiente.reducirVelocidadALaMitad()
        
        // NUEVO: Mensaje con puntaje y velocidad actualizados
        console.println("🌵 ¡Choco con un Cactus! Puntaje: " + serpiente.puntaje() + " | Velocidad: " + (50 - serpiente.velocidad()).max(1))
        self.reposicionar(serpiente)
    }
}

class Lava inherits Obstaculo {
	override method image() = "lava.png"

	override method chocarCon(serpiente) {
		serpiente.restarPuntaje(10)
		if (not serpiente.cuerpo().isEmpty()) {
			const ultimo = serpiente.cuerpo().last()
			serpiente.cuerpo().remove(ultimo)
			game.removeVisual(ultimo)
		}
		console.println("🌋 ¡La lava quemó parte de la serpiente! Puntaje: " + serpiente.puntaje())
		self.reposicionar(serpiente)
	}
}