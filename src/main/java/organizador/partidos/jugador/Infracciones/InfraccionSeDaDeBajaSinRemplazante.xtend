package organizador.partidos.jugador.Infracciones

import java.util.Date
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.jugador.Jugador
import javax.persistence.ManyToOne
import javax.persistence.Entity

@Entity
class InfraccionSeDaDeBajaSinRemplazante implements Infraccion {
		@Id
		@GeneratedValue
		@Property Integer id
		
		@Property int numeroDeInfraccion
		@Property Date fecha
		@Property String descripcion
		
		@ManyToOne
		@Property Jugador jugador		
				
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