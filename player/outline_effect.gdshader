shader_type canvas_item;

const int angRes = 8;
const int gradRes = 8;

uniform float line_width = 10.0;
uniform vec4 starting_color = vec4(0, 0, 0, 0);
uniform vec4 ending_color = vec4(1, 1, 0, 1);

bool pixelInRange(sampler2D text, vec2 uv, vec2 dist) {
	for (int i = 0; i < angRes; i ++) {
		float angle = 2.0 * PI * float(i) / float(angRes);
		vec2 disp = dist * vec2(cos(angle), sin(angle));
		if (texture(text, uv + disp).a > 0.0) return true;
	}
	return false;
}

float getClosestDistance(sampler2D text, vec2 uv, vec2 maxDist) {
	for (int i = 1; i <= gradRes; i++) {
		vec2 dist = float(i) / float(gradRes) * maxDist;
		if (pixelInRange(text, uv, dist)) {
			if (float(i) / float(gradRes) > line_width/30.0) {
				return 1.0;
			} else {
				return 0.0;
			}
			//return float(i) / float(gradRes);
		}
	}
	return -1.0;
}

void fragment() {
	vec2 scaleDist = TEXTURE_PIXEL_SIZE * line_width;
	float w = getClosestDistance(TEXTURE, UV, scaleDist);
	
	if (w > 0.0 && texture(TEXTURE, UV).a <= 0.2) {
		COLOR = mix(starting_color, ending_color, w);
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}
