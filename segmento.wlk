import wollok.game.*

class Segmento {
    var property position
    
    method image() = "segmento.png"
    
    method moverA(nuevaPosicion) {
        position = nuevaPosicion
    }

    method chocarCon(serpiente) {
        serpiente.morir() // O la acción/efecto de colisionar con el propio cuerpo
    }
}