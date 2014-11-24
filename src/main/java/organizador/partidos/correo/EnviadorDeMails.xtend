package organizador.partidos.correo

import java.io.Serializable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity

@Entity
class EnviadorDeMails implements Serializable {
	
	@Id
	@GeneratedValue
	@Property Integer id

	def void enviarMail(Mail mail, String correo) {
	}
	
	new(){
		super()
	}
	
}
