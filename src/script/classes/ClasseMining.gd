extends StaticBody3D
class_name Mining

#-------------------Relacoinado_Estrutura_basica_da_Building-------------------

#region Estrutura basica para Building REGION

#-------------------Variaveis-------------------

# tipo de minerio que a estrutura vai ter
enum type_minerio {
	FERRO,
	COBRE
	
}

#tipo de minerio escolhido
var type_minerio_atual  = null

#qunatidade de minerios ma estrutura
var quantity_minerio : int = 0

#limite maxiomo de minerios
var  limite_max_minerios :int = 30

#endregion

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
			timer_de_minerio.stop()
			stop_timer = true
			current_state_timer = state_timer.SEARCH

#endregion

