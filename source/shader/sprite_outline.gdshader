shader_type canvas_item;

uniform float outline_width = 1.0;
uniform vec4 outline_color : source_color = vec4(0,0,0,1);

render_mode unshaded;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	
	vec2 uv = SCREEN_UV;
	vec4 color_up = texture(screen_texture,uv+vec2(0,SCREEN_PIXEL_SIZE.y)*outline_width);
	vec4 color_down = texture(screen_texture,uv+vec2(0,-SCREEN_PIXEL_SIZE.y)*outline_width);
	vec4 color_left = texture(screen_texture,uv+vec2(-SCREEN_PIXEL_SIZE.x,0)*outline_width);
	vec4 color_right = texture(screen_texture,uv+vec2(SCREEN_PIXEL_SIZE.x,0)*outline_width);
	vec4 outline=color_up+color_down+color_left+color_right;
	outline.rgb=outline_color.rgb;
	vec4 original_color = texture(screen_texture,SCREEN_UV);
	COLOR = mix(outline,original_color,original_color.a);
	
	//vec4 c = texture(screen_texture, uv+vec2(0,SCREEN_PIXEL_SIZE.y));
	//COLOR = c;
	
	
}
