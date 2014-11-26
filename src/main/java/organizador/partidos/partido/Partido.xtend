package organizador.partidos.partido

import java.io.Serializable
import java.util.ArrayList
import java.util.Date
import java.util.List
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.uqbar.commons.utils.Observable
import organizador.Administrador.Admin
import organizador.partidos.correo.EnviadorDeMails
import organizador.partidos.correo.Mail
import organizador.partidos.jugador.Infracciones.Infraccion
import organizador.partidos.jugador.Jugador
import organizador.partidos.jugador.Postulante
import organizador.partidos.observer.NuevoInscriptoObserver
import organizador.partidos.observer.PartidoConfirmadoObserver
import javax.persistence.CascadeType
import organizador.partidos.jugador.Infracciones.InfraccionSeDaDeBajaSinRemplazante
import javax.persistence.Column
import javax.persistence.JoinColumn

@Entity
@Observable
class Partido extends org.uqbar.commons.model.Entity implements Serializable{
	
	@Id
	@GeneratedValue
	@Column(name = "id")
	@Property Integer id
	
	var String fecha //'20/05/14'
	var String lugar
	var String horario //'07:00pm'
	
	@OneToOne(targetEntity=InfraccionSeDaDeBajaSinRemplazante)
	@JoinColumn(name="infraccion")
	@Property Infraccion infraccion
	
	@OneToMany(cascade=CascadeType.ALL, orphanRemoval=true/*, mappedBy="partido"*/)
	@JoinColumn(name="inscriptos")//googleando lei que no se puede usar un mappedBy con un @JoinColumn
	@Property List<Jugador> inscriptos = new ArrayList
	
	@Column(name = "turno")
	String turno //"M" "T" "N"
	
	@Column(name = "fechaDelPartido")
	@Property Date fechaDelPartido //preguntar como se usa esta clase
	
	@OneToMany
	@JoinColumn(name="partidoConfirmadoObserver")
	@Property List<PartidoConfirmadoObserver> partidoConfirmadoObserver
	
	@OneToMany
	@JoinColumn(name="nuevoInscriptoObserver")
	@Property List<NuevoInscriptoObserver> nuevoInscriptoObserver
	
	@OneToOne(cascade=CascadeType.ALL, orphanRemoval=true/*,  mappedBy="partido"*/)
	@JoinColumn(name="administrador")//googleando lei que no se puede usar un mappedBy con un @JoinColumn
	@Property Admin administrador

	//@Property String correoDelAdmin
	@OneToOne
	@JoinColumn(name="mailAvisoAdmin")
	@Property Mail mailAvisoAlAdmin
	
	@OneToOne
	@JoinColumn(name="mailAvisoJugadores")
	@Property Mail mailAvisoJugadores
	
	@OneToOne
	@JoinColumn(name="enviadorDeMails")
	@Property EnviadorDeMails enviadorDeMails
	
	@OneToMany(cascade=CascadeType.ALL, orphanRemoval=true/*, mappedBy="partido"*/)
	@JoinColumn(name="equipo1")//googleando lei que no se puede usar un mappedBy con un @JoinColumn
	@Property List<Jugador> equipo1
	
	@OneToMany(cascade=CascadeType.ALL, orphanRemoval=true/*, mappedBy="partido"*/)
	@JoinColumn(name="equipo1")//googleando lei que no se puede usar un mappedBy con un @JoinColumn
	@Property List<Jugador> equipo2

	/*Inicializacion */
		new() {
		super()
		this.inicializarInscriptos
		this.inicializarObservers
	}

	new(String unaFecha, String unLugar, String unHorario, Admin unAdmin) {

		fecha = unaFecha
		lugar = unLugar
		horario = unHorario
		administrador = unAdmin
		this.vincularConAdmin(this.administrador)
		this.inicializarInscriptos
		this.fechaDelPartido = new Date //crea una fecha con la fecha de hoy
		this.inicializarObservers
	}

	def void inicializarObservers() {
		this.nuevoInscriptoObserver = new ArrayList
		this.partidoConfirmadoObserver = new ArrayList
	}

	def void vincularConAdmin(Admin admin) {

		admin.administrasA(this)

	}

	def void inicializarInscriptos() {
		inscriptos = newArrayList
	}

	/*Getters y Setters */
	def getFecha() {
		this.fecha
	}

