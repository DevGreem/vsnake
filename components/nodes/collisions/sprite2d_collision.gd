@tool
extends CollisionShape2D

class_name Sprite2DCollision

@export var sprite: Sprite2D:
	set(value):
		
		sprite = value
		
		if sprite:
			_draw_collision()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture_changed.connect(_draw_collision)

func _draw_collision():
	
	if not sprite.texture:
		return
	
	var bitmap := BitMap.new()
	
	var texture := sprite.texture
	
	if texture is PlaceholderTexture2D:
		
		var rect_shape := RectangleShape2D.new()
		rect_shape.size = texture.size
		
		self.shape = rect_shape
	else:
		
		var image: Image
		
		image = texture.get_image()
	
		bitmap.create_from_image_alpha(image)
			
		var polygons := bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, sprite.texture.get_size()), 0)
		
		var polygon_shape := ConvexPolygonShape2D.new()
		
		var points := PackedVector2Array()
		
		for polygon in polygons:
			for point in polygon:
				points.append(point - sprite.texture.get_size()/2)
		
		polygon_shape.points = points
		
		self.shape = polygon_shape
		
	self.scale = sprite.scale
