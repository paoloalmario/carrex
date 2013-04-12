/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                  Definición del objeto cubo                   ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////


class Cubo {
  
  
  // -- Variables locales
  
  int fondo,
      posX, 
      posY, 
      trasFondo,
      trasFondoBU;
      
  float ancho,
        alto;
  
  int posFondoF = -2000, //máximo de distancia que se alejarán los cubos
      colorFill = 255;
  
  int posFF = posFondoF;
  
  //  --  Constructor
  
  Cubo(float a, float al, int fo, int px, int py) {
    ancho = a;
    alto = al;
    fondo = fo;
    trasFondo = -fondo/2;
    trasFondoBU = trasFondo;
    posX = px;
    posY = py;
  }

  //  --  MÉTODO DIBUJAR  -- Cada cubo se dibuja en su posición dentro de la matriz
  
  void dibujar() { 
    
    pushMatrix(); //  Guardo la posición del punto de origen
      
      translate((ancho/2)+(ancho*posX)+marginLeft,alto/2+alto*posY,trasFondo);  // se desplaza el punto de origen al sitio donde se crea el cubo
      fill(colorFill);
      box(ancho,alto,fondo);
      
    popMatrix();  //  Reinstauro la posición del punto de origen
    
    //  --  Animación
    
    trasFondo += (posFF - trasFondo)/velCubos; // Ecuación de animación del cubo en la posición Z (fondo)
    //*******  Mas ecuaciones de movimiento
    
    mouseM();
  }
  
  
  //  --  MÉTODO MOUSEM  -- Detecta si el cursor está sobre uno de los cubos y lo envía al fondo
  
  void mouseM(){
      if(mouseX>(widthCubos*posX)+marginLeft && mouseX<(widthCubos*(posX+1))+marginLeft && mouseY>heightCubos*posY && mouseY<heightCubos*(posY+1)){
        posFF = posFondoF;
        colorFill += (100-colorFill)/10;
        
        kPixels.fillArray();
         
        println(kPixels.pos[posX][posY]);
        colorCubo = kPixels.pos[posX][posY];
        //println(kPixels.getColor(posX,posY));
        kPixels.pintarRojo(posX,posY);
        
      }else{
        if(toggleImageAnimation == 0){
          posFF = trasFondoBU;              // monitor tests
        }else{          // kinect animation
          if(toggleActivation == 1){
            kPixels.fillArray();
            float porcentaje = 1-(kPixels.pos[posX][posY] / 255.0);
            println("["+posX+"]["+posY+"] = "+kPixels.pos[posX][posY]/255.0);
            posFF = trasFondoBU + int(posFF*porcentaje);
          }else{
            posFF = trasFondoBU;
          }//---------  fin if
        }
        colorFill += (255-colorFill)/2;
      }//-----------    fin else
      
  }//-------            fin del método mouseM
  
}//-------              fin de la clase Cubo
