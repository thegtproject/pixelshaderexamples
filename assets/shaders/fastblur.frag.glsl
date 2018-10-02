#version 330 core

// base shader code from https://www.shadertoy.com/view/XssSDs

in vec2 texcoords;
out vec4 fragColor;

// Pixel default uniforms
uniform vec4 u_texbounds;
uniform sampler2D u_texture;

// Our custom uniforms
uniform float u_time;
uniform vec4 u_mouse;

vec2 Circle(float Start, float Points, float Point) 
{
    float Rad = (3.141592 * 2.0 * (1.0 / Points)) * (Point + Start);
    return vec2(sin(Rad), cos(Rad));
}

void main()
{
    // It is often very useful to normalize the fragment coordinate. Usually
    // represented as "uv" we do so here:
    //
    // Normalize the fragments's position, this is the location we use to sample
    // our two textures/buffers. Note: Pixel passes resolution info through
    // u_texbounds.zw (x, y)
	vec2 uv = gl_FragCoord.xy / u_texbounds.zw;


    vec2  PixelOffset = 1.0 / u_texbounds.zw;
    float Start = 4.0 / 14.0;
	vec2  Scale = 0.66 * 4.0 * 2.0 * PixelOffset.xy;
    
    vec3 N0 = texture(u_texture, uv + Circle(Start, 14.0, 0.0) * Scale).rgb;
    vec3 N1 = texture(u_texture, uv + Circle(Start, 14.0, 1.0) * Scale).rgb;
    vec3 N2 = texture(u_texture, uv + Circle(Start, 14.0, 2.0) * Scale).rgb;
    vec3 N3 = texture(u_texture, uv + Circle(Start, 14.0, 3.0) * Scale).rgb;
    vec3 N4 = texture(u_texture, uv + Circle(Start, 14.0, 4.0) * Scale).rgb;
    vec3 N5 = texture(u_texture, uv + Circle(Start, 14.0, 5.0) * Scale).rgb;
    vec3 N6 = texture(u_texture, uv + Circle(Start, 14.0, 6.0) * Scale).rgb;
    vec3 N7 = texture(u_texture, uv + Circle(Start, 14.0, 7.0) * Scale).rgb;
    vec3 N8 = texture(u_texture, uv + Circle(Start, 14.0, 8.0) * Scale).rgb;
    vec3 N9 = texture(u_texture, uv + Circle(Start, 14.0, 9.0) * Scale).rgb;
    vec3 N10 = texture(u_texture, uv + Circle(Start, 14.0, 10.0) * Scale).rgb;
    vec3 N11 = texture(u_texture, uv + Circle(Start, 14.0, 11.0) * Scale).rgb;
    vec3 N12 = texture(u_texture, uv + Circle(Start, 14.0, 12.0) * Scale).rgb;
    vec3 N13 = texture(u_texture, uv + Circle(Start, 14.0, 13.0) * Scale).rgb;
    vec3 N14 = texture(u_texture, uv).rgb;
    
    float W = 1.0 / 15.0;
    
    vec3 color = vec3(0,0,0);
    
	color.rgb = 
		(N0 * W) +
		(N1 * W) +
		(N2 * W) +
		(N3 * W) +
		(N4 * W) +
		(N5 * W) +
		(N6 * W) +
		(N7 * W) +
		(N8 * W) +
		(N9 * W) +
		(N10 * W) +
		(N11 * W) +
		(N12 * W) +
		(N13 * W) +
		(N14 * W);

    // curTexColor is the value of the current fragment color
    // from Pixel's (the library) input texture.
    vec4 curTexColor = texture(u_texture, uv);
    
    float xvalue = 0.0;

    // Left mouse button is currently pressed
    if (u_mouse[2] == 1.0) xvalue = u_mouse[0] / u_texbounds.z;

    if(uv.x < xvalue)
    {
		color.rgb = curTexColor.rgb;
    }

    // Draw a black verticle line between our two halves
    // to distinguish unblurred and blurred
    if(abs(uv.x - xvalue) < 0.0015)
        color = vec3(0.0);

    fragColor = vec4(color.rgb, 1.0);
}
