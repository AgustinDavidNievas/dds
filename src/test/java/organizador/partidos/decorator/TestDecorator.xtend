package organizador.partidos.decorator

import com.google.common.collect.Lists
import org.junit.Test
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido

import static org.junit.Assert.*
import organizador.partidos.stub.EnviadorDeMailsStub

class TestDecorator {
	@Test
	def seAgregaUnJugadorSeConfirmadoElPartido() {

		//implementacion con decorator
		val jugador = new Jugador("Walter", new Estandar, 17)
		val partido = new Partido
		val partidoConfirmadoDecorator = new PartidoConfirmadoDecorator
		val sender = new EnviadorDeMailsStub

		partidoConfirmadoDecorator.decorado = partido
		partidoConfirmadoDecorator.aniadirEnviadorDeMails(sender)

		//el partido empieza con 9 inscriptos
		val nombres = newArrayList("Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo", "Hugo",
			"Kaka")
		val jugadores = Lists.newArrayList(nombres.map[nombre|new Jugador(nombre, new Estandar, 10)])
		partido.inscriptos = jugadores

		partidoConfirmadoDecorator.inscribir(jugador)

		assertTrue(partidoConfirmadoDecorator.partidoConfirmado)
		assertEquals(1, sender.cantidadDeMailsEnviados)
		assertTrue(partido.inscriptos.contains(jugador))

	}

	@Test
	def seInscribeJugadorSeAvisaASusAmigos() {
		val jugador = new Jugador("Walter", new Estandar, 17)
		val partido = new Partido
		val nuevoInscriptoDecorator = new NuevoInscriptoDecorator
		val sender = new EnviadorDeMailsStub

		nuevoInscriptoDecorator.decorado = partido
		nuevoInscriptoDecorator.enviadorDeMails = sender
		
		nuevoInscriptoDecorator.partido = partido
		
		//el partido empieza con 9 inscriptos
		val nombres = newArrayList("Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo", "Hugo",
			"Kaka")
		val jugadores = Lists.newArrayList(nombres.map[nombre|new Jugador(nombre, new Estandar, 10)])
		partido.inscriptos = jugadores

		nuevoInscriptoDecorator.inscribir(jugador)

		assertEquals(9, sender.cantidadDeMailsEnviados)
		assertTrue(partido.inscriptos.contains(jugador))

	}

	/*@Test
	def cadenaDeDecorators() {

		val jugador = new Jugador("Walter", new Estandar, 17)
		val partido = new Partido
		val nuevoInscriptoDecorator = new NuevoInscriptoDecorator
		val sender = new EnviadorDeMailsStub
		nuevoInscriptoDecorator.decorado = partido
		nuevoInscriptoDecorator.enviadorDeMails = sender
		nuevoInscriptoDecorator.partido = partido

		val partidoConfirmadoDecorator = new PartidoConfirmadoDecorator

		partidoConfirmadoDecorator.decorado = nuevoInscriptoDecorator
		partidoConfirmadoDecorator.aniadirEnviadorDeMails(sender)

		//el partido empieza con 9 inscriptos
		val nombres = newArrayList("Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo", "Hugo",
			"Kaka")
		val jugadores = Lists.newArrayList(nombres.map[nombre|new Jugador(nombre, new Estandar, 10)])
		partido.inscriptos = jugadores

		partidoConfirmadoDecorator.inscribir(jugador)

		assertTrue(partido.inscriptos.contains(jugador))
		assertEquals(9, sender.cantidadDeMailsEnviados)
		assertTrue(partidoConfirmadoDecorator.partidoConfirmado)
	}*/

	@Test
	def cadenaDeDecoratorsInversa() {

		val jugador = new Jugador("Walter", new Estandar, 17)
		val partido = new Partido
		val nuevoInscriptoDecorator = new NuevoInscriptoDecorator
		val sender = new EnviadorDeMailsStub
		val partidoConfirmadoDecorator = new PartidoConfirmadoDecorator
		
		
		nuevoInscriptoDecorator.decorado = partidoConfirmadoDecorator
		nuevoInscriptoDecorator.enviadorDeMails = sender
		
		nuevoInscriptoDecorator.partido = partido

		partidoConfirmadoDecorator.decorado = partido
		partidoConfirmadoDecorator.aniadirEnviadorDeMails(sender)

		//el partido empieza con 9 inscriptos
		val nombres = newArrayList("Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo", "Hugo",
			"Kaka")
		val jugadores = Lists.newArrayList(nombres.map[nombre|new Jugador(nombre, new Estandar, 10)])
		partido.inscriptos = jugadores

		nuevoInscriptoDecorator.inscribir(jugador)

		assertTrue(partido.inscriptos.contains(jugador))
		assertTrue(partidoConfirmadoDecorator.partidoConfirmado)
		assertEquals(10, sender.cantidadDeMailsEnviados)
		
	}

}
