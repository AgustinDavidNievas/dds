package organizador.partidos.jugador

import java.util.Date
import java.io.Serializable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity
import javax.persistence.OneToOne
import javax.persistence.Column
import javax.persistence.JoinColumn

@Entity
class Rechazo implements Serializable {

	@Id
	@GeneratedValue
	@Column(name="id")
	@Property Integer id

	@Column(name="descripcion")
	@Property String descripcion

	@Column(name="fecha")
	@Property Date fecha

	@OneToOne
	@JoinColumn(name="postulante")
	@Property Postulante postulante

	new(Postulante unPostulante) {

		postulante = unPostulante
		fecha = new Date

	}

	new() {
		super()
	}

}
