package organizador.partidos.jugador.Infracciones

import organizador.partidos.jugador.Jugador

interface Infraccion {
	
 	def void penalizarA(Jugador jugador)

	def void horaInfraccion()
	
	def String fechaInfraccion()
	
	def void penalizarConDescripcion(String descripcion, Jugador jugador)
	

		
}