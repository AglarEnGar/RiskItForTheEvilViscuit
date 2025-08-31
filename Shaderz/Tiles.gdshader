shader_type canvas_item;


void vertex() {
	// Called for every vertex the material is visible on.
}

uniform vec3 light_dir = vec3(0.5, 0.7, 0.2);
uniform sampler2D normals;
uniform sampler2D spec;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 normal = texture(normals, UV);
	
	vec3 light = normalize(vec3(sin(TIME), -1.0, cos(TIME)));
	vec4 diffuse = texture(TEXTURE, UV);
	vec4 diff2 = diffuse * dot(normal.xyz, light);
	
	// quantize the diffuse a bit
	
	COLOR = vec4(textureLod(TEXTURE, UV, 0.0).xyz * dot(normal.xyz, light), 1.0 * normal.w);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
