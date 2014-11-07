package organizador.partidos.creadorEquiposTentativos

import com.google.common.collect.Lists
import java.util.List
import org.junit.Before
import org.junit.Test
import organizador.Administrador.Admin
import organizador.partidos.creador.CreadorAlgoritmo1
import organizador.partidos.creador.CreadorAlgoritmo2
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido

import static org.junit.Assert.*

class TestEquiposTentativos {

	Partido partido
	List<String> nombres10
	List<Jugador> jugadoresEstandar10
	Admin admin

	@Before
	def void setup() {
		nombres10 = newArrayList("Raul", "Pinocho", "Gabriel", "Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar",
			"Facundo", "Gonzalo")
		jugadoresEstandar10 = Lists.newArrayList(nombres10.map[nombre|new Jugador(nombre, new Estandar, 42)])
		admin = new Admin("sonOfA***@fuckOff.ass")
		admin.administrasA(partido)
		
		partido = new Partido("3/3/3", "alun lugar", "cuando pinte", admin)
		partido.inscriptos = jugadoresEstandar10

	}

	@Test
	def testSeSolicitaLaCreacionDeLosEquiposTentativosConCreadorAlgoritmo1() {

		var creadorAlgoritmo1 = new CreadorAlgoritmo1
		admin.solicitarCreacionDeEquiposTentativos(creadorAlgoritmo1)

		assertEquals(5, admin.equipoTentativo1.size)
		assertEquals(partido.inscriptos.get(0), admin.equipoTentativo1.get(0))		
		assertEquals(partido.inscriptos.get(1), admin.equipoTentativo2.get(0))
		//TODO: jugadoresEsperadosEnElEquipo1
	}
	
	@Test 
	def testSeConfirmaLaCreacionDeLosEquiposTentativosConCreadorAlgoritmo1PartidoLosConoce()	{
		
		var creadorAlgoritmo1 = new CreadorAlgoritmo1
		admin.solicitarCreacionDeEquiposTentativos(creadorAlgoritmo1)
		admin.confirmarCreacionDeEquiposTentativos
		
		assertEquals(creadorAlgoritmo1.equipo1, partido.equipo1)
		assertEquals(creadorAlgoritmo1.equipo2, partido.equipo2)
		
		assertEquals(partido.inscriptos.get(0), creadorAlgoritmo1.equipo1.get(0))		
		assertEquals(partido.inscriptos.get(1), creadorAlgoritmo1.equipo2.get(0))
		
	
		
		
	}

	
	@Test
	def testSeSolicitaLaCracionDeLosEquiposTentativosConCreadorAlgoritmo2(){
		var creadorAlgoritmo2= new CreadorAlgoritmo2
		admin.solicitarCreacionDeEquiposTentativos(creadorAlgoritmo2)
		
		assertEquals(5, creadorAlgoritmo2.equipo1.size)		
		
		assertEquals(partido.inscriptos.get(0), creadorAlgoritmo2.equipo2.get(0))		
		assertEquals(partido.inscriptos.get(1), creadorAlgoritmo2.equipo1.get(0))
	}
	
	
	


}

