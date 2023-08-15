shader_type canvas_item;

uniform float radius_v : hint_range(0.0, 2048.0, 256.0);
uniform float radius_h : hint_range(0.0, 2048.0, 256.0);

void fragment() {
	// Aplica o efeito de blur horizontalmente e verticalmente
	const int samples = 15;
	float sigma_v = radius_v / 3.0;
	float sigma_inv_v = 1.0 / (2.0 * sigma_v * sigma_v);
	float step_v = 1.0 / radius_v;
	float sigma_h = radius_h / 3.0;
	float sigma_inv_h = 1.0 / (2.0 * sigma_h * sigma_h);
	float step_h = 1.0 / radius_h;

	vec4 blur = vec4(0.0);
	for (int i = 0; i < samples; i++) {
	float offset_v = float(i) - float(samples / 2);
	float weight_v = exp(-offset_v * offset_v * sigma_inv_v);
		for (int j = 0; j < samples; j++) {
			float offset_h = float(j) - float(samples / 2);
			float weight_h = exp(-offset_h * offset_h * sigma_inv_h);
			blur += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(offset_h * step_h, offset_v * step_v)) * weight_v * weight_h;
		}
	}
	
	blur /= float(samples * samples);
	
	// Atribui o resultado final do efeito de blur à saída do shader
	COLOR = blur;
}