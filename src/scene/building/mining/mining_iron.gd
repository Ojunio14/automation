extends Mining

# para verificar se estao colidindo
var objects : Array
var ActiveBuildableObject : bool

func _ready():
	if get_parent().name == "Group_Mining":
		$criando_ferro.connect("timeout",Callable(self,"timeout"))
	$verific_colision_building.connect("area_entered",Callable(self,"_on_area_3d_area_entered"))
	$verific_colision_building.connect("area_exited",Callable(self,"_on_area_3d_area_exited"))


func _process(delta: float) -> void:
	if get_parent().name == "Group_Mining":
		contagem_timer($criando_ferro)





func timeout() -> void:
	quantity_minerio += 1
	stop_timer = true

func _on_area_3d_area_entered(area):
	if ActiveBuildableObject:
		objects.append(area)
		BuildManeger.AbleToBuild = false

func _on_area_3d_area_exited(area):
	if ActiveBuildableObject:
		objects.remove_at(objects.find(area))
		if objects.size() <= 0:
			BuildManeger.AbleToBuild = true
