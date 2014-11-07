package organizador.home

import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedHome
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.jugador.Tipo
import java.util.Date

class HomeDeJugadores extends CollectionBasedHome<Jugador> {
	

	def void init() {

		this.create("Gabriel",new Estandar,20,"Gabi")
		this.create("Juan",new Estandar,30,"Roman")
		this.create("Ramon",new Estandar,25,"X")
		this.create("PechinioFrio",new Estandar,35,"Romaldinio")
		this.create("Lucas",new Estandar,15,"Lu")
		this.create("Oscar",new Estandar,40,"Pocho")
		this.create("Facundo",new Estandar,5,"miau")
		this.create("Gonzalo",new Estandar,50,"Gon")
	}

	def create(String pNombre, Tipo tipo, int edad, String apodo) {
		var jugador = new Jugador(pNombre, tipo, edad, apodo)
		this.create(jugador)
		return jugador
	}

	
	override def Predicate<Jugador> getCriterio(Jugador example) {
		null
	}

	override createExample() {
		new Jugador("Adolf", new Estandar, 22)
	}

	override def getEntityType() {
		typeof(Jugador)
	}
	
	def search(String nombre) {
		this.search(nombre, null)//preguntar como hacer con los otros campos
	}
	
	def search(String nombre, String apodo) {
		allInstances.filter[jugador|this.match(nombre, jugador.getNombre) && this.match(apodo, jugador.getApodo)].toList
	}
	
		def match(Object expectedValue, Object realValue) {
		if (expectedValue == null) {
			return true
		}
		if (realValue == null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}
	
	override def searchById(int id) {
		allInstances.findFirst[jugador|jugador.getId.equals(id)]
	}
	
	def search(Date fecha){
		allInstances.filter[jugador|this.match(fecha,jugador.fechaDeNacimiento)]
	}
	
	def search(String nombre, String apodo, Date fecha) {
		allInstances.filter[jugador|this.match(nombre, jugador.getNombre) && this.match(apodo, jugador.getApodo) && this.match(fecha, jugador.fechaDeNacimiento)].toList
	}
	
}