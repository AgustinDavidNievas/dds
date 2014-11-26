package organizador.partidos.jugador

import java.util.Dateimport java.io.Serializable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity
import javax.persistence.OneToOne

@Entity
class Rechazo implements Serializable {
	
	@Id
	@GeneratedValue
	@Property Integer id

	@Property String descripcion
	@Property Date fecha
	
	@OneToOne
	@Property Postulante postulante

	new(Postulante unPostulante) {
		
		postulante = unPostulante
		fecha = new Date
		
	}
	
	new(){
		super()
	}

}
