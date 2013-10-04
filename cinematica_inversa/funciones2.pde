
PVector cil2cart(float r, float theta, float z) {
  return( new PVector (r*cos(theta), r *sin(theta), z ));
}



PVector esf2cart(float r, float theta, float phi) {
  return( new PVector (r*cos(theta)*sin(phi), r *sin(theta)*sin (phi), r*cos(phi) ));
}





