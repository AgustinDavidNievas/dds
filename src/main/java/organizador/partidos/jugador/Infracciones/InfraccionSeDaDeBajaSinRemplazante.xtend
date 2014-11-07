package organizador.partidos.jugador.Infracciones

import organizador.partidos.jugador.Jugadorimport java.util.Date

class InfraccionSeDaDeBajaSinRemplazante implements Infraccion {
		@Property int numeroDeInfraccion
		@Property Date fecha
		@Property String descripcion
				
				
	override penalizarA(Jugador jugador){
		val infraccion = new InfraccionSeDaDeBajaSinRemplazante
		this.fecha= new Date
		jugador.bajaTuPeso(10)
		jugador.agregarInfraccion(infraccion)
	}
	
	override horaInfraccion() {
		this.fecha.hours
	}
	
	override fechaInfraccion() {
	(this.fecha.date).toString + (this.fecha.month).toString + 
	(this.fecha.year).toString	
	}
	
	override penalizarConDescripcion(String descripcion, Jugador jugador) {
		this.descripcion= descripcion
		this.penalizarA(jugador)
	}
	
	
}