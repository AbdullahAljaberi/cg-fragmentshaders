#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;

// Output
out vec4 FragColor;

void main() {
    vec2 coord = model_uv * 2.0 - 1.0;
    float theta = atan(coord.y, coord.x);
    float radius = pow(length(coord), 1.5);
    vec2 fishEyeCoord = radius * vec2(cos(theta), sin(theta));
    vec2 finalCoord = 0.5 * (fishEyeCoord + 1.0);
    FragColor = texture(image, finalCoord);
}
