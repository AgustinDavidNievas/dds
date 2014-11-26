package organizador.partidos.jugador.Infracciones

import java.io.Serializable
import java.util.Date
import javax.persistence.Entity
import javax.persistence.ManyToOne
import organizador.partidos.jugador.Jugador
import javax.persistence.Column
import javax.persistence.JoinColumn

@Entity
class InfraccionSeDaDeBajaSinRemplazante extends Infraccion implements Serializable {
	
	@Column(name="numeroDeInfraccion")
	@Property int numeroDeInfraccion
	
	@Column(name="fecha")
	@Property Date fecha
	
	@Column(name="descripcion")
	@Property String descripcion

	@ManyToOne
	@JoinColumn(name="jugador")
	@Property Jugador jugador

	override penalizarA(Jugador jugador) {
		val infraccion = new InfraccionSeDaDeBajaSinRemplazante
		this.fecha = new Date
		jugador.bajaTuPeso(10)
		jugador.agregarInfraccion(infraccion)
	}

	override horaInfraccion() {
		this.fecha.hours
	}

	override fechaInfraccion() {
		(this.fecha.date).toString + (this.fecha.month).toString + (this.fecha.year).toString
	}

	override penalizarConDescripcion(String descripcion, Jugador jugador) {
		this.descripcion = descripcion
		this.penalizarA(jugador)
	}

}
