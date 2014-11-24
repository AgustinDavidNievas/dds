package organizador.partidos.correo
import java.util.Date
import java.io.Serializable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.OneToOne

@Entity
class Mail implements Serializable {
	
	@Id
	@GeneratedValue
	@Property Integer id
	
	@OneToOne
	@Property Mail emisor /* quien envia el mail*/
	
	@OneToOne
	@Property Mail usuario /*quien recibe el mail*/
	
	@Property Date fechaDeEnvio /*fecha del mensaje*/
	@Property String subject /* asunto*/
	@Property String body /*contenido*/
	
	
	
		new() {
					}
	  	  	  
 	 new(String asunto, String contenido){
	  	
	  	body = contenido
	  	subject= asunto
	  	
	  }	  	  
	  
	 
 

	 
	 
}