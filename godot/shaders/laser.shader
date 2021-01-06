shader_type spatial;

render_mode shadows_disabled;

uniform vec4 color : hint_color;
uniform sampler2D normalmap : hint_normal;
uniform float brightness;
uniform float min_distance;
uniform float max_distance;

void fragment() {
	ALBEDO = color.rgb;
	
	ALPHA = smoothstep(max_distance, min_distance, -VERTEX.z);
	
	vec2 my_uv = UV;
	my_uv.x = sin(my_uv.x + TIME * 0.2);
	my_uv.y = sin(my_uv.y + TIME * 0.4);
	ROUGHNESS = 0.0f;
	EMISSION = color.rgb * brightness;
	NORMALMAP = texture(normalmap, my_uv).xyz;
}