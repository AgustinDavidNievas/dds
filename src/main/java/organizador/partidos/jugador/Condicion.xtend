package organizador.partidos.jugador

import organizador.partidos.partido.Partido
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Id
import javax.persistence.GeneratedValue
import java.io.Serializable
import javax.persistence.Column

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="CONDICION", discriminatorType=DiscriminatorType.STRING)
abstract class Condicion implements Serializable {
	
	@Id
	@GeneratedValue
	@Column(name = "id")
	@Property Integer id

	def boolean puedeInscribirse(Partido partido)

}
