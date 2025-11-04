object nave_Principal {
  var balas = 100
  var x_v = 0
  var y_v = 1

  method GetBalas() = balas
  method GetBalas(nuevo){balas= nuevo}

	var property image = "Space1-A-up.png"
	var property position = game.center()

  method CambiarPosic(imagenNueva,x,y) {
      image = imagenNueva
      x_v = x
      y_v = y
  }

}


class Disparo {
  
}


object orbe {
  // var property position = game.at(1,2)
  const property image = "Render_Sacerdote_AoE-wolo.png"

    method position() {
      // const x = 0.randomUpTo(game.width()).truncate(0)
      // const y = 0.randomUpTo(game.height()).truncate(0)

      const x = 10
      const y = 12
      return game.at(x,y)
    }
}
