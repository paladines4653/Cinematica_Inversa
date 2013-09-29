class hexapodo {

  int l1 = 20;
  int l2 = 30;
  int l3 = 40;
  int   numpatas = 6;

  float amp = 15;

  float [][] hexAngulos = new float [numpatas][4];  


  // array <clase> nombre del arreglo
  ArrayList <brazo> lasPatas ;

  void hexapodo() {
    println("hexapodo");
  }

  void start() {
    lasPatas = new ArrayList<brazo>(numpatas);
    for ( int i = 0 ; i < numpatas ; i++) {
      lasPatas.add( new brazo(l1, l2, l3, 0) );
    }
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);
      if (i%2 != 0) {
        pata.setInv(true);
      }
    }
    stop();
  }




  void dibujar() {

    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);


      pushMatrix();
      if (i%2 != 0) {
        translate(-40, 0, -40);
      }
      translate(0, 0, i*40);
      fill(255/lasPatas.size()  * i);
      ellipse(0, 0, 30, 30);
      noFill();
      pata.dibujate();

      ejes( 50);
      popMatrix();
    }
  }


  // no muy clara falta mejorar reeeesto
  void sesX(boolean sesx, boolean lado) {
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);
      //      sesx =     pata.posfin.x  +  sesx;
      //      lado = lado/( abs(lado) );
      float x=pata.posfin.x;
      if (sesx) {
        if (lado) {
          if (pata.inv) {
            x = pata.posfin.x+1;
          }
          else {
            x = pata.posfin.x-1;
          }
        }
        else {
          if (pata.inv == false) {
            x = pata.posfin.x+1;
          }
          else {
            x = pata.posfin.x-1;
          }
        }
        pata.calcularxy(x, 0, 0, 0);
      }
    }
  }


  void saveAng() {
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);
      hexAngulos[i][0]= i;
      hexAngulos[i][1]= pata.angGiro;
      hexAngulos[i][2]= pata. angBrazo;
      hexAngulos[i][3]= pata.angAntebr;
    }
  }
  void saveAng(int in) {
    brazo pata = lasPatas.get(in);
    hexAngulos[in][in]= in;
    hexAngulos[in][2] = pata.angGiro;
    hexAngulos[in][3] = pata.angBrazo;
    hexAngulos[in][4] = pata.angAntebr;
  }


  float[][] printAng() {
    return ( hexAngulos );
  }


  //RESULTADO ACEPTABLE (MEJORAR)
  void sesgar(float x, float y, float z) {
    float px;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);
      if (pata.inv == true) {
        px=-x;
      }
      else {
        px = x;
      }
      pata.calcularxy(pata.posfin.x + px, pata.posfin.y + y, pata.posfin.z + z, 0);
    }
    saveAng();
  }

  // RESULTADO SOBRESALIENTE (MEJORAR)(pasar constantes a variables)(seleccion de servos para infinitas patas)
  void adelante(float t) {
    float desfase;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);



      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }

      pata.calcularxy(40, amp*sin(t+desfase), amp*cos(t+desfase) - 20, 0);
    }
    saveAng();
  }
  // AVANZA TOMANDO UNA CURVA PARA EL LADO DERECHO PRIMER  adelanteD(  , porcetaje de giro a la derecha );
  void adelanteD(float t, float D) {
    float desfase;

    if (D <= 0) {
      D = 1;
    }
    else if (D > 100 ) {
      D = 100;
      //D = amp * D / 100 ;
    }

    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);



      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }
      float amp2;
      if (pata.inv) {
        amp2 = 1;
      }
      else {
        amp2 = (1-(D/100));
      }
      println(amp2);
      pata.calcularxy(40, amp * amp2 *sin(t+desfase), amp*cos(t+desfase) - 20, 0);
    }
    saveAng();
  }

  // AVANZA TOMANDO UNA CURVA PARA EL LADO IZQUIERDO PRIMER  adelanteD(  , porcetaje de giro a la izquierda );
  void adelanteI(float t, float D) {
    float desfase;

    if (D <= 0) {
      D = 1;
    }
    else if (D > 100 ) {
      D = 100;
      //D = amp * D / 100 ;
    }

    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);



      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }
      float amp2;
      if (pata.inv == false) {
        amp2 = 1;
      }
      else {
        amp2 = (1-(D/100)) ;
      }

      pata.calcularxy(40, amp * amp2 *sin(t+desfase), amp * cos(t+desfase) - 20, 0);
    }
    saveAng();
  }


  // RESULTADO SOBRESALIENTE (MEJORAR) (pasar constantes a variables)(seleccion de servos para infinitas patas)
  void atras(float t) {
    float desfase;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);

      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }
      pata.calcularxy(40, amp*cos(t+desfase), amp*sin(t+desfase) - 20, 0);
    }
    saveAng();
  }
  // ROTACION HACIA LA DERECHA 
  void rotarD(float t) {
    float desfase;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);

      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }
      if (pata.inv) {
        pata.calcularxy(40, amp*sin(t+desfase), amp*cos(t+desfase) - 20, 0);
      }
      else {
        pata.calcularxy(40, amp*cos(t+desfase), amp*sin(t+desfase) - 20, 0);
      }
    }
    saveAng();
  }
  // ROTACION HACIA LA IZQUIERDA

  void rotarI(float t) {
    float desfase;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);

      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }
      if (pata.inv) {
        pata.calcularxy(40, amp*cos(t+desfase), amp*sin(t+desfase) - 20, 0);
      }
      else {
        pata.calcularxy(40, amp*sin(t+desfase), amp*cos(t+desfase) - 20, 0);
      }
    }
    saveAng();
  }



  //RESULTADO CAMBIANTE, FUNCIONA EN EL DRAW Y CREO QUE MAL (POR REPLANTEAR) 
  void stop() {
    for (int i = 0 ; i < 2 ; i++) {
      brazo pata = lasPatas.get(i);
      pata.calcularxy(40, 20, -20, 0);
    }

    for (int i = 2 ; i < lasPatas.size()-2 ; i++) {
      brazo  pata = lasPatas.get(i);
      pata.calcularxy(40, 0, -20, 0);
    }
    for (int i = lasPatas.size()-2 ; i < lasPatas.size() ; i++) {
      brazo pata = lasPatas.get(i);
      pata.calcularxy(40, -20, -20, 0);
    }
    saveAng();
  }
}

