
// 2D Matrix Object

class  matrix2D{
  
   //////////////////////////////////////
   //////////   PROPERTIES  /////////////
   //////////////////////////////////////
  
   // empty 2DCubos matrix
   Cubos[][] cubos_matrix;
   
   /////////////////////////////
   /// every cube properties ///
   /////////////////////////////
   
   // --- Dimensions
  
   int    cube_width = 10,
          cube_height = 10,
          cube_fond = 10;

   // --- Appereance
  
   color  cube_fill = #ffffff,    //color de los cubos
          cube_stroke = #aaaaaa;  //color del borde de los cubos
         
   int    cube_stroke_weight = 1, //espesor del borde de los cubos
          cube_opacity = 255;     //opacidad del cubo
  
   // --- Booleans
   
   boolean  cube_noStroke = false,  //set to true to activate noStroke();
            cube_noFill = false;
           
   /////////////////////////////
   ///// matrix properties /////
   /////////////////////////////
    
   int   x_divs = 10,     // horizontal divisions
         y_divs = 10,     // vertical divisions
     
         matrix_width, 
         matrix_height,  
         matrix_fond,
       
         x_displace = 0,
         y_displace = 0,
         z_displace = 0;
   
  //////////////////////////////////////
  /////////  CONSTRUCTORS  /////////////
  //////////////////////////////////////
  
  // ---- Constructor #1
  
  matrix2D( int x_divisions, int y_divisions, int c_width, int c_height, int c_fond, int displaceX, int displaceY, int displaceZ ){
    
    // set horizontal and vertical divisions
    x_divs = x_divisions;
    y_divs = y_divisions;
    
    // set single cube properties
    cube_width = c_width;
    cube_height = c_height;
    cube_fond = c_fond;
    
    // displacements
    x_displace = displaceX;
    y_displace = displaceY;
    z_displace = displaceZ;
    
    // Methods
    set_matrix_properties();
   
    calculate_center_displacements();
    
    fill_matrix_with_Cubos();
  }
  
  // ---- Constructor #2
  matrix2D(){
      
    // set matrix properties - method
    set_matrix_properties(); 
   
    calculate_center_displacements();
    
    fill_matrix_with_Cubos(); 
  }

  
  //////////////////////////////////////
  //////////    METHODS    /////////////
  ////////////////////////////////////// 
  
  void set_matrix_properties(){
    
       matrix_width = x_divs * cube_width; 
       matrix_height = y_divs * cube_height;  
       matrix_fond = cube_fond;
       
       cubos_matrix = new Cubos [ x_divs ][ y_divs ];
    
  }
  
  // displacements calculated to center the grid in the screen
  void calculate_center_displacements(){
    
    x_displace = cube_width/2 - matrix_width/2;
    y_displace = cube_height/2 - matrix_height/2;
    
    
  }
  
  void fill_matrix_with_Cubos(){
    
    int i = 0,
        j = 0;
        
    while( i < x_divs ){
      
      j = 0;
      
      while( j < y_divs){
        // usage of the Cubos constructor : Cubos( ancho, alto, fondo, posX, posY, posZ, fillColor, opacity, strokeColor, strokeWeight, stroke?, fill? )
        cubos_matrix[i][j] = new Cubos( cube_width, cube_height, cube_fond, i, j, 0, cube_fill, cube_opacity, cube_stroke, cube_stroke_weight, cube_noStroke, cube_noFill );
        // si hay algun desplazamiento inicial aplicable a los cubos, se asigna aquí
        // desplazamiento para X
        if( x_displace != 0){
          cubos_matrix[i][j].displaceX = x_displace;
        }
        // desplazamiento para Y
        if( y_displace != 0){
          cubos_matrix[i][j].displaceY = y_displace;
        }
        
        z_displace = int( random( 50 ) ); // this gives a static cool effect
        // desplazamiento para Y
        if( z_displace != 0){
          cubos_matrix[i][j].displaceZ = z_displace;
        }
        
        j++;
      }
      i++;
    }
    
  }
  
  void dibujar(){
    
    int i = 0,
        j = 0;
        
    while( i < x_divs ){
      
      j = 0;
      
      while( j < y_divs){
        //cubos_matrix[i][j].displaceZ = random(10); // cool effect animated
        cubos_matrix[i][j].dibujar();
        
        j++;
      }
      
      i++;
    }
    
  }
}



/**
* funcion matriz_cubos_setup() - llamada en matrix.pde
* 
* llena el array matriz_cubos[][][] con objetos de la clase Cubos, usando su constructor
**/

/*
void matriz_cubos_setup( float displaceX, float displaceY, float displaceZ ){
  
  //contadores locales
  int i = 0,
      j = 0,
      k = 0;
  
  //loop triple para llenar el array de tres dimensiones
  while ( i < root_div_x){
    j = 0;
    while(j < root_div_y){
      k = 0;
      while( k < root_div_z){
        // usage of the Cubos constructor : Cubos( ancho, alto, fondo, posX, posY, posZ, fillColor, opacity, strokeColor, strokeWeight, stroke?, fill? )
        matriz_cubos[i][j][k] = new Cubos( cubo_ancho , cubo_alto , cubo_fondo, i, j, k, cubo_fill, cubo_opacity, cubo_stroke, cubo_stroke_weight, cubo_noStroke, cubo_noFill);
        
        // si hay algun desplazamiento inicial aplicable a los cubos, se asigna aquí
        // desplazamiento para X
        if( displaceX != 0){
          matriz_cubos[i][j][k].displaceX = displaceX;
        }
        // desplazamiento para X
        if( displaceY != 0){
          matriz_cubos[i][j][k].displaceY = displaceY;
        }
        // desplazamiento para X
        if( displaceZ != 0){
          matriz_cubos[i][j][k].displaceZ = displaceZ;
        }
        
        k++;
      }
      j++;
    }
    i++;
  }
  
}
*/

/**
* funcion matriz_cubos_dibujar()
* 
* llama el metodo dibujar() de cada cubo en el array matriz_cubos
**/

/*
void matriz_cubos_dibujar(){
  
  int i = 0,
      j = 0,
      k = 0;
  
  //loop triple para llamar el método dibujar() de cada cubo
    while ( i < root_div_x){
      j = 0;
      while(j < root_div_y){ 
        k = 0;
        while( k < root_div_z){
          matriz_cubos[i][j][k].dibujar();
          k++;
        }
        j++;
      }
      i++;
    }

}
*/

