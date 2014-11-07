package organizador.partidos.criterios

import organizador.partidos.jugador.Jugador
import java.util.List

class Mix extends Criterios{
	
	@Property List<Criterios> criterios
	
	override aplicarCriterio(Jugador jugador) {
		
		var lista = criterios.map(criterio|criterio.aplicarCriterio(jugador)).toList
		var suma = lista.fold(0)[a, b|a + b]
		return suma/lista.size
		
	}
	
	
}