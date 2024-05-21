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
	
	method esSensatoEnfrentar(peligro) = miembros.all({miembro => miembro.puedeEnfrentar(peligro)})
	
	method enfrentar(peligro) {
		if (miembros.filter({miembro => miembro.puedeEnfrentar(peligro)}).size() > peligro.personajesQueBanca()) {
			miembros.filter({miembro => miembro.puedeEnfrentar(peligro)}).forEach({participante => participante.enfrentar(peligro)})
		}
	}
}

//Personajes

class Personaje {
	var property estrategia
	var property espiritualidad
	const property poderes
	
	method capacidadDeBatalla() = poderes.sum{ poder => poder.capacidadDeBatalla(self) }
	
	method puedeEnfrentar(peligro) {
		if (peligro.tieneDesechosRadiactivos()){
			return self.capacidadDeBatalla() > peligro.capacidadDeBatalla() and self.esInmune()
		}
		else{
			return self.capacidadDeBatalla() > peligro.capacidadDeBatalla()
		}
	}
	
	method esInmune() = poderes.any({poder => poder.daInmunidad()})
	
	method enfrentar(peligro){
		if (self.puedeEnfrentar(peligro)){
			estrategia += peligro.complejidad()
		}
	}
}

//Poderes

class PoderVelocidad {
	const rapidez
	method daInmunidad() = false
	
	method agilidad (personaje) = personaje.estrategia() * rapidez
	
	method fuerza (personaje) = personaje.espiritualidad() * rapidez
	
	method habilidadEspecial (personaje) = personaje.estrategia() + personaje.espiritualidad()
	
	method capacidadDeBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
	
}

class PoderVuelo {
	const alturaMaxima
	const energiaDespegue
	method daInmunidad() = alturaMaxima > 200
	
	method agilidad (personaje) = personaje.estrategia() * alturaMaxima / energiaDespegue
	
	method fuerza (personaje) = personaje.espiritualidad() + alturaMaxima - energiaDespegue
	
	method habilidadEspecial (personaje) = personaje.estrategia() + personaje.espiritualidad()
	
	method capacidadDeBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
	
}

class PoderAmplificador {
	const poderBase
	const amplificador
	method daInmunidad() = true
	
	method agilidad (personaje) = poderBase.agilidad(personaje)
	
	method fuerza (personaje) = poderBase.fuerza(personaje)
	
	method habilidadEspecial (personaje) = poderBase.habilidadEspecial(personaje) * amplificador
	
	method capacidadDeBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
	
}

class Peligro {
	const property capacidadDeBatalla
	const property tieneDesechosRadiactivos
	const property complejidad
	const property personajesQueBanca
}




