#version 330 core

// Keep in mind, I have very little idea what I'm doing when it comes
// to these shaders, so take what you see here with a grain of salt.
 
out vec4 fragColor;

// Pixel default uniforms
uniform vec4 u_texbounds;
uniform sampler2D u_texture;
uniform sampler2D u_backbuffer;

// Our custom uniforms
uniform float u_amount;

void main() {
    // It is often very useful to normalize the fragment coordinate. Usually
    // represented as "uv" we do so here:
    vec2 uv = gl_FragCoord.xy / u_texbounds.zw;
    fragColor = texture(u_texture, uv);
 
    // u_amount is programmed to be adjustable with the left and right keys
    // inside of Pixel
    fragColor *= texture(u_backbuffer, uv).a * u_amount;
}
