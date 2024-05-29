extends Node3D

var mining_iron : PackedScene = ResourceLoader.load("res://src/scene/building/mining/mining_iron.tscn")
var pefuradora : PackedScene = ResourceLoader.load("res://src/scene/building/mining/pefuradora/perfuradora.tscn")
#var modificar_altura_terrain : PackedScene = ResourceLoader.load("res://src/scene/world/teste_terrain/Modificar_altura_terrain.tscn")

var subBuild := true
var AbleToBuild : bool = true
var CurrentSpawnable : StaticBody3D

var RAY_LENGTH = 1000

func _process(delta):

	if GameManager.CurrentState == GameManager.State.Buildling:
		
		var RayCast = Ray_Cast_Plane()
		
		if RayCast != null:
			#CurrentSpawnable e uma Scene é vai receber a Position do mouse
			#CurrentSpawnable.activeBuildingObject
			#CurrentSpawnable.global_position = Vector3(round(RayCast.x),0.5,round(RayCast.z))#Vector3(vec3.x,0,vec3.z)

			var t : = Vector3(1,1,1)
			var po = RayCast
		
			var e = po.snapped(t)
			CurrentSpawnable.global_position = e
			#CurrentSpawnable.activeBuildingObject = true
			#CurrentSpawnable.translation = Vector3(round(cursorPos.x), cursorPos.y, round(cursorPos.z))
			CurrentSpawnable.ActiveBuildableObject = true
		if subBuild:
			if AbleToBuild:
				if Input.is_action_just_pressed("Left_Mouse_Button"):
				
					var obj := CurrentSpawnable.duplicate()
					#var navMesh = get_tree().get_nodes_in_group("NavMesh")[0]
					#navMesh.add_child(obj)
					#get_tree().root.get_node("Main/World/Object").add_child(obj)
					#get_tree().get_first_node_in_group("Mining_Iron").add_child(obj)
					verific(obj)
					obj.ActiveBuildableObject = false
					#obj.runSpawn()
					#obj.spawned = true
					#obj.SetDisabled(false)
					obj.global_transform = CurrentSpawnable.global_transform
					
					#navMesh.call_deferred("bake_navigation_mesh",true)
					#navMesh.bake_navigation_mesh(true)
					#obj = null
		
			if Input.is_action_just_released("Q"):
				CurrentSpawnable.queue_free()
				CurrentSpawnable = null
				GameManager.CurrentState = GameManager.State.Play
			
			if Input.is_action_just_released("Middle_Mouse_Button"):
				CurrentSpawnable.rotation_degrees += Vector3(0,90,0)
			
		#if GameManager.CurrentState == GameManager.State.Destroying:
			#if is_instance_valid(CurrentSpawnable):
				#CurrentSpawnable.queue_free()
				#CurrentSpawnable = null
			#if Input.is_action_just_released("LeftMouseDown"):
				#var camera = get_viewport().get_camera()
				#var from = camera.project_ray_origin(get_viewport().get_mouse_position())
				#var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000
				#var space_state = get_world_3d().direct_space_state
				#var result = space_state.intersect_ray(from, to, [self])
				#if result.collider.is_in_group("building"):
					#result.collider.runDespawn()
		pass


func Spawn_Mining_Iron():
	SpawnObj(mining_iron)

func Spawn_Pefuradora():
	SpawnObj(pefuradora)

func SpawnObj(obj):
	if CurrentSpawnable != null:
		CurrentSpawnable.queue_free()
	CurrentSpawnable = obj.instantiate()
	#CurrentSpawnable.SetDisabled(true)
	get_tree().root.add_child(CurrentSpawnable)
	GameManager.CurrentState = GameManager.State.Buildling


func verific(obj):
	
	var building = get_tree().get_first_node_in_group("Building")
	var group = obj.spawn["spawn"][0]["group"]
	match group:
		"Mining":
			if obj.spawn["spawn"][1]["type"] == "Mining":
				building.get_node("Group_Mining").add_child(obj)
				
			elif obj.spawn["spawn"][1]["type"] == "Broca_Mineradora":
				var perfuradora = get_tree().get_first_node_in_group("Broca_Mineradora")
				if pefuradora != null:
					perfuradora.add_child(obj)
				
	
	
	
	#
	#match obj:
		#:
		#MinaFerro:
			
		#_:

	
func Ray_Cast_Plane() -> Vector3:

	var camera = get_viewport().get_camera_3d()
	
	#if !camera:
		#return Vector3.ZERO
	var pos_mouse = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(pos_mouse)
	var to = from + camera.project_ray_normal(pos_mouse) * 1000
	var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
	return cursorPos

func raycast():
	var space_state = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	#query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	return result#["position"]

