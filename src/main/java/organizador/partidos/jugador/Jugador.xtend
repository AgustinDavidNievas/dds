package organizador.partidos.jugador

import java.io.Serializable
import java.util.ArrayList
import java.util.Date
import java.util.List
import javax.persistence.Basic
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.uqbar.commons.utils.Observable
import organizador.partidos.criterios.CriterioPromedioNCalificaciones
import organizador.partidos.criterios.UltimasCalificaciones
import organizador.partidos.jugador.Infracciones.Infraccion
import organizador.partidos.jugador.Infracciones.InfraccionSeDaDeBajaSinRemplazante
import organizador.partidos.partido.Partido
import javax.persistence.Temporal
import javax.persistence.TemporalType

@Entity
@Observable
class Jugador extends org.uqbar.commons.model.Entity implements Serializable{
	
	/*Every non static non transient property (field or method depending on the access type) of an entity is considered persistent, 
	 * unless you annotate it as @Transient. 
	 * Not having an annotation for your property is equivalent to the appropriate @Basic annotation. 
	 * The @Basic annotation allows you to declare the fetching strategy for a property
	 * counter, a transient field, and lengthInMeter, a method annotated as @Transient, and will be ignored by the entity manager. 
	 * name, length, and firstname properties are mapped persistent and eagerly fetched (the default for simple properties). 
	 * The detailedComment property value will be lazily fetched from the database once a lazy property of the entity is accessed for the first time. 
	 * Usually you don't need to lazy simple properties (not to be confused with lazy association fetching).
	 */
	
	@Id
	@GeneratedValue
	@Property Integer id //si le pongo long me tira error en los xtend-gen
	
	@Basic
	@Column(name = "NOMBRE")
	@Property String nombre
	
	@Basic
	@Column(name = "CORREO")
	@Property String correo
	
	@OneToOne
	Tipo tipo
	
	@Basic
	@Column(name = "PESO")
	@Property int peso
	
	@Basic
	@Column(name = "EDAD")
	@Property int edad
	
	@ManyToOne
    @Property Condicion condicion
	
	@OneToMany
	@Property List<Jugador> amigos = new ArrayList
	
	@ElementCollection
	@Property List<Integer> listaDeCalificaciones
	
	@Basic
	@Column(name = "HANDICAP")
	@Property Integer handicap	
	
	
	@ElementCollection
	@Property List<Integer> calificacionesDelUltimoPartido
	
	@Basic
	@Column(name = "APODO")
	@Property String apodo
	
	@Temporal(TemporalType.TIME)
	@Property Date fechaDeNacimiento = new Date(1,1,1)
	
	@Basic
	@Column(name = "PARTIDOSJUGADOS")
	@Property int partidosJugados = 1
	
	@Basic
	@Column(name = "PROMEDIODEULTIMOPARTIDO")
	@Property int promedioDeUltimoPartido = 0
	
	@Basic
	@Column(name = "PROMEDIODETODOSLOSPARTIDOS")
	@Property int promedioDeTodosLosPartidos = 0
	
	@OneToMany(targetEntity=InfraccionSeDaDeBajaSinRemplazante)
	@Property List<Infraccion> infracciones //rompe porque es una Interfaz, preguntar a Lucas
	
	@ManyToOne
	@Property Partido partido
	
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
	
	
	//@OneToOne
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
	
	def agregarInfraccion(InfraccionSeDaDeBajaSinRemplazante infraccion){
							//Aca iba Infraccion
		this.infracciones.add(infraccion)
	}
}
