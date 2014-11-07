package organizador.partidos.jugador

import com.google.common.collect.Lists
import org.junit.Before
import org.junit.Test
import organizador.partidos.jugador.Infracciones.InfraccionSeDaDeBajaSinRemplazante
import organizador.partidos.partido.Partido
import organizador.partidos.stub.EnviadorDeMailsStub

import static org.junit.Assert.*
import organizador.Administrador.Admin
import java.util.List

class TestInscripciones {

	Partido partido
	List<String> nombres8
	List<Jugador> jugadoresEstandar
	List<Jugador> jugadoresSolidarios
	Jugador jugadorEstandar
	Jugador jugadorSolidario

	@Before
	def void setup() {
		partido = new Partido
		nombres8 = newArrayList("Gabriel", "Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo")
		jugadoresEstandar = Lists.newArrayList(nombres8.map[nombre|new Jugador(nombre, new Estandar, 42)])
		jugadoresSolidarios = Lists.newArrayList(nombres8.map[nombre|new Jugador(nombre, new Solidario, 10)])
		jugadorSolidario = new Jugador("roman", new Solidario, 10)
		jugadorEstandar = new Jugador("Henry", new Estandar, 15)
	}

	@Test
	def testSeAnotaJugadorEstandarYDebeXAparecerEnLaListaDeInscriptos() {

		jugadorEstandar.tipo = new Estandar

		partido.inscribir(jugadorEstandar)

		assertEquals(1, partido.inscriptos.size)
	}

	@Test
	def testSonTodosSolidarios() {

		partido.inscriptos = jugadoresSolidarios
		partido.inscribir(jugadorSolidario)

		assertEquals(9, partido.listaDeSolidarios.size)
	}

	@Test
	def testEnListaCon10EstandarNoDejaNuevosInscriptos() {

		//Escenario
		partido.inscriptos = jugadoresEstandar
		jugadoresEstandar.add(new Jugador("Roman", new Estandar, 10))
		jugadoresEstandar.add(new Jugador("Alan Brado", new Estandar, 10))

		//Accion
		partido.inscribir(jugadorEstandar)

		//Validacion
		assertFalse(partido.inscriptos.contains(jugadorEstandar))
	}

	@Test
	def testSosSolidario() {

		assertTrue(jugadorSolidario.sosSolidario)
	}

	@Test
	def testSeInscribenMasDeUnSolidarioEntraElEstandarSalePrimerSolidarioQueEntro() {

		//Escenario
		var jugadorAdmitido = new Jugador("admitido", new Estandar, 19)
		var jugadorSolidario2 = new Jugador("solidario2", new Solidario, 19)

		partido.inscriptos = jugadoresEstandar

		// 8 jugadores estandar
		partido.inscribir(jugadorSolidario)
		partido.inscribir(jugadorSolidario2)

		assertTrue(partido.inscriptos.contains(jugadorSolidario))
		assertTrue(partido.inscriptos.contains(jugadorSolidario2))

		partido.inscribir(jugadorAdmitido)

		assertFalse(partido.inscriptos.contains(jugadorSolidario))
		assertTrue(partido.inscriptos.contains(jugadorSolidario2))
		assertTrue(partido.inscriptos.contains(jugadorAdmitido))
	}

	@Test
	def testEnPartidoPlazaLlenaNoAseguradaEntraSolidarioSaleCondicional() {

		//Escenario
		var condicion = new CondicionPeso(20)

		var jugadorCondicional = new Jugador("condicional", new Condicional(condicion), 12)

		jugadoresEstandar.add(new Jugador("Roman", new Estandar, 10))

		partido.inscriptos = jugadoresEstandar

		//Accion								  
		partido.inscribir(jugadorCondicional)
		partido.inscribir(jugadorSolidario)

		//Validacion
		assertFalse(partido.inscriptos.contains(jugadorCondicional))

	}

