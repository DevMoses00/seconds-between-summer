shader_type canvas_item;
render_mode blend_mix;

void fragment() {
    float seam_center = 0.5; // middle of the rect's UV
    float seam_width = 0.5;  // fade width across entire rect (full = 1.0)

    // Create a wave distortion along the Y axis
    float wave = sin(UV.y * 30.0 + TIME * 3.0) * 0.05;

    // Distance from center with wave
    float dist = abs(UV.x - seam_center + wave);

    // Fade out based on distance from center
    float alpha = smoothstep(seam_width, 0.0, dist);

    // Final output: white color with fading alpha
    COLOR = vec4(1.0, 1.0, 1.0, alpha);
}
