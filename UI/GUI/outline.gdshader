shader_type canvas_item;

const int angRes = 8;

uniform float line_width = 10.0;
uniform vec4 outline_color = vec4(1, 1, 0, 1);

void fragment() {
	float alpha = 0.0;
	vec2 scale = TEXTURE_PIXEL_SIZE;
	
	for (int i = 0; i < angRes; i ++) {
		float angle = 2.0 * PI * float(i) / float(angRes);
		vec2 disp = scale * line_width * vec2(cos(angle), sin(angle));
		alpha += texture(TEXTURE, UV + disp).a;
	}
	
	if (alpha > 0.0 && texture(TEXTURE, UV).a <= 0.2) {
		COLOR = outline_color;
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}
