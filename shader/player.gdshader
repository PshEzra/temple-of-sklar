shader_type canvas_item;

uniform float time_ext;

void vertex(){
	VERTEX.y = VERTEX.y - abs(sin(time_ext * 4.0)) * 5.0;
}
