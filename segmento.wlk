import wollok.game.*

class Segmento {
    var property position
    
    method image() = "cuerpo.png"
    
    method chocarCon(serpiente) {
        serpiente.morir()
    }
}