shader_type canvas_item;

uniform vec2 velocity;
uniform float speed;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if (COLOR.a > 0.0) {
		//COLOR = vec4(1.0,1.0,1.0,1.0);
		
		COLOR = vec4(
			(cos(speed / 500.0)+1.0)/2.0, 
			0.7 * (cos(speed / 1000.0)+1.0)/2.0, 
			0.3, 
			1.0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
