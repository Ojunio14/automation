extends Node3D

@onready var marker_3d: Marker3D = $"../Marker3D"


var points:Array
var lines:Array

var mouse_line: MeshInstance3D

var RAY_LENGTH = 1000

func _ready() -> void:
	call_deferred("_init_mouse_line")
	

	
func _process(_delta: float) -> void:
	_update_mouse_line(marker_3d.global_position)

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("Mouse_Left"):
		##_draw_point_and_line()
		#pass
	#
	#if event.is_action_pressed("Mouse_Right"):
		#_clear_points_and_lines()

#Returns the position in 3d that the mouse is hovering, or null if it isnt hovering anything
func get_mouse_pos():
	var space_state = get_parent().get_world_3d().get_direct_space_state()
	var mouse_position = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 1000
		
	var params = PhysicsRayQueryParameters3D.new()
	#params.from = ray_origin
	#params.to = ray_end
	#params.collision_mask = 1
	#params.exclude = []
	
	var rayDic = space_state.intersect_ray(params)
	print(rayDic)
	if rayDic.has("position"):
		return rayDic["position"]
	return null

func _init_mouse_line():
	mouse_line = line(Vector3.ZERO, Vector3.ZERO, Color.BLACK)
	
func _update_mouse_line(pos):
	var mouse_pos = raycast()

	var mouse_line_immediate_mesh = mouse_line.mesh as ImmediateMesh
	if mouse_pos != null:
		var mouse_pos_V3:Vector3 = mouse_pos["position"]
		mouse_line_immediate_mesh.clear_surfaces()
		mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mouse_line_immediate_mesh.surface_add_vertex(pos)
		mouse_line_immediate_mesh.surface_add_vertex(mouse_pos_V3)
		
		mouse_line_immediate_mesh.surface_end()

#func _draw_point_and_line()->void:
	#var mouse_pos = get_mouse_pos()
	#if mouse_pos != null:
		#var mouse_pos_V3:Vector3 = mouse_pos
		#points.append(mouse_pos_V3)
		#
		##If there are at least 2 points...
		#if points.size() > 1:
			##Draw a line from the position of the last point placed to the position of the second to last point placed
			#var point1 = points[points.size()-1]
			#var point2 = points[points.size()-2]
			#var line = _line(point1.position, point2.position)
			#lines.append(line)


func raycast():
	var space_state = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	#query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	return result

func line(pos1: Vector3, pos2: Vector3, color = Color.WHITE_SMOKE, persist_ms = 0):
	var ray_cast 
	if raycast() != null:
		ray_cast = raycast()
	else :
		return
	
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(ray_cast["position"])
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	get_tree().get_root().get_node("Main/World").add_child(mesh_instance)
	if persist_ms:
		#await get_tree().create_timer()
		#await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