	@Test
	def testJugadorCondicionalCumpleCondicionPeso() {

		//Escenario
		var condicion1 = new CondicionPeso(42)
		var condicion = new Condicional(condicion1)
		var jugadorCondicional = new Jugador("Meli", condicion, 12)

		nombres8.add("Roman")

		partido.inscriptos = jugadoresEstandar

		//accion
		partido.inscribir(jugadorCondicional)

		//validacion
		assertTrue(partido.inscriptos.contains(jugadorCondicional))
	}

	@Test
	def testJugadorCondicionalCumpleCondicionEdad() {

		//Escenario
		var condicion1 = new CondicionEdad(40, 60)
		var condicionMeli = new Condicional(condicion1)
		var jugadorCondicional = new Jugador("Meli", condicionMeli, 33)

		partido.inscriptos = jugadoresEstandar
		jugadoresEstandar.add(new Jugador("Elbo", new Estandar, 42))

		//accion
		partido.inscribir(jugadorCondicional)

		//validacion
		assertTrue(partido.inscriptos.contains(jugadorCondicional))
	}

	@Test
	def testJugadorCondicionalCumpleCondicionTurno() {

		//Escenario
		var condicion1 = new CondicionTurno("M")
		var condicional = new Condicional(condicion1)
		var jugadorCondicional = new Jugador("Meli", condicional, 12)
		partido.setTurno("M")

		//accion
		partido.inscribir(jugadorCondicional)

		//validacion
		assertTrue(partido.inscriptos.contains(jugadorCondicional))
	}

	@Test
	def testjugadorSinConfirmarSeDaDeBajaYaNoEstaEnListaJugadores() {

		val admin = new Admin("OHMAIGOD@tuvieja")
		val partido = new Partido("12/12/12", "a la vuelta", "las 1200", admin)
		val sender = new EnviadorDeMailsStub

		partido.infraccion = new InfraccionSeDaDeBajaSinRemplazante
		partido.setEnviadorDeMails(sender)

		partido.infraccion = new InfraccionSeDaDeBajaSinRemplazante
		partido.setInfraccion(new InfraccionSeDaDeBajaSinRemplazante)
		partido.inicializarInscriptos
		partido.inscribir(jugadorEstandar)

		assertEquals(1, partido.inscriptos.size)
		jugadorEstandar.darseDeBajaSinReemplazo(partido)

		assertFalse(partido.inscriptos.contains(jugadorEstandar))

	}

	@Test
	def testJugadorSeDaDeBajaEsPenalizado() {

		//implementacion con observers
		val admin = new Admin("OHMAIGOD@tuvieja")
		val partido = new Partido("12/12/12", "a la vuelta", "las 1200", admin)

		val sender = new EnviadorDeMailsStub

		partido.setEnviadorDeMails(sender)

		partido.infraccion = new InfraccionSeDaDeBajaSinRemplazante
		partido.inicializarInscriptos

		//partido.setCorreoDelAdmin("ImFabulous@sexy")
		partido.inscribir(jugadorEstandar)
		jugadorEstandar.darseDeBajaSinReemplazo(partido)
		assertEquals(0, partido.inscriptos.size)
		assertEquals(90, jugadorEstandar.peso)

	}

	@Test
	def testJugadorSeDaDeBajaConRemplazoEstaEnLaListaDeInscriptos() {

		val admin = new Admin("OHMAIGOD@tuvieja")
		val partido = new Partido("12/12/12", "a la vuelta", "las 1200", admin)
		val jugadorQueArruga = new Jugador("Fer", new Estandar, 29)
		val jugadorReemplazante = new Jugador("Dani", new Solidario, 13)
		val sender = new EnviadorDeMailsStub

		partido.infraccion = new InfraccionSeDaDeBajaSinRemplazante
		partido.setEnviadorDeMails(sender)

		//partido.setCorreoDelAdmin("ImFabulous@sexy")
		partido.inscribir(jugadorQueArruga)
		jugadorQueArruga.darseDeBajaConReemplazo(partido, jugadorReemplazante)

		assertTrue(partido.inscriptos.contains(jugadorReemplazante))
		assertFalse(partido.inscriptos.contains(jugadorQueArruga))

	}
}
