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
        serpiente.puntaje(0) // Le borra el puntaje
        console.println("🌋 ¡La serpiente cayo en Lava y perdio todos sus puntos!")
        super(serpiente) // Llama al chocarCon de Obstaculo (que la mata)
    }
}