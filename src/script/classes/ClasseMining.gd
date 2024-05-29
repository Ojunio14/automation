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


var quantity_npc : int = 0

