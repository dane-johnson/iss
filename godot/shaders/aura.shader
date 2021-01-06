shader_type spatial;

render_mode unshaded;

uniform vec4 color : hint_color;

const float thickness = 0.7;

varying vec4 origin;

void vertex() {
	VERTEX += NORMAL * thickness;
	origin = MODELVIEW_MATRIX * vec4(0.0, 0.0, 0.0, 1.0);
}

void fragment() {
	ALBEDO = color.rgb;
	float power = thickness / 2.0 - distance(VERTEX.xy, origin.xy);
	//float power = 1.0;
	ALPHA = clamp(power, 0.0, 1.0);
}