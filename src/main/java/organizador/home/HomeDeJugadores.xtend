package organizador.home

import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedHome
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Jugador
import organizador.partidos.jugador.Tipo
import java.util.Date
import java.util.List
import static organizador.persistencia.SessionManager.*
import static org.hibernate.criterion.Restrictions.*

class HomeDeJugadores extends CollectionBasedHome<Jugador> {
	

	def void init() {
		
		val listaDeCalificacionesDeHugo = newArrayList
		listaDeCalificacionesDeHugo.add(9)
		this.create("Hugo", new Estandar, 40, "koku",8,listaDeCalificacionesDeHugo)
		
		val listaDeCalificacionesDeGaby = newArrayList
		listaDeCalificacionesDeGaby.add(10)
		listaDeCalificacionesDeGaby.add(5)
		this.create("Gaby", new Estandar, 30, "Ga",6,listaDeCalificacionesDeGaby)
		
		val listaDeCalificacionesDeRo = newArrayList
		listaDeCalificacionesDeRo.add(3)
		listaDeCalificacionesDeRo.add(7)
		this.create("Rodry", new Estandar, 20, "Ro",7,listaDeCalificacionesDeRo)
		
		val listaDeCalificacionesDeIvan = newArrayList
		listaDeCalificacionesDeIvan.add(1)
		this.create("Ivan", new Estandar, 22, "Ivu",2,listaDeCalificacionesDeIvan)
		
		val listaDeCalificacionesDeQui = newArrayList
		listaDeCalificacionesDeQui.add(5)
		this.create("Quique", new Estandar, 27, "Qui",1,listaDeCalificacionesDeQui)
		
		val listaDeCalificacionesDeDani = newArrayList
		listaDeCalificacionesDeDani.add(7)
		this.create("Daniel", new Estandar, 31, "Dani",6,listaDeCalificacionesDeDani)
		
		val listaDeCalificacionesDePo = newArrayList
		listaDeCalificacionesDePo.add(2)
		this.create("Po", new Estandar, 2, "P",3,listaDeCalificacionesDePo)
		
		val listaDeCalificacionesDeIru = newArrayList
		listaDeCalificacionesDeIru.add(10)
		this.create("Iroito", new Estandar, 100, "Iru", 10,listaDeCalificacionesDeIru)
		
		val listaDeCalificacionesDeCu = newArrayList
		listaDeCalificacionesDeCu.add(10)
		this.create("Cuirassier", new Estandar, 28, "Cu",9,listaDeCalificacionesDeCu)
		
		val listaDeCalificacionesDeCarla = newArrayList
		listaDeCalificacionesDeCarla.add(7)
		this.create("Carla", new Estandar, 14, "La Carla",3,listaDeCalificacionesDeCarla)
	}

	def create(String pNombre, Tipo tipo, int edad, String apodo, Integer handicap, List<Integer> calificaciones) {
		var jugador = new Jugador(pNombre, tipo, edad, apodo, handicap, calificaciones)
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
	
/*def List<Jugador> filtrar(String nombre, String apellido, Integer peso, Integer edad, Integer handicap) {
		val query = session.createCriteria(Jugador)

		if (nombre != null) {
			query.add(like("nombre", "%" + nombre + "%"))
		}
		if (apellido != null) {
			query.add(like("apellido", "%" + apellido + "%"))
		}
		if (edad != null) {
			query.add(eq("edad", edad))
		}
		
		
		query.list()
	}*/
	
}