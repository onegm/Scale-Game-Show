extends Node2D

@onready var clipping_sprite := $ClippingSprite
@onready var cover_sprite := $CoverSprite
var wall
var wall_cover

func set_posture(index : int, flipped : bool):
	clipping_sprite.flip_h = flipped
	clipping_sprite.play(str(index))
	cover_sprite.flip_h = flipped
	cover_sprite.play(str(index))

func set_posture_scale(new_scale : float):
	scale = new_scale*Vector2.ONE
	wall.scale /= new_scale
	wall_cover.scale /= new_scale
	
func set_wall(new_wall : Node2D):
	wall = new_wall
	wall.reparent(clipping_sprite)

func set_cover(new_wall_cover : Node2D):
	wall_cover = new_wall_cover
	wall_cover.reparent(cover_sprite)
