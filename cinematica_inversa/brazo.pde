class brazo {
  //variables de conversion
  float rad   = PI/180;
  float grad  = 180/PI;


  float [] angulos = new float [4];  

  //  color c;
  float ancho = 2;
  //dimensiones distancias

  int alturaH =0;
  int LBrazo;
  int LAntebr;
  int LMunec;
  int espacio;

  boolean inv = false;

  //variables a calcular

  float xPrima;
  float yPrima;

  float Afx;
  float Afy;
  float ladoB;
  float ladoA;
  float hipotenusa;
  float alfa;
  float beta;
  float gama;

  float angGiro;
  float angBrazo;
  float angAntebr;
  float angMunec;
  float cabeceo;



  PVector poshombro;
  PVector poscodo;
  PVector posmuneca;
  PVector posfin;




  brazo(int altura, int L1_init, int L2_init, int L3_init) {

    alturaH = altura;
    LBrazo  =  L1_init;
    LAntebr =  L2_init;
    LMunec  =  L3_init;
    espacio =LBrazo*2 + LAntebr*2;

    //  cabeceo = radians(giro_init);
    // println("cabeceo " + cabeceo);

    poshombro = new PVector( 0, 0, 0);
    poscodo = new PVector(LBrazo, 0, 0);
    posmuneca = new PVector( LAntebr, 0, 0);
    posfin= new PVector (0, 0, 0);
    //    calcularxy(20,20,20,0);
    //    ancho = ancho_init;
  }

  void setInv(boolean invertir) {
    inv = invertir;
  }

  void setInv() {
    inv = !inv;
  }

  void saveAng() {


    String strGiro = "" + angGiro;
    String strBrazo = "" + angBrazo;
    String strAntebr = "" + angAntebr;
    String strMunec = "" + angMunec;



    if ((strGiro.equals("NaN")) || (strBrazo.equals("NaN")) || (strAntebr.equals("NaN")) || (strMunec.equals("NaN")) ) {
//      println("Pata numero " + (in+1) + " no puede llegar a destino");
    } 
    else {
      angulos[0] = angGiro;
      angulos[1] = angBrazo;
      angulos[2] = angAntebr;
      angulos[3] = angMunec;
    }
  }


  void calcularxy(PVector pos, float cabeceo_init) {
    calcularxy(pos.x, pos.y, pos.z, cabeceo_init);
  }

  void calcularxy(float px, float py, float pz, float cabeceo_init) {
    if ((posfin.x != px) || (posfin.y != py) || (posfin.z != pz)) {
      if (inv) {
        //px=-px;
      }

      posfin.set(px, py, pz);

      cabeceo = cabeceo_init;

      boolean menos = false;
      boolean mas = false;
      int repeat=0;

      while ( (menos == true) || (mas == true) || (repeat == 0)) {


        cabeceo = cabeceo * rad;

        xPrima =  sqrt ( sq(px) + sq(py) );
        yPrima =  pz;


        Afx    =  cos (cabeceo)* LMunec;
        Afy    =  sin (cabeceo)* LMunec;

        ladoB  = xPrima - Afx;
        ladoA  = yPrima - Afy - alturaH;

        hipotenusa  = sqrt( sq(ladoA) + sq(ladoB) );
        //  println("HIPOTENUSA " + hipotenusa);

        alfa    = atan2   (ladoA, ladoB);
        beta    = acos    ( (sq(LBrazo) - sq(LAntebr) + sq(hipotenusa) ) / ( 2 * LBrazo * hipotenusa) );
        gama    = acos    ( (sq(LBrazo) + sq(LAntebr) - sq(hipotenusa) ) / ( 2 * LBrazo * LAntebr) );



        //angulos en grados
        angBrazo    = (alfa + beta) ;
        angAntebr   = (-((180*rad) - gama));
        angMunec    = cabeceo - angBrazo - angAntebr;
        angGiro     = atan2(py, px);

        if (inv) {
          angGiro = - angGiro;
        }

        repeat +=1;

        //      println("repeat " + repeat);

        if  ( angMunec*grad < -90 ) {
          menos = true;
          mas = false;
          cabeceo=cabeceo * grad + 1;
        }
        else if (angMunec*grad > 90) {
          mas = true;    
          menos=false;    
          cabeceo=cabeceo * grad - 1;
        }
        else {
          mas = false;
          menos=false;
        }
      }
    }

    saveAng();
  }

  float[] printAng() {
    return(angulos);
  }


  void dibujate() {

    if (inv) {
      rotateY(180 * PI/180);
    }

    beginShape(QUAD);
    fill(255);
    stroke(0);

    /* vertex(  espacio, -alturaH, espacio);
     vertex( -espacio, -alturaH, espacio);
     vertex( -espacio, -alturaH, -espacio);
     vertex(  espacio, -alturaH, -espacio);*/

    endShape();

    noStroke();



    // HOMBRO ##########################################################
    fill (0, 0, 200);
    rotateY(angulos[0]);
    //    translate(0, alturaH, 0);
    caja(ancho, alturaH, ancho);


    // BRAZO ##########################################################
    fill (200, 0, 0);
    stroke(0);
    translate(0, alturaH, 0);
    //rotacion del angulo brazo sobre el eje z
    rotateZ(angulos[1]);

    translate(LBrazo, 0, 0);
    caja(LBrazo, ancho, ancho);

    //ANTEBRAZO ########################################################
    fill (200, 200, 0);
    translate(LBrazo, 0, 0);
    rotateZ(angulos[2]);
    translate(LAntebr, 0, 0);
    caja(LAntebr, ancho/4*3, ancho/4*3);



    //MUÑECA ########################################################

    fill (0, 200, 0);
    translate(LAntebr, 0, 0);
    rotateZ(angulos[3]);
    translate(LMunec, 0, 0);
    caja(LMunec, ancho/2, ancho/2);
  }
}

