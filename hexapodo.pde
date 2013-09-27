class hexapodo {

  int l1 = 20;
  int l2 = 30;
  int l3 = 40;
  int   numpatas = 6;


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


  //RESULTADO ACEPTABLE (MEJORAR)
  void sesgar(float x, float y, float z) {
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);
//      x=pata.posfin.x + x;
  //    y=pata.posfin.y + y;
    //  z=pata.posfin.z + z;

      if (pata.inv == true) {
        // (REMAL PLANTEADO)        pata.angAntebr= pata.angAntebr * -1;
//        x=-x;
      }
      pata.calcularxy(pata.posfin.x + x,pata.posfin.y + y,pata.posfin.z + z, 0);
    }
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
      pata.calcularxy(40, 15*sin(t+desfase), 15*cos(t+desfase) - 20, 0);
    }
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
      pata.calcularxy(40, 15*cos(t+desfase), 15*sin(t+desfase) - 20, 0);
    }
  }

  //RESULTADO CAMBIANTE, FUNCIONA EN EL DRAW Y CREO QUE MAL (POR REPLANTEAR) 
  void stop() {
    /*
    for (int i = 0 ; i < lasPatas.size() ; i++) {
     brazo  pata = lasPatas.get(i);
     pata.calcularxy(40, 30, 0, 0);
     }*/


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
  }
}

