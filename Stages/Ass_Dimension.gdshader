shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_enable, filter_nearest;

uniform float glitch_amount = 1.0;
uniform float glitch_speed = 1.0;

float hash2(vec2 p) {
    float hash = mod(p.x, 289.0);
    hash = mod((hash*51.0 + 2.0)*hash + p.y, 289.0);
    hash = mod((hash*34.0 + 10.0)*hash, 289.0);
    return hash;
}

float stair(float i, float step_count) {
    return mod(floor(i / (1.0 / step_count)), step_count);
}

void fragment() {
    float glitch_progress = TIME * glitch_speed;
	// Called for every pixel the material is visible on.
    float block_index = floor(UV.y * abs(sin(glitch_progress)) / 0.05);
    float ugh =  hash2(vec2(0, block_index + glitch_progress));

    float hash_x = ugh * 0.0001 + (1.0 - stair(glitch_progress * ugh * 0.02, 2)) * 0.07;
    hash_x *= glitch_amount;

    vec2 adjusted_uv = UV + vec2(hash_x, 0.0);
    vec3 col = 1.0 * min(vec3(1.0), vec3(ugh)) - textureLod(screen_texture, adjusted_uv, 0.0).xyz;

    vec2 chroma_offset = vec2(0.02 * sin(glitch_progress), 0.01 * cos(glitch_progress));
    col.r = mix(col, textureLod(screen_texture, adjusted_uv + chroma_offset, 0.0).xyz, 0.8).r;

    float alpha = 1.0 - length(0.5 - UV);
    COLOR = vec4(col * alpha, 1.0);
    //COLOR = vec4(vec3(ugh), 1.0);
}
