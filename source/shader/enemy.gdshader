shader_type canvas_item;

//受击闪烁变红
uniform bool is_red = false;
uniform vec3 red_color : source_color = vec3(1,0,0);

//土元素减速的糊泥巴效果
uniform sampler2D noise_textrue;
uniform float earth_progress : hint_range(0.0, 1.0, 0.01) = 0.0;
uniform vec4 earth_color : source_color = vec4(0.6,0.4,0.102,1);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	
	if (is_red){
		current_color.xyz=red_color;
	}
	
	float noise_value = texture(noise_textrue,UV).r;
	if (noise_value<earth_progress){
		COLOR=earth_color;
	}else{
		COLOR=current_color;
	}

	COLOR.a*=current_color.a;
}

