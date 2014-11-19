package organizador.partidos.jugador

import organizador.partidos.partido.Partido
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Inheritance(strategy= InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="CONDICION", discriminatorType=DiscriminatorType.STRING)
abstract class Condicion {
	@Id
	@GeneratedValue
	@Property Integer id
	
	def boolean puedeInscribirse(Partido partido)
	
}