#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;
uniform float time;

// Output
out vec4 FragColor;

// Function to create random noise
float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.0, 78.0))) * 10.0);
}

void main() {
    // Get the original color
    vec4 color = texture(image, model_uv);

    // Create glitchy offsets
    float noise = random(model_uv + time);
    vec2 offset = vec2(noise * 0.2, noise * 0.2);

    // Apply horizontal and vertical shifts
    vec2 glitchUV = model_uv;
    if (mod(time * 10.0, 1.0) < 0.05) {
        glitchUV.x += offset.x;
    }
    if (mod(time * 15.0, 1.0) < 0.05) {
        glitchUV.y += offset.y;
    }

    // Create random noise lines
    if (mod(time * 20.0 + model_uv.y * 10.0, 1.0) < 0.1) {
        glitchUV.x += random(vec2(time, model_uv.y)) * 10.1;
    }

    // Shift color channels to create a color glitch effect
    vec4 glitchColor = vec4(
        texture(image, glitchUV + vec2(offset.x * 0.2, 0.0)).r,
        texture(image, glitchUV + vec2(0.0, offset.y * 0.2)).g,
        texture(image, glitchUV + vec2(offset.x * 0.2, 0.0)).b,
        1.0
    );

    // Combine original color with glitch color
    FragColor = mix(color, glitchColor,5.5);
}
