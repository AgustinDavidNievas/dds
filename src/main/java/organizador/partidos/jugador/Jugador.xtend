package organizador.partidos.jugador

import java.util.ArrayList
import java.util.List
import organizador.partidos.partido.Partido
import org.uqbar.commons.model.Entity
import java.util.Date
import organizador.partidos.criterios.UltimasCalificaciones
import organizador.partidos.criterios.CriterioPromedioNCalificaciones
import organizador.partidos.jugador.Infracciones.Infraccion
import java.io.Serializable
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.uqbar.commons.utils.Observable
import javax.persistence.OneToOne

@Observable
class Jugador extends Entity implements Serializable{
	
	@Id
	@GeneratedValue
	@Property Integer id //si le pongo long me tira error en los xtend-gen

	@Property String nombre
	@Property String correo
	Tipo tipo
	@Property int peso
	@Property int edad
	@Property Condicion condicion
	@Property List<Jugador> amigos = new ArrayList
	@Property List<Integer> listaDeCalificaciones
	@Property Integer handicap	
	@Property List<Integer> calificacionesDelUltimoPartido
	@Property String apodo
	@Property Date fechaDeNacimiento = new Date(1,1,1)
	@Property int partidosJugados = 1
	@Property int promedioDeUltimoPartido = 0
	@Property int promedioDeTodosLosPartidos = 0
	@Property List<Infraccion> infracciones
	
	new(){
		//lo necesita hibernate
		super()
	}

	new(String nombre, Tipo tipo, int edad) {
		this.nombre = nombre
		this.peso = 100 //todos los jugadores empiezan con 100 de peso aunque se les puede setear otro valor
		this.tipo = tipo
		this.edad = edad
		this.tipo.setJugador(this)
		this.inicializarAmigos
		this.inicializarListaDeCalificaciones
		this.apodo = "No hay apodo asignado"
		this.infracciones = newArrayList
			}
	
	/*Para que no rompan los test se deja el new de arriba, este se necesita para la entrega de UI ya que agregaron propiedades que antes no tenia */
	new(String nombre, Tipo tipo, int edad, String unApodo) {
		this.nombre = nombre
		this.peso = 100 //todos los jugadores empiezan con 100 de peso aunque se les puede setear otro valor
		this.tipo = tipo
		this.edad = edad
		this.tipo.setJugador(this)
		this.inicializarAmigos
		this.inicializarListaDeCalificaciones
		this.apodo = unApodo
		this.infracciones = newArrayList
	}
	/***********************************************************************************************************************************************/
	
	new(String nombre, Tipo tipo, int edad, String apodo, Integer handicap, List<Integer> listaDeCalificaciones){
		//este new esta para simplificar la carga de datos del home
		this.nombre = nombre
		this.peso = 100
		this.tipo = tipo
		this.edad = edad
		this.tipo.setJugador(this)
		this.inicializarAmigos
		this.inicializarListaDeCalificaciones
		this.apodo = apodo
		this.infracciones = newArrayList
		this.handicap = handicap
		this.listaDeCalificaciones = listaDeCalificaciones
	}
	
	def asignarApodo(String apodo){
		
		this.apodo = apodo
	}

	def void inicializarAmigos() {
		amigos = newArrayList
	}


	def void inicializarListaDeCalificaciones() {
				this.listaDeCalificaciones = newArrayList
		this.calificacionesDelUltimoPartido = newArrayList
	}
	
	@OneToOne
	def getTipo() {
		this.tipo
	}

	/*def getCorreo() {
		
		this.correo
	}*/
	def setTipo(Tipo tipo) {
		this.tipo = tipo
		tipo.setJugador(this)
	}

	def getPrioridad() {
		this.tipo.dameTuPrioridad()
	}

	/*def getNombre() {
		this.nombre
	}*/

	def agregarAmigo(Jugador jugador) {
		this.amigos.add(jugador)
	}

	def void inscribirseA(Partido partido) {
		partido.notificaJugadores(this)
		this.tipo.inscribirseA(partido)
	}

	def boolean sosEstandar() {
		this.getPrioridad() == 1
	}

	def boolean sosCondicional() {
		this.getPrioridad() == 3
	}

	def boolean sosSolidario() {
		this.getPrioridad() == 2
	}

	def darseDeBajaSinReemplazo(Partido partido) {
		partido.darDeBajaA(this)
	}

	def darseDeBajaConReemplazo(Partido partido, Jugador reemplazo) {
		partido.darDeBajaA(this)
		partido.reemplazarAJugadorCon(reemplazo)
	}

	def cambiaTuPeso(int i) {
		this.peso = i
	}

	def bajaTuPeso(int cantidad) {
		this.peso = (this.peso - cantidad)
	}

	def postularAmigo(Postulante amigo, Partido partido) {
		partido.evaluarPostulante(amigo) //ya no rompe encapsulamiento

	}
	
	def aniadirNotaAListaDeCalificaciones(Integer nota) {
		this.listaDeCalificaciones.add(nota)
	}
	
	

	/**************************************Metodo de creacion de jugadores*************************************/
	def static crearJugador(Postulante postulante) {
		new Jugador(postulante.getNombre, postulante.getTipo, postulante.edad)
	}
	/**********************************************************************************************************/
	
	def void calificarA(Jugador jugador, Integer nota, String critica){
		jugador.aniadirNotaAListaDeCalificaciones = nota
		jugador.aniadirNotaAListaDeCalificacionesUltimoPartido = nota
	}
	
	def setAniadirNotaAListaDeCalificacionesUltimoPartido(Integer nota) {
		this.calificacionesDelUltimoPartido.add(nota)
		this.promedioDeTodosLosPartidos()
		this.promedioDelUltimoPartido()
		
	}
	
	def tuHandicapEs(Integer numero){
		this.handicap = numero
	}
	
	def promedioDelUltimoPartido(){
		this.promedioDeUltimoPartido = (new UltimasCalificaciones).aplicarCriterio(this)
		
	}
	
	def promedioDeTodosLosPartidos(){
		this.promedioDeTodosLosPartidos= (new CriterioPromedioNCalificaciones(this.partidosJugados))
			.aplicarCriterio(this)
		
	}
	
	def agregarInfraccion(Infraccion infraccion){
		
		this.infracciones.add(infraccion)
	}
}
