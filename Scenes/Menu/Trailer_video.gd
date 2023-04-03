extends Control

#onready var video_play = $VideoPlayer
#onready var http = $HTTPRequest
#onready var link_video = "https://drive.google.com/file/d/1Q8lh1bwO85sTiayTOUCn0LsS3dFCKcbY/view"
 


func _ready():
	
	$HTTPRequest.request("https://drive.google.com/file/d/1Q8lh1bwO85sTiayTOUCn0LsS3dFCKcbY/view")
	
	#http.request(link_video)
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	
	#var resultado =
	#var json_parseado = JSON.parse(resultado)
	#var diccionario = json_parseado.result
	#video_play.video = diccionario["https://drive.google.com/drive/folders/1YNOtIBtvbkS1n6LDBJQXFX0n4t9T76Vp"]

