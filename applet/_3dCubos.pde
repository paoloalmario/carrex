/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////  Cubos 3D dependiendo del ancho y del alto de la imagen       ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////  Paolo Almario /////////////////////////  13 Marzo 2012       ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

import SimpleOpenNI.*; //libreria kinect
import processing.opengl.*;

//-------------------------------------     Variables editables       ---------------------------------//


float ancho = 768.0, 
      alto = 1200.0;  //ancho y alto de la imagen final
    
int divHor = 3, 
    divVert = 1, //cantidad de cuadrados en la horizontal y en la vertical
    marginLeft = 566,
    velCubos = 2; 
    
int toggleStroke = 0,
    toggleImageAnimation = 0,//los cubos se animarán de acuerdo a los valores de profundidad capturados por el kinect
    toggleActivation = 0,
    keyPre = 0,
    keyPre2 = 0,
    keyPre3 = 0,
    keyPre4 = 0, 
    keyPre5 = 0,
    strokeVal = 255,
    factorPixels = 12,
    colorCubo,
    mediaTotal,
    rangoAlto = 73,
    rangoBajo = 60,
    activeOnce = 0;
    
PFont font, fontBold;
     

int[] toggler = new int[2000];

//-------------------------------------     Variables Array           ---------------------------------//


float widthCubos,heightCubos;

int fondo = 2500;

Cubo[][] cubos;


//-------------------------------------     variables    kinect          ---------------------------------//

SimpleOpenNI  context;
pixelsKinect kPixels;
int setupOnce = 0;

//-------------------------------------       Función setup           ---------------------------------//

void setup() {
  
  //--  caracteristicas generales del dibujo
  
  size(int(ancho)+1152, int(alto), P3D); //full Screen
  //size(int(ancho), int(alto), P3D); //sin el kinect
  strokeWeight(2);
  
  
  //--  inicializo todas las variables
  
  widthCubos = ancho/divHor;               //ancho de cada cubo
  heightCubos = alto/divVert;              //alto de cada cubo
  
  font = loadFont("aurora.vlw");
  fontBold = loadFont("auroraBold.vlw");
  
  
  cubos = new Cubo[divHor][divVert];       //inicializo el array con las dimensiones
  
  if(setupOnce == 0){
    context = new SimpleOpenNI(this);        //constructor del objeto kinect
    kPixels = new pixelsKinect();
    context.enableDepth(640,480,12);
    setupOnce = 1;
  }
  
  
  context.setMirror(true);                 //mirror enabled
  
  llenarArray();                           //lleno el array con un cubo en cada posicion
  kPixels.update();
}


//-------------------------------------       Función draw           ---------------------------------//

void draw() {

    //--  Variables locales
    
    int i = 0,
        j = 0;
    
    //-- Caracteristicas generales del dibujo
    
    lights();                               //enciendo las luces del ambiente 3d
    background(255);                        //fondo
    //stroke(strokeVal);                      //color de línea, con propositos de monitoreo
    
    
     // update the cam
    context.update();
    //draw the cam image
    image(context.depthImage(),ancho+marginLeft+10,0);
    
    
    //Frame the captured image
    noStroke();
    fill(255);
    rect(ancho+marginLeft+10,0,(640.0/3),alto);
    rect(ancho+marginLeft+10+((640.0/3)*2),0,(640/3)-1,alto);
    
    
    
    //-- Cada cubo se dibuja cuando se llama el método dibujar()
    stroke(strokeVal); 
    
    while(i<divHor)
    {
      j=0;
      while(j<divVert)
      {
        cubos[i][j].dibujar();
        j++;
      }
      i++;
    }
    
    fill(255);
    
    //--  Consola
    
    dibujarConsola();
    
    //-- Manejo del teclado
    teclado();
   
   //-- Calcula la media de toda la pantalla
   
   kPixels.fillArray();
   kPixels.media();
   
   //-- activa la animacion del kinect si la media está por fuera de los valores normales
   
   animarMedia();
}


//-------------------------------------     Función llenarArray()    ---------------------------------//

void llenarArray(){

  int i = 0;
  int j = 0;
   
  while(i<divHor){
    
    j = 0;
    while(j<divVert){
        cubos[i][j] = new Cubo(widthCubos, heightCubos, fondo, i, j);
        j++;
    }
    i++;
  }

}

//-------------------------------------     Función dibujarConsola()    ---------------------------------//


void dibujarConsola(){
 
  float margen = ancho+marginLeft+10 + 640/3,
        margen2 = ancho+marginLeft+10 + (640/3)*1.5;
        
  fill(0);
  
  textFont(fontBold);
  textSize(12);
  text("Animación : ",margen,670);
  text("CubosX : ",margen,700);
  text("CubosY : ",margen,720);
  text("Vel. Cubos : ",margen,750);
  text("Factor Pixel : ",margen,780);
  text("Color cubo : ",margen,850);
  text("Media Total : ",margen,880);
  text("rangoAlto : ",margen+15,900);
  text("rangoBajo : ",margen+15,920);
  
  textFont(fontBold);
  textSize(12);
  if(toggleImageAnimation == 1){
    fill(0,255,0);
    text("On",margen2,670);
  }else{
    fill(255,0,0);
    text("Off",margen2,670);
  }
  
  
  
  fill(0);
  textFont(font);
  textSize(12);
  text(divHor,margen2,700);
  text(divVert,margen2,720);
  text(velCubos,margen2,750);
  text(factorPixels,margen2,780);
  text(colorCubo,margen2,850);
  text(mediaTotal,margen2,880);
  text(rangoAlto,margen2,900);
  text(rangoBajo,margen2,920);
  
  textSize(10);
  text("(A)",margen2+80,670);
  text("(H - K)",margen2+80,700);
  text("(U - J)",margen2+80,720);
  text("(R - F)",margen2+80,750);
  text("(T - G)",margen2+80,780);
  text("(Z - X)",margen2+80,900);
  text("(C - V)",margen2+80,920);
  
  
  fill(255);
}

void animarMedia(){
  
  if(mediaTotal > rangoAlto || mediaTotal < rangoBajo){
    if(activeOnce == 0){
      toggleActivation = 1;
      strokeVal = 200;
      activeOnce = 1;
      divHor = int(random(1,20));
      println("hhhh random "+divHor);
      setup();
    }
  }
  else{
    if(activeOnce == 1){
      toggleActivation = 0;
      strokeVal = 255;
      activeOnce = 0;
    }
  }

}
