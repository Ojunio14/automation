extends Mining

@onready var canvas_layer: CanvasLayer = $CanvasLayer

# para verificar se estao colidindo
var objects : Array
var ActiveBuildableObject : bool
var entrou_na_scene := false

var click_na_building := false
var modificar_area := true
var stop_area_modificada := false


#para saber onde vai ser adicionado na scene tree
var spawn : Dictionary = {"spawn" : [
	{"group" : "Mining"},
	{"type" : "Mining"}]}

func _input(event: InputEvent) -> void:
	if get_parent().name == "Group_Mining":
		if event.is_action_pressed("Left_Mouse_Button"):
			var ray_cast = BuildManeger.raycast()
			if ray_cast["collider"] is Mining:
				pass
		if event.is_action_pressed("Modificar_area"):
			pass
			

func _ready():
	if get_parent().name == "Group_Mining":
		entrou_na_scene = true
	
	$verific_colision_building.connect("area_entered",Callable(self,"_on_area_3d_area_entered"))
	$verific_colision_building.connect("area_exited",Callable(self,"_on_area_3d_area_exited"))

func _process(delta: float) -> void:
	if get_parent().name == "Group_Mining":
		pass

func _on_area_3d_area_entered(area):
	if area.get_parent() is Pefuradora:
		$MeshInstance3D.visible = true
	if ActiveBuildableObject:
		objects.append(area)
		BuildManeger.AbleToBuild = false

func _on_area_3d_area_exited(area):
	if area.get_parent() is Pefuradora:
		$MeshInstance3D.visible = false
	if ActiveBuildableObject:
		objects.remove_at(objects.find(area))
		if objects.size() <= 0:
			BuildManeger.AbleToBuild = true
