import peasy.*;

int w = 600;
int h = 400;

int x=40, y=0, z=60;
float theta=0;


float t = 0 ; 

PeasyCam camara;

Nave enterprise;
brazo mano;

void setup() {
  size( w, h, P3D );
  camara = new PeasyCam(this, 70);
  smooth();
  //  lights();
  mano = new brazo(100, 80, 50);
}

void draw() {
  background(150);

  t = millis() / 1000.0 ;

  if (mousePressed) {
    background(100);
    ejes(100);
  }
  mano.dibujate();
  mano.calcularxy(x, y, z, theta);
}



void keyPressed() {
  //println(key);
  switch(key) {

    case ('a'): 
    x = x-1;
    break;
  case 'd': 

    x +=1;
    break;
  case 'w': 
    y   -=1;
    break;
  case 's' : 
    y += 1;
    break;
  case 'q' : 

    z -= 1;
    break;
  case 'z' : 

    z += 1;
    break;
  case 'x' : 

    theta += 1;
    break;
  case 'c' : 

    theta -= 1;
    break;

  case 'u' : 
    x=mouseX;
    break;
  case 'i' : 
    y=mouseX;
    break;
  case 'o' : 
    z=mouseX;
    break;
  case 'p' : 
    theta=mouseX;
    break;
  case ' ' : 
    println("");
    println ("giro          " + mano.angGiro* mano.grad);
    println ("brazo         " + mano.angBrazo* mano.grad);
    println ("antebrazo     " + mano.angAntebr* mano.grad);
    println ("muñeca        " + mano.angMunec* mano.grad);
    break;

  case 'j' : 
    println(" ");
    println ("alfa          " + mano.alfa * mano.grad);
    println ("beta          " + mano.beta * mano.grad);
    println ("gama          " + mano.gama * mano.grad);

    break;



  default:
    println(" ");
    println("X: " + x);
    println("Y: " + y);
    println("Z: " + z);
    println("Theta: " + theta);
    println("hipo: " + mano.hipotenusa);
    println("espacio: " + mano.espacio );
    break;
  }
}

