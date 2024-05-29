extends CharacterBody3D
class_name NpcMining


# variaveis basica do npc
@export var movement_speed: float = 4.0
#@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var navigation_agent : NavigationAgent3D

var current_level_trasnporte : int

enum State_NPC {
	SEARCH_TARGET,
	WALK,
	FINISHED,
	Set_TARGET,
	CARGA_DESCARGA
}

var current_State_Npc : int = State_NPC.SEARCH_TARGET

var dados

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)


func iniciar_navigation_agent(_navigation_agent : NavigationAgent3D):
	navigation_agent = _navigation_agent







func movimentation_npc(navigation_agent : NavigationAgent3D):
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	
	var front = global_position - new_velocity
	front.y = global_transform.origin.y
	#print(player.distance_to(pos))
	if front != global_transform.origin:
		look_at(front,Vector3.UP)
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()

