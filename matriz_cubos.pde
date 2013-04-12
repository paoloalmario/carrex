/**
* funcion matriz_cubos_setup() - llamada en matrix.pde
* 
* llena el array matriz_cubos[][][] con objetos de la clase Cubos, usando su constructor
**/

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


/**
* funcion matriz_cubos_dibujar()
* 
* llama el metodo dibujar() de cada cubo en el array matriz_cubos
**/

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

