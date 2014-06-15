/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                 Carrex - Clase de cubos 3D                    ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////  Paolo Almario /////////////////////////   10 Marzo 2013      ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Last update 14 June 2014

/*

  Este Sketch realiza varias tareas:
  
  // up to date // 1.1 La matriz es creada dejando el punto de origen (0,0,0) en la mitad. (el constructuor de la clase cubo recibe 3 parametros de desplazamiento del punto de origen, es aqui que se hace se establece que la matriz se creará conservando el punto 0,0,0 en la mitad)
  
  // up to date // 2. Desplaza la cámara para que el punto central (0,0,0) esté en la mitad de lo que ve
  
  CONSIDERAR: cada cubo creado es un objeto de la clase Cubos. Cada objeto tiene el método de dibujarse a 
  sí mismo de acuerdo a su posición en la matriz.

*/


//-----------------------------------   IMPORTAR LIBRERIAS  


//-----------------------------------   VARIABLES EDITABLES


float root_ancho = 500.0, //ancho del sketch
      root_alto = 500.0;  //alto del sketch
      
      
matrix2D Matrix = new matrix2D( 10,    // horizontal divisions 
                                10,    // vertical divisions
                                30,    // cubes width
                                30,    // cubes height
                                50,    // cubes fond
                                0,     // x displacement
                                0,     // y displacement
                                0); // z displacement

float test = 0,
      test2 = 0;



//-------------------------------------- SETUP METHOD


void setup() {
  //ancho, alto y motor3D
  size( int( root_ancho ), int( root_alto ), OPENGL ); 
  
  //definición de la perspectiva
  perspective( radians( 60 ),
               float( width ) / float( height ),
               10, 150000 );
  //suavecito :)
  smooth();
  
  //setup de la camara
  beginCamera();
    //centrar el punto 0,0,0 en lo que ve la cámara
    translate( root_ancho / 2, root_alto / 2, 0);//-2598*3);
   
  endCamera();
}


//-------------------------------------       Función draw           ---------------------------------//

void draw() {
  
 //en las funciones movimiento_camara se alteran las variables cam_moveX y cam_moveY que oscilarán entre 100 y -100
 lights();
 
 //movimiento_camara_mouse(); //la cámara se mueve de acuerdo a la posición del mouse
 //movimiento_camara_kinect(); //la cámara se mueve de acuerdo a la posición del objeto captado por el kinect
 
  background(#000000);
  
  Matrix.dibujar();
  
}

