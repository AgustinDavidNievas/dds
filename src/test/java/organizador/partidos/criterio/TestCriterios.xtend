package organizador.partidos.criterio

import org.junit.Before
import org.junit.Test
import organizador.Administrador.Admin
import organizador.partidos.criterios.CriterioPromedioNCalificaciones
import organizador.partidos.criterios.Handicap
import organizador.partidos.criterios.UltimasCalificaciones
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido

import static org.junit.Assert.*
import organizador.partidos.criterios.Mix
import java.util.ArrayList
import java.util.Arrays

class TestCriterios {

	Partido partido
	Jugador jugador1
	Jugador jugador2
	Jugador jugador3
	Jugador jugador4
	Admin admin

	@Before
	def void setup() {

		jugador1 = new Jugador("Daniel", new Estandar, 58)
		jugador2 = new Jugador("Hugo", new Estandar, 24)
		jugador3 = new Jugador("Iroito", new Estandar, 12)
		jugador4 = new Jugador("Raul", new Estandar, 12)
		admin = new Admin("sonOfA***@fuckOff.ass")
		admin.administrasA(partido)
		partido = new Partido("3/3/3", "alun lugar", "cuando pinte", admin)

	}

	@Test
	def seOrdenaLaListaSegunElCriterioHandicap() {

		val handicap = new Handicap

//		partido.inscribir(jugador1)
//		partido.inscribir(jugador2)
//		partido.inscribir(jugador3)
//		partido.inscribir(jugador4)
		val jugadores = Arrays.asList(jugador1, jugador2, jugador3, jugador4)

		jugadores.forEach[ j | partido.inscribir(j) ]


		jugador1.handicap = 7
		jugador2.handicap = 6
		jugador3.handicap = 9
		jugador4.handicap = 1

//		handicap.definirHandicap(jugador1, 7)
//		handicap.definirHandicap(jugador2, 6)
//		handicap.definirHandicap(jugador3, 9)
//		handicap.definirHandicap(jugador4, 1)

		admin.ordenarJugadoresPor(handicap)

		assertEquals(partido.inscriptos.get(0), jugador3)
		assertEquals(partido.inscriptos.get(1), jugador1)
		assertEquals(partido.inscriptos.get(2), jugador2)
		assertEquals(partido.inscriptos.get(3), jugador4)
	}

	@Test
	def testOrdenarListaSegunUltimasCalificaciones() {

		val criterio = new UltimasCalificaciones

		partido.inscribir(jugador1)
		partido.inscribir(jugador2)
		partido.inscribir(jugador3)
		partido.inscribir(jugador4)

		jugador1.calificarA(jugador2, 4, "que se yo estoy re loco")
		jugador3.calificarA(jugador2, 4, "que se yo estoy re loco")

		jugador1.calificarA(jugador3, 5, "que se yo estoy re loco")
		jugador2.calificarA(jugador3, 4, "que se yo estoy re loco")

		jugador2.calificarA(jugador1, 10, "que se yo estoy re loco")
		jugador3.calificarA(jugador1, 4, "que se yo estoy re loco")

		jugador2.calificarA(jugador4, 5, "que se yo estoy re loco")
		jugador3.calificarA(jugador4, 3, "que se yo estoy re loco")

		admin.ordenarJugadoresPor(criterio)

		assertTrue(partido.inscriptos.get(0) == jugador1)

	}

	@Test
	def seOrdenaPorCriterioPromedioDe2DevuelveListaOrdenada() {
		val criterioDePromedioN = new CriterioPromedioNCalificaciones(2)

		partido.agregar(jugador1)
		partido.agregar(jugador2)
		partido.agregar(jugador3)
		partido.agregar(jugador4)

		jugador1.calificarA(jugador2, 5, "que se yo estoy re loco")
		jugador3.calificarA(jugador2, 5, "que se yo estoy re loco")
		jugador4.calificarA(jugador2, 1, "que se yo estoy re loco")

		jugador1.calificarA(jugador3, 6, "que se yo estoy re loco")
		jugador2.calificarA(jugador3, 6, "que se yo estoy re loco")
		jugador4.calificarA(jugador3, 10, "que se yo estoy re loco")

		jugador2.calificarA(jugador1, 8, "que se yo estoy re loco")
		jugador3.calificarA(jugador1, 8, "que se yo estoy re loco")
		jugador4.calificarA(jugador1, 3, "que se yo estoy re loco")

		jugador2.calificarA(jugador4, 10, "que se yo estoy re loco")
		jugador3.calificarA(jugador4, 10, "que se yo estoy re loco")
		jugador1.calificarA(jugador4, 3, "que se yo estoy re loco")

		//TODO: que pasa si nadie lo calificó?
//		criterioDePromedioN.setNumero(2) //Como hacemos para que no todos tengan el metodo en la interfaz??
		admin.ordenarJugadoresPor(criterioDePromedioN)

		assertEquals(jugador4, partido.inscriptos.get(0))
		assertEquals(jugador1, partido.inscriptos.get(1))
		assertEquals(jugador3, partido.inscriptos.get(2))
		assertEquals(jugador2, partido.inscriptos.get(3))

	}

	//	@Test
	//	def testSeDefineUnNParaCriterioPromedioDeNDevuelveN() {
	//
	//		val criterioDePromedioN = new CriterioPromedioNCalificaciones
	//
	//		admin.definirN(criterioDePromedioN, 2)
	//		assertEquals(2, criterioDePromedioN.numero)
	//	}
	@Test
	def testOrdenarListaSegunMix() {

		val mix = new Mix
		val criterioDePromedioN = new CriterioPromedioNCalificaciones(2)
		val handicap = new Handicap

		mix.criterios = new ArrayList

		mix.criterios.add(handicap)
		mix.criterios.add(new UltimasCalificaciones)
		mix.criterios.add(criterioDePromedioN)

		partido.inscribir(jugador1)
		partido.inscribir(jugador2)
		partido.inscribir(jugador3)
		partido.inscribir(jugador4)

		handicap.definirHandicap(jugador1, 7)

		handicap.definirHandicap(jugador2, 6)

		handicap.definirHandicap(jugador3, 9)

		handicap.definirHandicap(jugador4, 1)

		jugador1.calificarA(jugador2, 4, "que se yo estoy re loco")
		jugador3.calificarA(jugador2, 4, "que se yo estoy re loco")

		jugador1.calificarA(jugador3, 5, "que se yo estoy re loco")
		jugador2.calificarA(jugador3, 4, "que se yo estoy re loco")

		jugador2.calificarA(jugador1, 10, "que se yo estoy re loco")
		jugador3.calificarA(jugador1, 4, "que se yo estoy re loco")

		jugador2.calificarA(jugador4, 5, "que se yo estoy re loco")
		jugador3.calificarA(jugador4, 3, "que se yo estoy re loco")


		admin.ordenarJugadoresPor(mix)

		//orden esperado jugaor1, jugador 2, jugador 3 y jugador 4
		assertEquals(partido.inscriptos.get(0), jugador1)
		assertEquals(partido.inscriptos.get(1), jugador3)
		assertEquals(partido.inscriptos.get(2), jugador2)
		assertEquals(partido.inscriptos.get(3), jugador4)
	}
}
