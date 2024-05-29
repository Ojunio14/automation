extends Node3D

@export var collision_array  : Array[Vector3] 

@onready var mining_iron: StaticBody3D = $".."

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("Left_Mouse_Button"):
		#var ray = BuildManeger.raycast()
		#if event.is_pressed():
			#print(ray)
		#if ray["collider"].name == "pilar_1":
			##$pilar_1.global_transform.origin = ray
			#pass
	#
var move := false

var ray

var num_child

func _ready() -> void:
	var shape_ = $"../NavigationRegion3D/StaticBody3D/Collision_".shape.get_points()
	novos_valores.append_array(shape_)
	
var atual
var ar = []
var selecionado = null
var index 

var novos_valores : PackedVector3Array = PackedVector3Array()

func _physics_process(delta: float) -> void:
	#print(BuildManeger.raycast())
	if Input.is_action_just_pressed("Left_Mouse_Button") and mining_iron.modificar_area:
		ray = BuildManeger.raycast()
		
		if ray != null:
			
			var ch =  get_children()
			if num_child == get_child_count():
				pass
			else:
				if num_child != get_child_count():
					ar.clear()
					num_child = get_child_count()
					for c in ch:
						ar.append(c.get_rid())
			
			#print(ray,"----------------------------------")
			
			if ar.has(ray["rid"]):
				
				#print("deu certo",ray["rid"],"?????????????????")
				
				var tes = get_children()
				index = ar.find(ray["rid"])
				
				selecionado = tes[ar.find(ray["rid"])]
				move = true
	
	#if Input.is_action_pressed("Left_Mouse_Button") and move:
				#if Input.is_action_just_pressed("Q"):
					#move = false
					#return
				#print("oks")
				#$pilar_1.global_transform.origin = BuildManeger.Ray_Cast_Plane()

	if Input.is_action_pressed("Left_Mouse_Button") and move:
				
				var ray_cast_plane = BuildManeger.Ray_Cast_Plane()
				var t : = Vector3(1,1,1)
				var po = ray_cast_plane
				
				var e = po.snapped(t)
				selecionado.global_position = e
				#selecionado.global_position = ray_cast_plane # ray_cast_plane
				#selecionado.global_position.x = clamp(selecionado.global_position.x,-20,20)
				#selecionado.global_position.z = clamp(selecionado.global_position.z,-20,20)
				 
	elif Input.is_action_just_released("Left_Mouse_Button"):
		#if Input.is_action_just_pressed("Q"):
			
			var shape = $"../NavigationRegion3D/StaticBody3D/Collision_".shape.get_points()
			
			if index != null:
				var vec : Vector3 = selecionado.position
				var sha = $"../NavigationRegion3D/StaticBody3D/Collision_"
				#shape[index] = Vector3(vec.x,1,vec.z)
				#novos_valores.append_array()

				match  index:
					0:
						novos_valores[0] = Vector3(round(vec.x),1,round(vec.z))
						novos_valores[1] = Vector3(round(vec.x),0,round(vec.z))
						
						#sha.novos_valores.set_points(novos_valores)
					1:
						novos_valores[2] = Vector3(round(vec.x),1,round(vec.z))
						novos_valores[3] = Vector3(round(vec.x),0,round(vec.z))
						#sha.novos_valores.set_points(novos_valores)
					2:
						novos_valores[4] = Vector3(round(vec.x),1,round(vec.z))
						novos_valores[5] = Vector3(round(vec.x),0,round(vec.z))
						#sha.novos_valores.set_points(novos_valores)
					3:
						novos_valores[6] = Vector3(round(vec.x),1,round(vec.z))
						novos_valores[7] = Vector3(round(vec.x),0,round(vec.z))
						#sha.shape.set_points(shape)
				

				sha.shape.points = novos_valores
				$"../NavigationRegion3D".call_deferred("bake_navigation_mesh",true)
				index = null
			selecionado = null
			move = false
			
			#return
