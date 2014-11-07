package organizador.partidos.decorator

import organizador.partidos.jugador.Jugador
import organizador.partidos.correo.Mail
import organizador.partidos.correo.EnviadorDeMails
import organizador.partidos.partido.Partido

class NuevoInscriptoDecorator extends Decorator {

	@Property Mail mailAvisoNuevoJugador
	@Property EnviadorDeMails enviadorDeMails

	override inscribir(Jugador jugador){
		
		//this.enviarMailDeAvisoAJugadores(this.mailAvisoNuevoJugador,this.decorado)
		this.notificarALosJugadoresQueSeInscribioAlguien(this.partido, jugador)
		this.decorado.inscribir(jugador)//decorado.inscribir
	}

	def enviarMailDeAvisoAJugadores(Mail mail, Partido partido) {
		partido.inscriptos.forEach[inscripto|enviadorDeMails.enviarMail(mail, inscripto.correo)]
	}

	def crearMailDeAvisoNuevoJugador(Jugador jugador) {
		mailAvisoNuevoJugador = new Mail("Se ha unido un nuevo jugador", "Nuevo jugador" + jugador.nombre)

	}

	def aniadirEnviadorDeMails(EnviadorDeMails enviador) {

		this.enviadorDeMails = enviador

	}

	def notificarALosJugadoresQueSeInscribioAlguien(Partido partido, Jugador jugadorQueSeInscribio) {
		this.crearMailDeAvisoNuevoJugador(jugadorQueSeInscribio)
		this.enviarMailDeAvisoAJugadores(mailAvisoNuevoJugador, partido)
	}
}
