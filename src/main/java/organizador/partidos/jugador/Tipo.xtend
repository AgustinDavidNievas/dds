package organizador.partidos.jugador

import organizador.partidos.partido.Partidoimport javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.DiscriminatorColumn
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorType
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Inheritance(strategy= InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="TIPO", discriminatorType=DiscriminatorType.STRING)
abstract class Tipo {
	
	@Id
	@GeneratedValue
	@Property Integer id
	
		
	def int dameTuPrioridad()
	
	def void inscribirseA(Partido partido)
	
	def void setJugador(Jugador jugador)
	


}