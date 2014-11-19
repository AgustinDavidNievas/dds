package organizador.partidos.jugador

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.partido.Partido

@Entity
class CondicionEdad implements Condicion {

@Property int edadMaxima
@Property int edadMinima
	
	Integer id
			
	@Id
	@GeneratedValue
	override getId() {
		this.id
	}
	@Id
	@GeneratedValue
	override setId(Integer idWacho) {
		this.id = idWacho
	}
	

	override puedeInscribirse(Partido partido) {
		
	partido.inscriptos.forall[jugadores | jugadores.edad > this.edadMinima && jugadores.edad < this.edadMaxima] 
		//devuelve un booleano
		
	}
	
new(int edadMinima, int edadMaxima){
	this.edadMaxima = edadMaxima
	this.edadMinima = edadMinima
}
	
	
	
	
}