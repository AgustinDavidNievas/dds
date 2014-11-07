package organizador.partidos.observer

import organizador.partidos.partido.Partido
import organizador.partidos.jugador.Jugador
import organizador.partidos.correo.Mail
import organizador.partidos.correo.EnviadorDeMails

class NuevoInscriptoObserver {

	@Property Mail mailAvisoNuevoJugador
	@Property EnviadorDeMails enviadorDeMails

	def notificarALosJugadoresQueSeInscribioAlguien(Partido partido, Jugador jugadorQueSeInscribio) {
		this.crearMailDeAvisoNuevoJugador(jugadorQueSeInscribio)
		this.enviarMailDeAvisoAJugadores(mailAvisoNuevoJugador, partido)
			
		
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

}
