#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
float EPS = 0.75;
void main() {
    // Map Coordinates to $$\mathcal{N}^2 \rightarrow \matcal{N}\\{0}$
    float num = gl_FragCoord.x + u_resolution.x*gl_FragCoord.y;
    // catch even divisors
    if( mod(num , 2.0) < EPS ){
        gl_FragColor = vec4(1.0);
    }
    for (float k = 1.0; k > 0.0; k+=1.0){ 
        //catch uneven divisors
        if( mod(num, 2.0*k+1.0) < EPS){
            gl_FragColor = vec4(1.0);
            break;
        }
        // abort at $\sqrt{num}$ as 
        // $$ \forall r \in \mathcal{R} | r^2 > num \RightArrow \frac{num}{r} < r $$
        if( float(4.0*k*k) > num){
            gl_FragColor = vec4(0.0);
            break;
        }
    }
}
