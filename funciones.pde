
void ejes(float largo) {
  strokeWeight(2);
  stroke( 100, 0, 0 );
  line( 0, 0, 0, largo, 0, 0 );

  stroke( 0, 100, 0 );
  line( 0, 0, 0, 0, largo, 0);

  stroke( 0, 0, 100 );
  line( 0, 0, 0, 0, 0, largo);
}

void piramide (float tam, float escala, color c) {
  // A que no adivina qué figura dibuja este código...

  beginShape(TRIANGLES);
  //noStroke();
  //strokeWeight(2);
  //stroke(155);
  fill(c);
  vertex( tam, tam, 0 );
  vertex( tam, -tam, 0 );
  vertex( 0, 0, escala * tam);

  vertex( tam, -tam, 0 );
  vertex( -tam, -tam, 0);
  vertex( 0, 0, escala * tam);

  vertex( -tam, -tam, 0);
  vertex( -tam, tam, 0 );
  vertex( 0, 0, escala * tam);

  vertex( -tam, tam, 0 );
  vertex( tam, tam, 0);
  vertex( 0, 0, escala * tam);

  endShape();
}

void caja(float tam_x, float tam_y, float tam_z) {
  strokeWeight(2);

noStroke();

  beginShape(QUAD);
  //derecho
  vertex(tam_x, -tam_y, -tam_z);
  vertex(tam_x,  tam_y, -tam_z);
  vertex(tam_x,  tam_y,  tam_z);
  vertex(tam_x, -tam_y,  tam_z);
  //tapa
  vertex( tam_x, tam_y, -tam_z);
  vertex(-tam_x, tam_y, -tam_z);
  vertex(-tam_x, tam_y,  tam_z);
  vertex( tam_x, tam_y,  tam_z);
  //lizquirdo
  vertex(-tam_x, -tam_y, -tam_z);
  vertex(-tam_x,  tam_y, -tam_z);
  vertex(-tam_x,  tam_y,  tam_z);
  vertex(-tam_x, -tam_y,  tam_z);
  //base
  vertex(-tam_x, -tam_y, -tam_z);
  vertex( tam_x, -tam_y, -tam_z);
  vertex( tam_x, -tam_y,  tam_z);
  vertex(-tam_x, -tam_y,  tam_z);

  //frente

  vertex(-tam_x,  tam_y, -tam_z);
  vertex(-tam_x, -tam_y, -tam_z);
  vertex( tam_x, -tam_y, -tam_z);
  vertex( tam_x,  tam_y, -tam_z);

  //espalda
  vertex( tam_x,  tam_y, tam_z);
  vertex( tam_x, -tam_y, tam_z);
  vertex(-tam_x, -tam_y, tam_z);
  vertex(-tam_x,  tam_y, tam_z);
  endShape();
  
}


/*

 // HOMBRO
 void dicujando() {
 beginShape(QUAD);
 
 vertex(  espacio, -alturaH, espacio);
 vertex( -espacio, -alturaH, espacio);
 vertex( -espacio, -alturaH, -espacio);
 vertex(  espacio, -alturaH, -espacio);
 
 endShape();
 
 rotate(0, angGiro, 0);
 
 beginShape(QUAD);
 vertex( 40, 0, -60 );
 vertex(-40, 0, -60 );
 vertex(-40, 0, 60 );
 vertex( 40, 0, 60 );    
 
 vertex( 40, -alturaH, 60 );
 vertex(-40, -alturaH, 60 );
 vertex(-40, -alturaH, -60 );
 vertex( 40, -alturaH, -60 );
 
 vertex( 40, 0, 60 );
 vertex(-40, 0, 60 );
 vertex(-40, -alturaH, 60 );
 vertex( 40, -alturaH, 60 );
 
 vertex( 40, -alturaH, -60 );
 vertex(-40, -alturaH, -60 );
 vertex(-40, 0, -60 );
 vertex( 40, 0, -60 );
 
 vertex(-40, 0, 60 );
 vertex(-40, 0, -60 );
 vertex(-40, -alturaH, -60 );
 vertex(-40, -alturaH, 60 );
 
 vertex(40, 0, -60 );
 vertex(40, 0, 60 );
 vertex(40, -alturaH, 60 );
 vertex(40, -alturaH, -60 ); 
 
 endShape();
 }
 
 */

