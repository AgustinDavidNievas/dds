package organizador.partidos.correo

import java.io.Serializable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity
import javax.persistence.Column

@Entity
class EnviadorDeMails implements Serializable {
	
	@Id
	@GeneratedValue
	@Column(name = "id")
	@Property Integer id

	def void enviarMail(Mail mail, String correo) {
	}
	
	new(){
		super()
	}
	
}
