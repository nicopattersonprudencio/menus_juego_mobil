extends Node

#almacena una escena empaquetada
var opcion_escena: PackedScene = preload("res://escenas/botones.tscn")
#almacena una lista de instancias de la escena botones
var opciones: Array = []
var opcion_actual := 0

var is_opciones_active = false

var posicion_base: Vector2 = Vector2.ZERO

@onready var sonido_cambio := preload("res://sonidos/select_option.wav")
@onready var sonido_eleccion := preload("res://sonidos/eleccion.mp3")
@onready var player_cambio := AudioStreamPlayer.new()
@onready var player_seleccionado := AudioStreamPlayer.new()


func _ready():
	"""Ajusta el volumen de los sonidos"""
	add_child(player_cambio)
	add_child(player_seleccionado)
	player_cambio.volume_db = -6
	player_seleccionado.volume_db = 2

func limpiar_opciones():
	"""Elimina las opciones existentes"""
	for o in opciones:
		o.queue_free()
	opciones.clear()
	is_opciones_active = false
	
func mostrar_opciones(textos: Array[String], posicion: Vector2, separacion: Vector2):
	limpiar_opciones()
	posicion_base = posicion
	opcion_actual = 0
	is_opciones_active = true
	
	for i in range(textos.size()):
		var opcion = opcion_escena.instantiate()
		opcion.global_position = posicion + separacion * i
		opcion.get_node("MarginContainer/Label").text = textos[i]
		get_tree().get_root().add_child(opcion)
		opciones.append(opcion)
