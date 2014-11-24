package organizador.partidos.jugador.Infracciones

import organizador.partidos.jugador.Jugador
import javax.persistence.Id
import javax.persistence.GeneratedValue
import java.io.Serializable
import javax.persistence.Entity

@Entity
abstract class Infraccion implements Serializable {

	@Id
	@GeneratedValue
	@Property Integer id

	def void penalizarA(Jugador jugador)

	def void horaInfraccion()

	def String fechaInfraccion()

	def void penalizarConDescripcion(String descripcion, Jugador jugador)

}
