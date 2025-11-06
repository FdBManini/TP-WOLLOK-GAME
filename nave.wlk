object nave_Principal {
  var balas = 100
  var x_m = 0
  var y_m = 1
  var puntaje = 0

  method GetBalas() = balas
  method GetBalas(nuevo){balas= nuevo}

	var property image = "Space1-A-up.png"
	var property position = game.center()

  method CambiarPosic(imagenNueva,x,y) {
      image = imagenNueva
      x_m = x
      y_m = y
  }

  method Aumentar_Puntaje() {
      puntaje += 1 
  }

  method Destruir(){}

// saber para donde mira
  method M_Arriba()     = y_m == 1
  method M_Abajo()      = y_m == -1
  method M_Izquierda()  = x_m == -1
  method M_Derecha()    = x_m == 1
  
  method Get_x() = x_m
  method Get_y() = y_m

  method E_Destruir(){}

  method Perder(){
        game.say(self, "Me dieron")
        // game.stop()
        puntaje -= 1 

  }  
}

object inicilizacion {

  method Init_orbe(orbe) {
    	game.addVisual(orbe)

  }
    method Init_enemigo(enemigo) {
    	game.addVisual(enemigo)
      game.onTick(100, "movimiento-enemigo",
      {enemigo.UpdatePosc()
      enemigo.reaparecer()})
    	
      game.onCollideDo(enemigo, { elemento =>
        elemento.Perder()
        nave_Principal.Aumentar_Puntaje()
      })

  }
}


object disparo { //class Disparo
  	var property position = nave_Principal.position()
    var property image = "laser-bolts-2.png"

    method Disparar() { 
      if(game.hasVisual(self) ) {
              game.removeVisual(self) 
              game.removeTickEvent("movimiento-Disparo")
              position = nave_Principal.position()
              game.addVisual(self) 
              self.Timer()
      } else {
              position = nave_Principal.position()
              game.addVisual(self) 
              self.Timer()
      }
    }
    method Timer() {
      game.onTick(50, "movimiento-Disparo", {self.UpdatePosc()})
    }

    method UpdatePosc() {
     const unid_mov = 1

      if (nave_Principal.M_Arriba()) {
        position = position.up(unid_mov)
      }

      if (nave_Principal.M_Abajo()) {
        position = position.down(unid_mov)
      }

      if (nave_Principal.M_Izquierda()) {
        position = position.left(unid_mov)
      }
      if (nave_Principal.M_Derecha()) {
        position = position.right(unid_mov)
      }
    }

    method Destruir(){}
    method Perder(){}

}

object randPosc {
  method GetX(min) {
    return (min.randomUpTo(game.width()).truncate(0))
  }
  method GetY(min) {
    return (min.randomUpTo(game.height()).truncate(0))
  }
}

class Orbe { //class Orbe
  var property position = game.at(randPosc.GetX(10),randPosc.GetX(12))
  var property image = "Orbe.png"

    method Destruir() {
      game.removeVisual(self) 
      nave_Principal.Aumentar_Puntaje()
    }
    method E_Destruir(){}
    method Terminar(){}
    method Perder(){}

}


class Enemigo { //class enemigo
  var property position = game.at(randPosc.GetX(2),randPosc.GetY(2))
  const direccion = 0 // -1 no se mueven  0 horizontal 1 vertical 2 los dos

  const property image = "Render_Sacerdote_AoE-wolo.png"

    method timer() {
      game.onTick(10000, "movimiento-enemigo", {self.UpdatePosc()
      self.reaparecer()})}

    method E_Destruir(){
      game.removeVisual(self) 
    }

    method UpdatePosc() {
      const unid_mov = 1

    if(self.Dir_ninguna()){
        if (self.Dir_Horizontal() || self.Dir_Vertical_Horizontal()){
          if(position.x() > game.width()) position = game.at(-2,randPosc.GetY(4)) 
          else  position = position.right(unid_mov) 
        }
        if (self.Dir_Vertical() || self.Dir_Vertical_Horizontal()){
          if(position.y() < 0 ) position = game.at(randPosc.GetX(4),game.height())
          else  position = position.down(unid_mov) 
        }
      }
    }

    method Dir_ninguna() = direccion != -1  
    method Dir_Horizontal() = direccion == 0
    method Dir_Vertical() = direccion == 1
    method Dir_Vertical_Horizontal() = direccion == 2



    method Destruir(){}
    method Perder(){}
}