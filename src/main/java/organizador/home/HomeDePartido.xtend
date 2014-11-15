package organizador.home

import org.uqbar.commons.model.CollectionBasedHome
import organizador.partidos.partido.Partido
import org.apache.commons.collections15.Predicate

class HomeDePartido extends CollectionBasedHome<Partido> {
	
	
	
	override def searchById(int id) {
		allInstances.findFirst[partido|partido.getId.equals(id)]
	}
	
	override protected Predicate<Partido> getCriterio(Partido example) {
		null
	}
	
	override createExample() {
		new Partido
	}
	
	override getEntityType() {
		
		typeof(Partido)
	
	}
	
}