shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	// Place fragment code here.
	vec4 fin_color = texture(screen_texture, SCREEN_UV);
	fin_color.g = fin_color.r + 0.08;
	fin_color.b = fin_color.r + 0.22;
	COLOR = fin_color;
}
