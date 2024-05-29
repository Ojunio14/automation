extends StaticBody3D
class_name Pefuradora

var objects : Array
var ActiveBuildableObject : bool
var out_area := true

#para saber onde vai ser adicionado na scene tree
var spawn : Dictionary = {"spawn" : [
	{"group" : "Mining"},
	{"type" : "Broca_Mineradora"}]}

enum  State_Area {
	NULL,
	DENTRO,
	FORA
}

var current_State_Area = State_Area.NULL

#qunatidade de minerios ma estrutura
var quantity_minerio : int = 0

#limite maxiomo de minerios
var  limite_max_minerios :int = 30

#----------------------------Ready------------------------------------
func _ready():
	if get_parent().name == "Group_Broca_Mineradora":
		var tes = get_parent().get_parent().get_parent()
		tes.call_deferred("bake_navigation_mesh",true)
	$criando_ferro.connect("timeout",Callable(self,"timeout"))
	$verific.connect("area_entered",Callable(self,"_on_area_3d_area_entered"))
	$verific.connect("area_exited",Callable(self,"_on_area_3d_area_exited"))

#----------------------------_process------------------------------------

func _process(delta: float) -> void:
	if get_parent().name == "Group_Broca_Mineradora":
		contagem_timer($criando_ferro)

#-------------------Relacionado_Add_minerios_timer-------------------

# Region para a adicionar minerios com o timer
#region Timer REGION

#-------------------Variaveis-------------------
# estado do timer
enum state_timer {
	SEARCH,
	CONTAGEM,
	STOP
}

#qual vai ser o estado do timer
var current_state_timer = state_timer.SEARCH

var stop_timer : bool = true

#quantidade de segundos qu o timer ira comerça
var contagem_do_timer : float = 1

#-------------------Funçoes-------------------

# vai estar fazendo contagem do timer para criar minerios
func contagem_timer(timer_de_minerio : Timer) -> void:
	match current_state_timer:
		# estado de procura
		#  ele vai verificar se a quantidade de minerios é menor que o limite maximo
		state_timer.SEARCH:
			if quantity_minerio < limite_max_minerios:
				$AnimationPlayer.play("escava")
				current_state_timer = state_timer.CONTAGEM
		
		# estado de cotagem
		state_timer.CONTAGEM:
			#vai verificar se a quantidade de minerios é igual ao limite maximo
			if quantity_minerio == limite_max_minerios:
				#se for vai para o estado do timer
				current_state_timer = state_timer.STOP
			
			#vai iniciar o timer
			if stop_timer:
				timer_de_minerio.start(contagem_do_timer)
				
				stop_timer = false
		
		#estado de parada
		# vai para a cada vez que o se a quantidade de minerios é igual ao limite maximo
		state_timer.STOP:
			$AnimationPlayer.stop()
			$AnimationPlayer.play("volta")
			timer_de_minerio.stop()
			stop_timer = true
			current_state_timer = state_timer.SEARCH
#endregion
#-----------------------------------------------------------------


#-------------------Relacionado_funçoes_de_alguns_sinais-------------------
#region Funçoes Sinais Region

func timeout() -> void:
	quantity_minerio += 1
	stop_timer = true

# quando um edificio entra ele ira diferencia se estar dentro da area
func _on_area_3d_area_entered(area):
	if area.get_parent() is Mining:
		out_area = true
		current_State_Area = State_Area.DENTRO
	
	match current_State_Area:
		State_Area.DENTRO:
			if area.get_parent() is Pefuradora:
				if ActiveBuildableObject:
					objects.append(area)
					BuildManeger.AbleToBuild = false
					return
			elif area.get_parent() is Mining:
				BuildManeger.AbleToBuild = true
		State_Area.FORA:
			pass

func _on_area_3d_area_exited(area):
	if area.get_parent() is Mining:
		out_area = false
		current_State_Area = State_Area.FORA
	elif area.get_parent() is Pefuradora:
		current_State_Area = State_Area.DENTRO
		
	match current_State_Area:
		State_Area.DENTRO:
			if out_area:
				if ActiveBuildableObject:
					objects.remove_at(objects.find(area))
					if objects.size() <= 0:
						BuildManeger.AbleToBuild = true
		
		State_Area.FORA:
			if ActiveBuildableObject:
				BuildManeger.AbleToBuild = false

# usado para animaçao
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "escava":
		$AnimationPlayer.play("escavando")

#endregion
