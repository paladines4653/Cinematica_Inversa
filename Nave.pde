class Nave{
  // Los atributos
  color c;
  float ancho;
  float alto;
  float angulo;
  
  PVector pos;
  PVector pos_old;
  
  Nave(PVector pos_init , float ancho_init, float alto_init, color color_init){
    pos = new PVector();
    pos.set(pos_init);
    pos_old = new PVector(pos.x, pos.y - 0.01, 0);
    ancho = ancho_init;
    alto = alto_init;
    c = color_init;
  }
  
  Nave(){
    pos = new PVector(random(50), 0, 0);
    pos_old = new PVector(pos.x, pos.y - 0.01, 0);
    ancho = 5;
    alto = 10;
    c = color(150);
  }
  
  void mueveteAqui(float x , float y, float z){
    pos_old.set(pos);
    pos.set(x, y, z);
  }
  
  void dibujate(){
    // Calcular ángulos
    float dy = pos.y - pos_old.y;
    float dx = pos.x - pos_old.x;
    angulo = atan2( dx, dy ); 
    fill(c);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotate( - angulo );
    //box(alto);
    stroke(0);
    piramide(ancho, alto/ancho , c);
    
    popMatrix();
  }
  
}
