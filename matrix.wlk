object neo {
    var energia = 100
    method esElElegido() = true 
    method saltar() {
        energia /= 2
    } 

    method vitalidad() = energia / 10 
}

object morfeo {
  var vitalidad = 8
  var estaDescansado = true
  method esElElegido() = false 
  method saltar() {
    estaDescansado = not estaDescansado
    vitalidad = (vitalidad - 1).max(0)
    /*
"Uso .max() cuando quiero que el valor sea como mínimo 0"
(es decir, no dejarlo bajar de 0)
"Uso .min() cuando quiero que el valor sea como máximo 0"
(es decir, no dejarlo subir de 0)
    */
  }
}

object trinity {
  method saltar() { }

  method vitalidad() = 0

  method esElElegido() = false
}

object nave {
    const pasajeros = [neo, morfeo, trinity]
    method cuantosPasajeros() = pasajeros.size()
    method pasajeroMasVital() = pasajeros.max({p => p.vitalidad()}) 
    method estaEquilibrada() =
        pasajeros.all({p => pasajeros.all({otro => p.vitalidad() <= otro.vitalidad() * 2})
    })
    /*Para todo pasajero p, se cumple que: para todo pasajero otro, 
    la vitalidad de p es menor o igual al doble de la vitalidad de otro.”

Se puede leer así:
📖 Frase con nombres reales:
“Para cada pasajero, por ejemplo Neo, se verifica que:
Neo tiene menos o igual del doble de la vitalidad de Neo,
Neo tiene menos o igual del doble de la vitalidad de Morfeo,
Neo tiene menos o igual del doble de la vitalidad de Trinity.
Después se pasa a Morfeo, y se chequea que:
Morfeo tiene menos o igual del doble de la vitalidad de Neo,
Morfeo tiene menos o igual del doble de la vitalidad de Morfeo,
Morfeo tiene menos o igual del doble de la vitalidad de Trinity
Y lo mismo con Trinity.”
💡 Y si todas esas comparaciones se cumplen, entonces la nave está equilibrada.
*/
    method contieneElegido() = pasajeros.any({p => p.esElElegido()})

    method chocar() {pasajeros.forEach({p => p.saltar()})
    pasajeros.clear()
    }

    method acelerar() {pasajeros.filter({p => not p.esElElegido()}).forEach({p => p.saltar()})
    pasajeros.remove(neo)
    }
}