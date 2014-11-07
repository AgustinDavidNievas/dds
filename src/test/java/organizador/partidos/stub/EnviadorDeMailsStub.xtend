package organizador.partidos.stub

import organizador.partidos.correo.EnviadorDeMails
import organizador.partidos.correo.Mail

class EnviadorDeMailsStub extends EnviadorDeMails {

	@Property int cantidadDeMailsEnviados = 0

	override void enviarMail(Mail mail, String correo) {
		cantidadDeMailsEnviados = cantidadDeMailsEnviados + 1
	
	}
	
	
	

}
 
 