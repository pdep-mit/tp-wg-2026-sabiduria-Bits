import wollok.game.*
import serpiente.*

object marcador {
    method position() = game.at(1, 1) 
    

    method text() = "Puntos: " + serpiente.puntaje().toString()
    
    
    method textColor() = "#FFFFFF" 


    // Agregar chocarCon para que no falle
    method chocarCon(serpiente) {
        // No hace nada (es un marcador)
    }
}