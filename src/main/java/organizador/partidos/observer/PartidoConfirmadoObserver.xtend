package organizador.partidos.observer

import organizador.partidos.partido.Partido
import organizador.partidos.correo.EnviadorDeMails
import organizador.partidos.correo.Mail
import java.util.List
import java.util.ArrayList

class PartidoConfirmadoObserver {

	@Property boolean partidoConfirmado
	@Property EnviadorDeMails enviadorDeMails
	@Property Mail mailAvisoAlAdmin
	@Property List<String> listaCorreoJugadores = new ArrayList

	new() {
		this.partidoConfirmado = false
	}

	def estoyConfirmado(Partido partido) {
		if (partido.plazaLlena) {
			this.partidoConfirmado = true
			this.enviarMailDeAvisoAlAdmin(partido.administrador.getCorreo) //hacer metodo que pida mail, asi no rompe encapsulamiento
		}else{	
			this.partidoConfirmado = false			
		}
	}

	def aniadirEnviadorDeMails(EnviadorDeMails enviador) {

		this.enviadorDeMails = enviador

	}

	def enviarMailDeAvisoAlAdmin(String correo) {
		this.crearMailDeAvisoAlAdmin
		this.enviadorDeMails.enviarMail(mailAvisoAlAdmin, correo)

	}

	def crearMailDeAvisoAlAdmin() {
		this.mailAvisoAlAdmin = new Mail("Nuevo partido confirmado", "El partido ya tiene cupo confirmado")
	}

}
