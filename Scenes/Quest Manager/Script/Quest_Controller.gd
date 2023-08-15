extends Resource
class_name QuestController

export (String) var title
export (String) var description
export (Dictionary) var actors
export (Array,Resource) var rewards
export (float) var xpQuest
export (String,MULTILINE) var itemConfigs = "PRESETE AS CONFIGS DO ITEM APENAS SE NESSA QUEST DEVE SER PEGO ITENS. QUEM CONTROLA QUANDO O O ITEM SERÁ CRIADO É O SCRIPT GLOBAL_QUEST COM O SCRIPT LOCAL DA CENA."
export (PackedScene) var itemToGetScene
export (String) var winTxtToItem
export (String, "Cyberspace","Primeiro_Andar","Segundo_Andar") var sceneToCreateItem
