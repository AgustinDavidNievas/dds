package organizador.partidos.observer

import com.google.common.collect.Lists
import org.junit.Test
import organizador.Administrador.Admin
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido
import organizador.partidos.stub.EnviadorDeMailsStub

import static org.junit.Assert.*

class TestObserver {

	@Test
	def seAgregaUnDecimoJugadorEstandarSeNotificaAlAdmin() {

		val admin = new Admin("OHMAIGOD@tuvieja")
		val partido = new Partido("12/12/12", "a la vuelta", "las 1200", admin)
		val partidoConfirmadoObserver = new PartidoConfirmadoObserver
		val sender = new EnviadorDeMailsStub

		partidoConfirmadoObserver.aniadirEnviadorDeMails(sender)
		partido.agregarPartidoConfirmadoObserver(partidoConfirmadoObserver)

		val nombres = newArrayList("Gabriel", "Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo",
			"Gonzalo", "Roman")

		val jugadores = Lists.newArrayList(nombres.map[nombre|new Jugador(nombre, new Estandar, 10)])
		partido.inscriptos = jugadores

		val jugadorUltimo = new Jugador("Palermo", new Estandar, 13)
		partido.inscribir(jugadorUltimo)

		//Aca directamente manda todos los mails
		assertEquals(1, sender.cantidadDeMailsEnviados)

	//Este test es exactamente igual al test de correo testEnviarMailAAdminDePartidoAseguradoSeMandaMail, lo sacamos?
	}

	@Test
	def partidoNoEstaConfirmado() {

		//implementacion con observer
		val partido = new Partido
		val partidoConfirmadoObserver = new PartidoConfirmadoObserver

		partido.agregarPartidoConfirmadoObserver(partidoConfirmadoObserver)

		val nombres = newArrayList("Gabriel", "Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo")

		val jugadores = Lists.newArrayList(nombres.map[nombre|new Jugador(nombre, new Estandar, 10)])

		partido.inscriptos = jugadores

		assertFalse(partidoConfirmadoObserver.partidoConfirmado)

	}

}
