package organizador.Administrador

import java.util.ArrayList
import java.util.List
import organizador.partidos.criterios.Criterios
import organizador.partidos.jugador.Condicion
import organizador.partidos.jugador.Jugador
import organizador.partidos.jugador.Postulante
import organizador.partidos.jugador.Rechazo
import organizador.partidos.partido.Partido
import organizador.partidos.creador.CreadorDeEquipos
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.OneToOne
import java.io.Serializable
import javax.persistence.OneToMany
import javax.persistence.ManyToOne
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.JoinColumn
import javax.persistence.Basic

@Entity
class Admin implements Serializable{
	
	@Id
	@GeneratedValue
	@Column(name = "id")
	@Property Integer id //si le pongo long me tira error en los xtend-gen
	
	@Basic
	@Column(name = "correo")
	@Property String correo
	
	@OneToOne//el mappeo ya esta aclarado en Partido
	@JoinColumn(name="partido")
	@Property Partido partido
	
	@ManyToOne
	@JoinColumn(name="condicion")
	@Property Condicion condicion
	
	@OneToMany
	@JoinColumn(name="rechazados")
	@Property List<Rechazo> rechazados = new ArrayList
	
	@OneToMany
	@JoinColumn(name="pendientes")
	@Property List<Postulante> pendientes = new ArrayList
	
	@OneToMany
	@JoinColumn(name="equipoTentativo1")
	@Property List<Jugador> equipoTentativo1
	
	@OneToMany
	@JoinColumn(name="equipoTentativo2")
	@Property List<Jugador> equipoTentativo2
	
	//*****Para que funcione la UI*****
	@OneToMany
	@JoinColumn(name="inscriptosOrdenados")
	@Property List<Jugador> inscriptosOrdenados
	//*********************************

	new(String unCorreo) {

		this.correo = unCorreo

		this.inicializarListas()
	}

	def inicializarListas() {
		this.rechazados = new ArrayList
		this.pendientes = new ArrayList
	}

	def rechazarSolicitud(Postulante postulante) {
		this.rechazados.add(new Rechazo(postulante))
	}

	def void evaluarPostulante(Postulante postulante) {
		this.pendientes.add(postulante)

	}

	def aceptarSolicitud(Postulante postulante) {
		val jugador = Jugador.crearJugador(postulante)
		jugador.inscribirseA(this.partido)
	}

	def administrasA(Partido partido) {
		this.partido = partido
	}

	def definirHandicap(Jugador jugador, Integer handicap) {
		jugador.handicap = handicap
	}

	def ordenarJugadoresPor(Criterios criterio) {
		this.partido.inscriptos = this.partido.inscriptos
						.sortBy(jugador|criterio.aplicarCriterio(jugador))
						.reverse
		this.inscriptosOrdenados = this.partido.inscriptos
	}

	def solicitarCreacionDeEquiposTentativos(CreadorDeEquipos creador) {

		creador.crearEquiposTentativos(partido.inscriptos)
		equipoTentativo1 = creador.verEquipoTentativo1
		equipoTentativo2 = creador.verEquipoTentativo2
	}

	def confirmarCreacionDeEquiposTentativos() {
		partido.almacenarEquipos(equipoTentativo1, equipoTentativo2)

	}
	
	new(){
		super()
	}

}
