package organizador.partidos.decorator

import organizador.partidos.jugador.Jugador
import organizador.partidos.correo.Mail
import organizador.partidos.correo.EnviadorDeMails

class PartidoConfirmadoDecorator extends Decorator {

	@Property boolean partidoConfirmado
	@Property String correoDelAdmin
	@Property EnviadorDeMails enviadorDeMails
	
	new(){
		super()
		this.correoDelAdmin = "admin@gmail.com"
	}

	override void inscribir(Jugador unJugador) {
		
		this.decorado.inscribir(unJugador)
		if (decorado.plazaLlena) {
			this.partidoConfirmado = true
			this.enviarMailDeAvisoAlAdmin(this.correoDelAdmin)
		} else {
			this.partidoConfirmado = false
		}

	}
	
	def aniadirEnviadorDeMails(EnviadorDeMails enviador) {

		this.enviadorDeMails = enviador
	}

	def crearMailDeAvisoAlAdmin() {
		this.mailAvisoAlAdmin = new Mail("Nuevo partido confirmado", "El partido ya tiene cupo confirmado")
	}

	def enviarMailDeAvisoAlAdmin(String correo) {
		this.crearMailDeAvisoAlAdmin
		this.enviadorDeMails.enviarMail(mailAvisoAlAdmin, correo)
	}
}
