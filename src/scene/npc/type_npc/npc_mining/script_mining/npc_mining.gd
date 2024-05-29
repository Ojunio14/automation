extends CharacterBody3D


#func sta(_state):
	#match _state:
		#
		#State_NPC.SEARCH_TARGET:
			#if NpcManager.coord_diponiveis_mining != []:
				#pos = NpcManager.coord_diponiveis_mining.back()
				#if pos["M"][2]["Mina"] is MinaFerro:
					#coord = pos["M"][0]["position"]
					#current_State_Npc = State_NPC.Set_TARGET
		#State_NPC.Set_TARGET:
			#if pos != null:
					#set_movement_target(coord)
					#pos = null
					##NpcManager.coord_diponiveis.pop_back()
					#current_State_Npc = State_NPC.WALK
		#State_NPC.WALK:
			#if navigation_agent_3d.is_navigation_finished():
				#current_State_Npc = State_NPC.FINISHED
				#return current_State_Npc
			#movimentation_npc(navigation_agent_3d)
		#State_NPC.FINISHED:
			#if local_atual != null:
				#if local_atual == "Mina":
					#current_State_Npc = State_NPC.CARGA_DESCARGA
					#
		#State_NPC.CARGA_DESCARGA:
			#if carga == 0 and uma_vez:
				#$Timer.start()
				#uma_vez = false
			#if terminou_carregamento:
				#if carga == 10:
					#var storage = get_tree().get_first_node_in_group("Building").get_node("Storage")
					#if storage.get_children().size() != 0:
						#storage.get_children()[0]
						##get_tree().get_nodes_in_group("Building")[0]
						#print(get_tree().get_first_node_in_group("Building").get_node("Storage").get_child_count())
						#terminou_carregamento = false
						#if NpcManager.coord_diponivel_storage != []:
							#
							#pos = NpcManager.coord_diponivel_storage.back()
							#coord = pos["M"][0]["position"]
							#current_State_Npc = State_NPC.Set_TARGET
		#
