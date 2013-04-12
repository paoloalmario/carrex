/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                 Matrix - Clase de cubos 3D                    ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////  Paolo Almario /////////////////////////   10 Marzo 2013      ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

/*

  Este Sketch realiza varias tareas:
  
  
  1. Crea una matriz de 50x50x1 (X, Y, Z) cubos3D de dimensiones 50x50x50 pixeles.
  
  1.1 La matriz es creada dejando el punto de origen (0,0,0) en la mitad. (el constructuor de la clase cubo recibe 3 parametros de desplazamiento del punto de origen, es aqui que se hace se establece que la matriz se creará conservando el punto 0,0,0 en la mitad)
  
  2. Desplaza la cámara para que el punto central (0,0,0) esté en la mitad de lo que ve
  
  3. Recibe una señal OSC proveniente de KinectA. El mensaje corresponde a un solo objeto y se deben recibir
     4 de sus propiedades: ID, posX, posY, posZ.
  
  4. La cámara se desplazará en sus ejes X y Y de acuerdo a la información recibida del mensaje OSC o de la 
     posición del mouse ( test purposes ).
  
  CONSIDERAR: cada cubo creado es un objeto de la clase Cubos. Cada objeto tiene el método de dibujarse a 
  sí mismo de acuerdo a su posición en la matriz.

*/

/*

A DESARROLLAR:


- movimiento con Kinect
- conexión OSC

- modo "edicion" con numeros en cada cubo para saber cual es
- codigos de color

*/


//-----------------------------------   IMPORTAR LIBRERIAS  

import oscP5.*;


//-----------------------------------   VARIABLES EDITABLES


float root_ancho = 1344.0,    //ancho del sketch
      root_alto = 1008.0;     //alto del sketch

int   root_div_x = 50,      //dimensión horizontal de la matriz de cubos
      root_div_y = 50,       //dimensión vertical de la matriz de cubos
      root_div_z = 1;      //dimensión vertical de la matriz de cubos



Cubos[][][] matriz_cubos;       //array de la clase cubo

int cubo_ancho = 50,          //ancho de cada cubo (sigh) 
    cubo_alto = 50,           //alto de cada cubo  (sigh)
    cubo_fondo = 50;          //fondo de cada cubo (sigh)
    

color    cubo_fill = #ffffff,    //color de los cubos
         cubo_stroke = #ff0000;  //color del borde de los cubos
boolean  cubo_noStroke = false,  //set to true to activate noStroke();
         cubo_noFill = false;
int      cubo_stroke_weight = 2, //espesor del borde de los cubos
         cubo_opacity = 255;     //opacidad del cubo


int map_top = 40; //utilizado en movimiento_camara



//-------------------------------------- VARIABLES NO EDITABLES

int matriz_ancho = cubo_ancho * root_div_x,    //ancho total de la matriz de cubos
    matriz_alto = cubo_alto * root_div_y,      //alto total de la matriz de cubos
    matriz_fondo = cubo_fondo * root_div_z;    //fondo total de la matriz de cubos

int cam_moveX = 0,           //cantidad que se desplaza la cámara en el ejeX
    cam_moveY = 0,           //cantidad que se desplaza la cámara en el ejeY
    cam_moveX_count = 0,     //contador de cuánto se ha desplazado la cámara en el ejeX
    cam_moveY_count = 0;     //contador de cuánto se ha desplazado la cámara en el ejeY
    
float  cam_limitX = (root_ancho / 2) + matriz_ancho/2 - cubo_ancho, //limite de desplazamiento en la horizontal
       cam_limitY = (root_alto / 2) + matriz_alto/2 - cubo_alto;    //limite de desplazamiento en la vertical



//OSC variables

OscP5 oscP5;

int puerto = 3333;

float[] objeto = new float[4];

String lastAddress = "";



//-------------------------------------- SETUP METHOD


void setup() {
  
  //ancho, alto y motor3D
  size( int( root_ancho ), int( root_alto ), P3D ); 
  
  //definición de la perspectiva
  perspective( radians( 60 ),
               float( width ) / float( height ),
               10, 150000 );
  
  //suavecito :)
  smooth();
  
  //declaro las dimensiones del array matriz_cubos
  matriz_cubos = new Cubos[ root_div_x ][ root_div_y ][ root_div_z ];
  
  
  /*
    lleno el array con objetos Cubos
    sintaxis : matriz_cubos_setup( displaceX, displaceY, displaceZ )
  */
  matriz_cubos_setup( -matriz_ancho/2 + cubo_ancho/2, -matriz_alto/2 + cubo_alto/2, -cubo_fondo/2);
  
  
  //inicio la comunicación OSC en el puerto seleccionado
  oscP5 = new OscP5(this, puerto);
  
  //setup de la camara
  beginCamera();
    //centrar el punto 0,0,0 en lo que ve la cámara
    translate( root_ancho / 2, root_alto / 2, 0);
  endCamera();
}


//-------------------------------------       Función draw           ---------------------------------//

void draw() {
  
 //en las funciones movimiento_camara se alteran las variables cam_moveX y cam_moveY que oscilarán entre 100 y -100
 lights();
 movimiento_camara_mouse(); //la cámara se mueve de acuerdo a la posición del mouse
 //movimiento_camara_kinect(); //la cámara se mueve de acuerdo a la posición del objeto captado por el kinect
 //println( mouseX );
 
 //desplazar la cámara 
  beginCamera();
    //desplazar en X y en Y
    translate(cam_moveX, cam_moveY, 0);
    //contadores de cuánto se ha desplazado la cámara
    cam_moveX_count += cam_moveX;
    cam_moveY_count += cam_moveY;
  endCamera();
  
  background(#000000);
  
  //Dibujar todos los cubos
  matriz_cubos_dibujar();
  
}

