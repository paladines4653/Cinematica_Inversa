//************* proximos pasos**************//
/* 
 # coordinar el movimiento del hexapodo con un tiempo. coronado
 # arreglar el saveAng(); para no guardar posiciones NaN coronado
 # arraylist de alternos a y b nona
 for q recorra patas,
 alternosA = segundo for : (j= 0; j < numpatas; j +=4){if(j==i){add.arraylist (j)}; if(i==(j-1)){add.arraylist (j-1)}    }
 alternosB = segundo for : (j= 2; j < numpatas; j +=4){if(j==i){add.arraylist (j)}; if(i==(j-1)){add.arraylist (j-1)}    }
 # movimientos de (!inv & inv).
 # agregar ruido.
 
 
 */


class hexapodo {

  int l1 = 20;
  int l2 = 30;
  int l3 = 40;
  int numpatas = 6;

  float amp = 15;

  float periodo = 1000;
  float w= (2*PI)/periodo;
  float [][] hexAngulos = new float [numpatas][4];  ;
  //ArrayList <clase> nombre del arreglo
  ArrayList <brazo> lasPatas ;

  void hexapodo() {
  }

  void setNumpatas(int in) {
    if (in%2 == 0) {
      numpatas= in;
    }
    else {
      numpatas= in+1;
    }
  }

  void setPeriodo(float in) {
    periodo = periodo * in;
    w= (2*PI)/periodo;
  }

  void setAmp (float in) {
    amp = abs(in);
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



  void saveAng() {
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      saveAng(i) ;
    }
    println("");
  }





  void saveAng(int in) {
    brazo pata = lasPatas.get(in);


    String strGiro = "" + pata.angGiro;
    String strBrazo = "" + pata.angBrazo;
    String strAntebr = "" + pata.angAntebr;



    if ((strGiro.equals("NaN")) || (strBrazo.equals("NaN")) || (strAntebr.equals("NaN")) ) {
      println("Pata numero " + (in+1) + " no puede llegar a destino");
    } 
    else {
      hexAngulos[in][0]= in;
      hexAngulos[in][1] = pata.angGiro;
      hexAngulos[in][2] = pata.angBrazo;
      hexAngulos[in][3] = pata.angAntebr;
      println("pata numero " + (in+1) + " OK");

      println(hexAngulos[in][1]);
      println(hexAngulos[in][2]);
      println(hexAngulos[in][3]);
    }
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


  // MOVER UNA SOLA PATA
  void moverpata(int n, float x, float y, float z) {
    if ((n > 0) && (n < lasPatas.size())) {
      brazo pata = lasPatas.get(n-1);
      pata.calcularxy(x, y, z, 0);
    }
  }

  void moverpata(int n, int f, float x, float y, float z) {

    if ((n > 0) && (n <= lasPatas.size()) && (f>n) && (f<= lasPatas.size())  ) {
      for (int i = n-1 ; i < (f) ; i++ ) {
        brazo pata = lasPatas.get(i);
        pata.calcularxy(x, y, z, 0);
      }
    }
  }


  // RESULTADO SOBRESALIENTE (MEJORAR)(pasar constantes a variables)(seleccion de servos para infinitas patas)
  void adelante() {
    //    setPeriodo(in);
    float t = millis()%periodo;
    float desfase;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);
      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }

      pata.calcularxy(40, amp*sin((t*w)+desfase), amp*cos((t*w)+desfase) - 20, 0);
    }
    saveAng();
  }



  // AVANZA TOMANDO UNA CURVA PARA EL LADO DERECHO PRIMER  adelanteD(  , porcetaje de giro a la derecha );
  void adelanteD(float D) {
    float t = millis()%periodo;
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
      pata.calcularxy(40, amp * amp2 *sin((t*w)+desfase), amp*cos((t*w)+desfase) - 20, 0);
    }
    saveAng();
  }

  // AVANZA TOMANDO UNA CURVA PARA EL LADO IZQUIERDO PRIMER  adelanteD(  , porcetaje de giro a la izquierda );
  void adelanteI(float D) {
    float desfase;
    float t = millis()%periodo;
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

      pata.calcularxy(40, amp * amp2 *sin((t*w)+desfase), amp * cos((t*w)+desfase) - 20, 0);
    }
    saveAng();
  }


  // RESULTADO SOBRESALIENTE (MEJORAR) (pasar constantes a variables)(seleccion de servos para infinitas patas)
  void atras() {
    float desfase;
    float t = millis()%periodo;
    for (int i = 0 ; i < lasPatas.size() ; i++) {
      brazo  pata = lasPatas.get(i);

      if ((i==0)|| (i==3) || (i==4)) {
        desfase=PI;
      }
      else {
        desfase =0;
      }
      pata.calcularxy(40, amp*cos((t*w)+desfase), amp*sin((t*w)+desfase) - 20, 0);
    }
    saveAng();
  }
  // ROTACION HACIA LA DERECHA 
  void rotarD() {
    float t = millis()%periodo;
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
        pata.calcularxy(40, amp*sin((t*w)+desfase), amp*cos((t*w)+desfase) - 20, 0);
      }
      else {
        pata.calcularxy(40, amp*cos((t*w)+desfase), amp*sin((t*w)+desfase) - 20, 0);
      }
    }
    saveAng();
  }
  // ROTACION HACIA LA IZQUIERDA

  void rotarI() {
    float t = millis()%periodo;
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
        pata.calcularxy(40, amp*cos((t*w)+desfase), amp*sin((t*w)+desfase) - 20, 0);
      }
      else {
        pata.calcularxy(40, amp*sin((t*w)+desfase), amp*cos((t*w)+desfase) - 20, 0);
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

