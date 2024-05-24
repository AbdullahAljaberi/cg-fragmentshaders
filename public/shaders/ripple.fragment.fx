#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;
uniform float time;

// Output
out vec4 FragColor;

void main() {
    vec2 coord = model_uv * 2.0 - 1.0;
    float radius = length(coord);
    vec2 offset = coord * (sin(radius * 50.0 - time * 5.0) + 0.5) / 10.0;
    vec2 finalCoord = model_uv + offset;
    FragColor = texture(image, finalCoord);
}
