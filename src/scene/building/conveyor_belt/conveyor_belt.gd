extends StaticBody3D
@export var speed : float = 1

var objects : Array
var ActiveBuildableObject : bool


func _ready():
	self.set_constant_linear_velocity(Vector3(speed,0,0))
	#$Area3D.connect("area_entered",Callable(self,"_on_area_3d_area_entered"))
	#$Area3D.connect("area_exited",Callable(self,"_on_area_3d_area_exited"))
	#constant_linear_velocity.x = speed

func _process(delta):
	#print(rotation_degrees)
	#global_position.x -= speed * delta
	pass
