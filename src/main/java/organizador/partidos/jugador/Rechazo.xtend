package organizador.partidos.jugador

import java.util.Date

class Rechazo {

	@Property String descripcion
	@Property Date fecha
	@Property Postulante postulante

	new(Postulante unPostulante) {
		
		postulante = unPostulante
		fecha = new Date
		
	}

}
