package organizador.partidos.jugador

import org.junit.Test
import organizador.Administrador.Admin
import organizador.partidos.partido.Partido

import static org.junit.Assert.*
import org.junit.Before

class TestAmigos {

	Jugador jugador1
	Postulante amigo
	Admin admin
	Partido partido


	@Before
	
	def void setup(){
		
		 jugador1 = new Jugador("Adolf", new Estandar, 20)
		 amigo = new Postulante("Rafa", new Estandar, 20)
		 admin = new Admin("ola Ke ase")
		 partido = new Partido("12/12/12", "Ruta 8  Km 12", "Cuando pinte", admin)
	}

	@Test
	def testProponerAmigos() {
		
		var amigo2 = new Postulante("Jorge", new Estandar, 21)
		var amigo3 = new Postulante("Raul", new Estandar, 23)


		partido.inscribir(jugador1)
		jugador1.postularAmigo(amigo, partido)
		jugador1.postularAmigo(amigo2, partido)
		jugador1.postularAmigo(amigo3, partido)

		assertTrue(admin.pendientes.size == 3)
	}

	@Test
	def testAceptarPostulate() {
		
	
		partido.inscribir(jugador1)
		jugador1.postularAmigo(amigo, partido)
		admin.aceptarSolicitud(amigo)

		assertTrue(partido.inscriptos.size == 2)

	}

	@Test
	def testRechazarPostulante() {
		
		partido.inscribir(jugador1)
		jugador1.postularAmigo(amigo, partido)
		admin.rechazarSolicitud(amigo)

		assertTrue((admin.rechazados.map(rechazado|rechazado.postulante).toList).contains(amigo))
	}

}
