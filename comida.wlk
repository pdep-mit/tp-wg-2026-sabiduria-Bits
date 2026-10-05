import wollok.game.*

object comida {
    var property position = game.at(5,5)
    method image() = "comida.png"
    method chocarCon(serpiente){
        serpiente.crecer()
        self.reposicionar()
    }
    method reposicionar(){
        const x = (0 .. game.width()-1).anyOne()
        const y = (0 .. game.width()-1).anyOne()
        position = game.at(x, y)
    }
}