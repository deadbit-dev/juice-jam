shader_type  canvas_item;

render_mode blend_mix;

uniform vec4 color : hint_color;
uniform float weight_color;

void fragment() {
	COLOR = mix(color.rgba, texture(TEXTURE, UV).rgba, weight_color);
}