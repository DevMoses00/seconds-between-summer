shader_type canvas_item;

uniform float blur_size = 2.0;

void fragment() {
    vec4 sum = vec4(0.0);
    vec2 size = blur_size * TEXTURE_PIXEL_SIZE;

    sum += texture(TEXTURE, UV + vec2(-size.x, -size.y)) * 0.0625;
    sum += texture(TEXTURE, UV + vec2( 0.0,    -size.y)) * 0.125;
    sum += texture(TEXTURE, UV + vec2( size.x, -size.y)) * 0.0625;

    sum += texture(TEXTURE, UV + vec2(-size.x, 0.0))    * 0.125;
    sum += texture(TEXTURE, UV)                         * 0.25;
    sum += texture(TEXTURE, UV + vec2( size.x, 0.0))    * 0.125;

    sum += texture(TEXTURE, UV + vec2(-size.x, size.y)) * 0.0625;
    sum += texture(TEXTURE, UV + vec2( 0.0,    size.y)) * 0.125;
    sum += texture(TEXTURE, UV + vec2( size.x, size.y)) * 0.0625;

    // Multiply by modulate color
    COLOR = sum * COLOR;
}
