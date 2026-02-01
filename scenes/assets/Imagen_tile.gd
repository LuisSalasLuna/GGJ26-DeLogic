extends Sprite2D

@export var tileset_texture: Texture2D
@export var region: Rect2

func _ready():
	texture = tileset_texture
	region_rect = region
	region_enabled = true
