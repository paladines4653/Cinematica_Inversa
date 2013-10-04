import peasy.*;

int w = 1024;
int h = 768;

int x=0, y=0, z=0;
float theta=0;

float[][] angulos;

float t = 0 ; 

PeasyCam camara;

Timer reloj;

Nave enterprise;
brazo mano;
hexapodo spidy;

//boolean onoff= false;

void setup() {
  size( w, h, P3D );


  help();

  camara = new PeasyCam(this, 70);
  smooth();
  //  lights();


  reloj = new Timer();
  mano = new brazo(30, 100, 80, 50);
  spidy = new hexapodo ();
  spidy.start();




  //  float [][] angulos = new float [spidy.numpatas][4];  

  //reloj.start();
  //spidy.stop();
}

void draw() {
  background(150);



  if (mousePressed) {
    background(100);
    //    spidy.moverpata(4, x,y,z);




    ejes(100);
  }
  //  mano.dibujate();
  //suelo  
  /* beginShape(QUAD);
   fill(255);
   stroke(0);
   
   vertex(  mano.espacio, -mano.alturaH, mano.espacio);
   vertex( -mano.espacio, -mano.alturaH, mano.espacio);
   vertex( -mano.espacio, -mano.alturaH, -mano.espacio);
   vertex(  mano.espacio, -mano.alturaH, -mano.espacio);
   
   endShape();
   // fin suelo  */

  spidy.dibujar();

  //  spidy.sesX(onoff, true);
  //  spidy.adelante(t*2);
  //spidy.adelante(t);
  //spidy.stop(true);
  //  println(reloj.tiempo());

  //  angulos = (spidy.printAng());
  //println(angulos [2][2]);

  /*
  if (reloj.temporizador(1000)) {
   spidy.sesgar(x, y, z);
   x=0;
   y=0;
   z=0;
   }*/
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

  case 't' :
    spidy.setPeriodo(2);
    break;


  case ' ' : 
    println("");
    println("Angulos de rotacion.");
    println ("giro          " + mano.angGiro* mano.grad);
    println ("brazo         " + mano.angBrazo* mano.grad);
    println ("antebrazo     " + mano.angAntebr* mano.grad);
    println ("muñeca        " + mano.angMunec* mano.grad);
    break;

  case 'j' : 
    println(" ");
    println("Angulos de calculo.");
    println ("alfa          " + mano.alfa * mano.grad);
    println ("beta          " + mano.beta * mano.grad);
    println ("gama          " + mano.gama * mano.grad);

    break;
  case '8':
    spidy.adelante();
    break;
  case '2':
    spidy.atras();
    break;
  case '7':
    spidy.adelanteI(theta);
    break;
  case '9':
    spidy.adelanteD(theta);
    break;
  case '6':
    spidy.rotarD();
    break;

  case '4':
    spidy.rotarI();
    break;

  case '5':
    spidy.stop();
    break;

  case '0':
    spidy.sesgar(x, y, z);
    x=0;
    y=0;
    z=0;

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
void keyReleased() {



  switch(key) {
  case 'a':

    break;
  }
}

