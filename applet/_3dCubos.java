import processing.core.*; 
import processing.xml.*; 

import SimpleOpenNI.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class _3dCubos extends PApplet {

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////  Cubos 3D dependiendo del ancho y del alto de la imagen       ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////  Paolo Almario /////////////////////////  13 Marzo 2012       ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

 //libreria kinect


//-------------------------------------     Variables editables       ---------------------------------//


float ancho = 768.0f, 
      alto = 1200.0f;  //ancho y alto de la imagen final
    
int divHor = 3, 
    divVert = 1, //cantidad de cuadrados en la horizontal y en la vertical
    marginLeft = 566,
    velCubos = 2; 
    
int toggleStroke = 0,
    toggleImageAnimation = 0,//los cubos se animar\u00e1n de acuerdo a los valores de profundidad capturados por el kinect
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

//-------------------------------------       Funci\u00f3n setup           ---------------------------------//

public void setup() {
  
  //--  caracteristicas generales del dibujo
  
  size(PApplet.parseInt(ancho)+1152, PApplet.parseInt(alto), P3D); //full Screen
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


//-------------------------------------       Funci\u00f3n draw           ---------------------------------//

public void draw() {

    //--  Variables locales
    
    int i = 0,
        j = 0;
    
    //-- Caracteristicas generales del dibujo
    
    lights();                               //enciendo las luces del ambiente 3d
    background(255);                        //fondo
    //stroke(strokeVal);                      //color de l\u00ednea, con propositos de monitoreo
    
    
     // update the cam
    context.update();
    //draw the cam image
    image(context.depthImage(),ancho+marginLeft+10,0);
    
    
    //Frame the captured image
    noStroke();
    fill(255);
    rect(ancho+marginLeft+10,0,(640.0f/3),alto);
    rect(ancho+marginLeft+10+((640.0f/3)*2),0,(640/3)-1,alto);
    
    
    
    //-- Cada cubo se dibuja cuando se llama el m\u00e9todo dibujar()
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
   
   //-- activa la animacion del kinect si la media est\u00e1 por fuera de los valores normales
   
   animarMedia();
}


//-------------------------------------     Funci\u00f3n llenarArray()    ---------------------------------//

public void llenarArray(){

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

//-------------------------------------     Funci\u00f3n dibujarConsola()    ---------------------------------//


public void dibujarConsola(){
 
  float margen = ancho+marginLeft+10 + 640/3,
        margen2 = ancho+marginLeft+10 + (640/3)*1.5f;
        
  fill(0);
  
  textFont(fontBold);
  textSize(12);
  text("Animaci\u00f3n : ",margen,670);
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

public void animarMedia(){
  
  if(mediaTotal > rangoAlto || mediaTotal < rangoBajo){
    if(activeOnce == 0){
      toggleActivation = 1;
      strokeVal = 200;
      activeOnce = 1;
      divHor = PApplet.parseInt(random(1,20));
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                  Definici\u00f3n del objeto cubo                   ////////////////////
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
  
  int posFondoF = -2000, //m\u00e1ximo de distancia que se alejar\u00e1n los cubos
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

  //  --  M\u00c9TODO DIBUJAR  -- Cada cubo se dibuja en su posici\u00f3n dentro de la matriz
  
  public void dibujar() { 
    
    pushMatrix(); //  Guardo la posici\u00f3n del punto de origen
      
      translate((ancho/2)+(ancho*posX)+marginLeft,alto/2+alto*posY,trasFondo);  // se desplaza el punto de origen al sitio donde se crea el cubo
      fill(colorFill);
      box(ancho,alto,fondo);
      
    popMatrix();  //  Reinstauro la posici\u00f3n del punto de origen
    
    //  --  Animaci\u00f3n
    
    trasFondo += (posFF - trasFondo)/velCubos; // Ecuaci\u00f3n de animaci\u00f3n del cubo en la posici\u00f3n Z (fondo)
    //*******  Mas ecuaciones de movimiento
    
    mouseM();
  }
  
  
  //  --  M\u00c9TODO MOUSEM  -- Detecta si el cursor est\u00e1 sobre uno de los cubos y lo env\u00eda al fondo
  
  public void mouseM(){
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
            float porcentaje = 1-(kPixels.pos[posX][posY] / 255.0f);
            println("["+posX+"]["+posY+"] = "+kPixels.pos[posX][posY]/255.0f);
            posFF = trasFondoBU + PApplet.parseInt(posFF*porcentaje);
          }else{
            posFF = trasFondoBU;
          }//---------  fin if
        }
        colorFill += (255-colorFill)/2;
      }//-----------    fin else
      
  }//-------            fin del m\u00e9todo mouseM
  
}//-------              fin de la clase Cubo
class pixelsKinect {
  
  
  // -- Variables locales
  
 int[][] pos;
 int anchoK = 213,
     altoK = 480,
     posXK = PApplet.parseInt(ancho)+marginLeft+10+640/3,
     posYK = 0;
  //  --  Constructor
  
  pixelsKinect() {
   
  }

  //  --  M\u00c9TODO UPDATE
  
  public void update() { 
    pos = new int[divHor][divVert];
    this.fillArray();
  }
  
  
  //  --  M\u00c9TODO PINTARROJO
  
  public void pintarRojo(int x, int y){
    int puntoIX = ((anchoK/divHor)*x),
        puntoIY = ((altoK/divVert)*y),
        i = 0,
        j = 0;  
    
    //println("["+x+"]["+y+"]");
    //println(puntoIX);
    loadPixels();
    
    while(i < anchoK / divHor){
      j = 0;
      while(j < altoK / divVert){ 
        pixels[((puntoIY+j)+posYK)*width + ((puntoIX+i)+posXK)] = color(255,0,0);
        j += factorPixels;
      }
      i += factorPixels;
    }
    
    updatePixels();
  }
  
  //  --  M\u00c9TODO GETCOLOR
  
  public int getColor(int x, int y){
    
     int puntoIX = ((anchoK/divHor)*x),
        puntoIY = ((altoK/divVert)*y),
        cantPixels = ((anchoK / divHor)*(altoK / divVert)),
        i = 0,
        j = 0,
        rojo = 0,
        contador = 0,
        verde = 0,
        azul = 0;
        
     int elColor;
     
    loadPixels();
    while(i < anchoK / divHor){
      j = 0;
      while(j < altoK / divVert){ 
        elColor = pixels[((puntoIY+j)+posYK)*width + ((puntoIX+i)+posXK)];
        rojo += (elColor >> 16) & 0xFF;
        contador ++;
        //verde += (elColor >> 8) & 0xFF;
        //azul += elColor & 0xFF;
        j += factorPixels;
      }
      i += factorPixels;
    }
    updatePixels();
   
   
   rojo /= contador;
   
  // println(rojo);
   return rojo;
  }
  
 public void fillArray(){
    int i = 0,
        j = 0;
        
    while(i<divHor){
      j = 0;
      while(j<divVert){
        pos[i][j] = getColor(i,j);
        j++;
      }
      i++;
    }
  }

  //  --  M\u00c9TODO MEDIA TOTAL
  
  public void media(){
    int i = 0;
    int j = 0;
    int acumulador=0;
    int contador = 0;
    
    while(i<divHor){
      j = 0;
      while(j<divVert){
        acumulador += pos[i][j];
        contador++;
        j++;
      }
      i++;
    }
    
    mediaTotal = PApplet.parseInt(acumulador / contador);
  }
  
}
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                  Acciones de monitoreo con el teclado                   ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////


public void teclado(){ //funci\u00f3n que es llamada desde draw()
  keyPress('s',1); //verifica si la tecla indicada es presionada y ejecuta la acci\u00f3n del segundo parametro
  keyPress('h',2); //menos cubos en el eje X
  keyPress('k',3); //m\u00e1s cubos en el eje X
  keyPress('j',4); //menos cubos en el eje Y
  keyPress('u',5); //mas cubos en el eje Y
  keyPress('a',6); //activa sincronizacion con kinect
  keyPress('r',7); //mayor velocidad cubos
  keyPress('f',8); //menor velocidad cubos
  keyPress('t',9); //mayor factor pixel
  keyPress('g',10); //menor factor pixel
  keyPress('z',11); //menor rangoAlto
  keyPress('x',12); //mayor rangoAlto
  keyPress('c',13); //menor rangoAlto
  keyPress('v',14); //mayor rangoAlto
}


public void keyPress(char letra,int accion){
  
  if(keyPressed && key==letra){
    if(toggler[accion]==0){
      println("pressed");
      toggler[accion] = 1;
      this.accionesTeclado(accion);
    }
  }else{
    toggler[accion] = 0;
  }
}


public void accionesTeclado(int ac){
  
  switch(ac) {
    
    //toggle stroke
    case 1: 
      if(toggleStroke==0){
        strokeVal = 200;
        toggleStroke = 1;
      }else{    
        strokeVal = 255;
        toggleStroke = 0;
      }
      break;
      
    //reduce divisions to the horizontal plane
    case 2: 
      divHor-=2;
       if(divHor<=0)
       {divHor=1;}
       setup();
      break;
      
    //add divisions to the horizontal plane
    case 3: 
       divHor+=2;
       setup();
      break;
      
    //reduce divisions to the vertical plane
    case 4: 
      divVert-=2;
       if(divVert<=0)
       {divVert=1;}
       setup();
      break;
      
    //add divisions to the vertical plane
    case 5: 
       divVert+=2;
       setup();
      break;
      
    //add divisions to the vertical plane
    case 6: 
       if(toggleImageAnimation == 0){
         toggleImageAnimation = 1;
       }else{
         toggleImageAnimation = 0;
       }
       setup();
      break;
      
    //menor velocidad cubos
    case 7: 
       velCubos--;
       if(velCubos<=2){
         velCubos = 2;
       }
      break;
      
    //mayor velocidad cubos
    case 8: 
       velCubos++;
      break;
      
    //menor factor pixel
    case 9: 
       if(factorPixels<=1){
         velCubos = 1;
       }else{
         factorPixels--;
       }
      break;
      
    //mayor factor pixel
    case 10: 
       factorPixels++;
      break;
      
    //menor rangoAlto
    case 11: 
       if(rangoAlto>rangoBajo+1){
              rangoAlto--;
       }
      break;
    //mayor rangoAlto
    case 12: 
              rangoAlto++;
      break;
      
      //menor rangoBajo
    case 13: 
              rangoBajo--;
      break;
    //mayor rangoBajo
    case 14: 
       if(rangoBajo<rangoAlto-1){
              rangoBajo++;
       }
      break;
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "_3dCubos" });
  }
}
