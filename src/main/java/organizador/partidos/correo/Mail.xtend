package organizador.partidos.correo
import java.util.Date
import java.io.Serializable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.OneToOne
import javax.persistence.Column
import javax.persistence.JoinColumn

@Entity
class Mail implements Serializable {
	
	@Id
	@GeneratedValue
	@Column(name = "id")
	@Property Integer id
	
	@OneToOne
	@JoinColumn(name="emisor")
	@Property Mail emisor /* quien envia el mail*/
	
	@OneToOne
	@JoinColumn(name="usuario")
	@Property Mail usuario /*quien recibe el mail*/
	
	@Column(name="fechaDeEnvio")
	@Property Date fechaDeEnvio /*fecha del mensaje*/
	
	@Column(name="subject")
	@Property String subject /* asunto*/
	
	@Column(name="body")
	@Property String body /*contenido*/
	
	
	
		new() {
					}
	  	  	  
 	 new(String asunto, String contenido){
	  	
	  	body = contenido
	  	subject= asunto
	  	
	  }	  	  
	  
	 
 

	 
	 
}