package organizador.partidos.correo
import java.util.Date

class Mail {
	
	@Property Mail emisor /* quien envia el mail*/
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