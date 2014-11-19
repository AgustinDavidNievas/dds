package organizador.partidos.jugador

import organizador.partidos.partido.Partido
import javax.persistence.Entity

@Entity
interface Condicion {
	
	def boolean puedeInscribirse(Partido partido)
	
	def Integer getId()
	
	def void setId(Integer id)
	
}