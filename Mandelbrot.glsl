#ifdef GL_ES
precision mediump float;
#endif
 
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
/*
Basic Example of a Mandelbrot Shader
Where $c$ = Pixel Position and $x_0$ = Mouse Position.
$$ x = x^2 +c $$ 
*/

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution; // get Coordinates
    st = vec2(2.0*st.x-1.5, 2.0*st.y-1.0); // Normalize to [-1.5, 0.5]x[-1,1] Domain
    vec2 x = 2.0*(u_mouse-0.5*u_resolution)/u_resolution; // Normalize Mouse to [-2,2]^2 Domain
    x = vec2(x.y, x.x); // Flip Mouse for Starting Point
    int idx = 0; 
    for(int _ = 0; _ < 1000; _++) {
        x = vec2(x.x*x.x - x.y*x.y + st.x , 2.0 * x.y*x.x + st.y); // Compute Mandelbrot Polynomial $x = x^2 + c$
        idx++; // Increment Index
        if(length(x) > 1000.0){ // Abort for High Index
            break;
        }
    }
    // Visualize
    x = normalize(x);
    gl_FragColor = vec4(float(idx)/ 1e3, x.x,x.y,1.0);
}
