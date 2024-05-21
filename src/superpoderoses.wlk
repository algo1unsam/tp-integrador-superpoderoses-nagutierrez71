//Equipos
class Equipo {
	const miembros
	const mejoresPoderes = #{}
	
	method miembroMasVulnerable() = miembros.min({ miembro => miembro.capacidadDeBatalla()})
	
	method calidad() = miembros.sum{ miembro => miembro.capacidadDeBatalla()}.div(miembros.size())
	
	method mejoresPoderes() {
		mejoresPoderes.clear()
		miembros.forEach({miembro => 
			mejoresPoderes.add(miembro.poderes().max({poder => 
				poder.capacidadDeBatalla(miembro)
			}))
		})
		return mejoresPoderes
	}
}

//Personajes

class Personaje {
	const property estrategia
	const property espiritualidad
	const property poderes
	
	method capacidadDeBatalla() = poderes.sum{ poder => poder.capacidadDeBatalla(self) }
}

//Poderes

class PoderVelocidad {
	const rapidez
	
	method agilidad (personaje) = personaje.estrategia() * rapidez
	
	method fuerza (personaje) = personaje.espiritualidad() * rapidez
	
	method habilidadEspecial (personaje) = personaje.estrategia() + personaje.espiritualidad()
	
	method capacidadDeBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
}

class PoderVuelo {
	const alturaMaxima
	const energiaDespegue
	
	method agilidad (personaje) = personaje.estrategia() * alturaMaxima / energiaDespegue
	
	method fuerza (personaje) = personaje.espiritualidad() + alturaMaxima - energiaDespegue
	
	method habilidadEspecial (personaje) = personaje.estrategia() + personaje.espiritualidad()
	
	method capacidadDeBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
}

class PoderAmplificador {
	const poderBase
	const amplificador
	
	method agilidad (personaje) = poderBase.agilidad(personaje)
	
	method fuerza (personaje) = poderBase.fuerza(personaje)
	
	method habilidadEspecial (personaje) = poderBase.habilidadEspecial(personaje) * amplificador
	
	method capacidadDeBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
}




