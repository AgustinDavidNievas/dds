package organizador.partidos.creador

import java.util.List
import organizador.partidos.jugador.Jugador

class CreadorDeEquipos {
	
	@Property String nombre 
	new(){
		super()
	}
	
	new(String nombre){
		this.nombre = nombre
	}
	
	def void crearEquiposTentativos(List<Jugador> listaDeJugadores){
		
	}
	
	def List<Jugador> verEquipoTentativo1(){
		
	}
	
	def List<Jugador> verEquipoTentativo2(){
		
	}
	
}

