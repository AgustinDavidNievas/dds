package organizador.partidos.correo

import org.junit.Test
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.observer.NuevoInscriptoObserver
import organizador.partidos.observer.PartidoConfirmadoObserver
import organizador.partidos.partido.Partido
import organizador.partidos.stub.EnviadorDeMailsStub

import static org.junit.Assert.*
import com.google.common.collect.Lists
import organizador.Administrador.Admin

class TestCorreo {

	@Test
	def testEnviarMailLoReciben() {
		val mail = new Mail("hola", "HOLA")
		val sender = new EnviadorDeMailsStub
		
		sender.enviarMail(mail, "correoDeJuan")
		
		assertEquals(1, sender.cantidadDeMailsEnviados)
	}

	@Test
	def testEnviarMailAAdminDePartidoAseguradoSeMandaMail() {


		val admin = new Admin("OHMAIGOD@tuvieja")
		val partido = new Partido("12/12/12", "a la vuelta", "las 1200", admin)
		val partidoConfirmadoObserver = new PartidoConfirmadoObserver
		val sender = new EnviadorDeMailsStub
	
		
		partidoConfirmadoObserver.aniadirEnviadorDeMails(sender)
		partido.agregarPartidoConfirmadoObserver(partidoConfirmadoObserver)

		val nombres = newArrayList("Gabriel", "Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo",
					"Gonzalo","Roman")
		
		val jugadores = Lists.newArrayList( nombres.map[ nombre | new Jugador(nombre, new Estandar, 10)] ) 
		partido.inscriptos = jugadores

		val jugadorUltimo = new Jugador("Palermo", new Estandar, 13)
		partido.inscribir(jugadorUltimo)
		//Aca directamente manda todos los mails
		assertEquals(1, sender.cantidadDeMailsEnviados)

	}

	@Test
	def testSeAgregaUnNuevoJugadorJugadoresRecibenMail() {

		val partido = new Partido
		val nuevoInscriptoObserver = new NuevoInscriptoObserver
		val sender = new EnviadorDeMailsStub	
		
		nuevoInscriptoObserver.aniadirEnviadorDeMails(sender)
		partido.agregarNuevoInscriptoObserver(nuevoInscriptoObserver)

		val jugador1 = new Jugador("pelé", new Estandar, 12 )
		val jugador2 = new Jugador("jorge", new Estandar, 14)
		val jugador3 = new Jugador("Kito Pizzas",new Estandar, 14)
		val jugadorNuevo = new Jugador("JugadorNuevo", new Estandar, 16)

		jugador1.setCorreo("jugador1@asd") 
		jugador2.setCorreo("jugador2@asd")
		jugador3.setCorreo("jugador3@asd")
		jugadorNuevo.setCorreo("soyNuevo@asd")
		

		partido.inscriptos.add(jugador1)
		partido.inscriptos.add(jugador2)
		partido.inscriptos.add(jugador3)
            
		jugadorNuevo.inscribirseA(partido)
		
		assertEquals(3, sender.cantidadDeMailsEnviados)

		
	}
	

}