	def getLugar() {
		this.lugar
	}

	def getHorario() {
		this.horario
	}

	def setTurno(String turno) {

		this.turno = turno
	}

	def getTurno() {

		this.turno
	}

	/*FIN de Getters y Setters */
	def void inscribir(Jugador unJugador) {
		unJugador.tipo.inscribirseA(this)
		nuevoInscriptoObserver.forEach[observer|observer.notificarALosJugadoresQueSeInscribioAlguien(this, unJugador)]
		this.verificarSiEstasConfirmado

	}

	def notificaJugadores(Jugador jugador) {
		nuevoInscriptoObserver.forEach[observer|observer.notificarALosJugadoresQueSeInscribioAlguien(this, jugador)]
	}

	def agregar(Jugador unJugador) {
		this.inscriptos.add(unJugador)
	}

	def todosSonEstandar() {
		cantidadInscriptosEstandar() == cantidadInscriptos()
	}

	def cantidadInscriptos() {
		this.inscriptos.size
	}

	def cantidadInscriptosEstandar() {
		this.inscriptos.filter[jugador|jugador.sosEstandar()].size
	}

	def plazaLlena() {
		this.inscriptos.size == 10
	}

	def plazaLlenaAsegurada() {
		((this.todosSonEstandar) && (this.plazaLlena))
	}

	def plazaLlenaNoAsegurada() {
		this.plazaLlena && (!(this.todosSonEstandar))
	}

	def listaDeCondicionales() {
		(this.inscriptos.filter[jugador|jugador.sosCondicional()]).toList
	}

	def listaDeSolidarios() {
		this.inscriptos.filter[jugador|jugador.sosSolidario].toList
	}

	def quitaUno() {
		if (this.listaDeCondicionales.size != 0) {
			this.inscriptos.remove(listaDeCondicionales.get(0))

		} else {
			this.inscriptos.remove(listaDeSolidarios.get(0))

		}

	}

	def removerJugadoresSolidariosOCondicionales() {

				val jugadorExpulsado = (this.inscriptos.findFirst [ jugador |
			jugador.sosSolidario()
				])
		this.inscriptos = (this.inscriptos.filter[jugador|jugador != jugadorExpulsado]).toList

	}

	def verificarSiEstasConfirmado() {
		this.partidoConfirmadoObserver.forEach[observer|observer.estoyConfirmado(this)]
	}

	def darDeBajaA(Jugador jugador) {
		this.inscriptos.remove(jugador)
		penalizar(jugador)
		this.notificarPlazaNoAsegurada(jugador)

	}

	def notificarPlazaNoAsegurada(Jugador jugador) {
		if (!this.plazaLlenaAsegurada) {
			this.enviarMailDeAvisoAlAdmin(this.administrador.getCorreo, jugador)
		}
	}

	def enviarMailDeAvisoAlAdmin(String correo, Jugador jugador) {
		this.crearMailDeAvisoAlAdmin(jugador)
		this.enviadorDeMails.enviarMail(mailAvisoAlAdmin, correo)

	}

	def crearMailDeAvisoAlAdmin(Jugador jugador) {
		this.mailAvisoAlAdmin = new Mail("Un partido dejo de estar confirmado",
			("El partido ya no tiene al jugador" + jugador.nombre))
	}

	def penalizar(Jugador jugador) {
		this.infraccion.penalizarA(jugador)

	}

	def reemplazarAJugadorCon(Jugador jugador) {
		this.inscriptos.remove(jugador)
		this.inscribir(jugador)
	}

	def fechaDelPartido(String fecha) {
		this.fecha = fecha
	}

	
	/*def listaDeCorreoDeJugadores() {
		this.inscriptos.forEach[jugador|jugador.correo]
	}*/

	def agregarNuevoInscriptoObserver(NuevoInscriptoObserver nuevoObserver) {
		this.nuevoInscriptoObserver.add(nuevoObserver)
	}

	def agregarPartidoConfirmadoObserver(PartidoConfirmadoObserver nuevoObserver) {
		this.partidoConfirmadoObserver.add(nuevoObserver)
	}

	def evaluarPostulante(Postulante amigo) {
		administrador.evaluarPostulante(amigo)
	}

	def almacenarEquipos(List<Jugador> equipo1, List<Jugador> equipo2) {

		this.equipo1 = equipo1
		this.equipo2 = equipo2

	}

}
