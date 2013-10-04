class Timer {
  int tiempoDeInicio;
  boolean started = false;



  Timer() {
  }

  void start() {
    tiempoDeInicio = millis();
    started = true;
  }

  boolean temporizador(float td) {

    if (started == false) {
      start();
    }

    if ( tiempo() >=td) {
      restart();
      return(true);
    }
    else {
      return(false);
    }
  }


  int tiempo() {

    if (started) {
      return(millis() - tiempoDeInicio);
    }
    else {
      return(0);
    }
  }

  void restart() {
    started = true;
    start();
  }
}

