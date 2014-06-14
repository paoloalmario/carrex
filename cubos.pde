/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                  Definición del objeto cubo                   ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////


class Cubos {
  
  
  //************ --   propiedades del cubo
  
  //posicion X - Y dentro de la matriz
  int posX,
      posY,
      posZ;
  
  //ancho alto y fondo del cubo
  float ancho,
        alto,
        fondo;
   
  //desplazamiento del punto de origen, relativo al ancho, alto y fondo para hacer los objetos visibles
  float displaceX,
        displaceY,
        displaceZ;
        
  color fill_color,
        stroke_color;
  
  int opacity,
      stroke_weight;
      
  boolean bool_stroke,
          bool_fill;
  
  //************  --  Constructor
  
  // Cubos( ancho, alto, fondo, posX, posY, posZ, fillColor, opacity, strokeColor, strokeWeight, stroke?, fill? )
  Cubos(float a, float al, float fon, int px, int py, int pz, color fi, int op, color st, int sw, boolean stB, boolean fB) {
  
    ancho = a;
    alto = al;
    fondo = fon;
    
    posX = px;
    posY = py;
    posZ = pz;
    
    fill_color = fi;
    opacity = op;
    
    stroke_color = st;
    stroke_weight = sw;
    
    bool_stroke = stB;
    bool_fill = fB; 
    
  }

  //************  --  Metodo dibujar -- Cada cubo se dibuja en su posición dentro de la matriz

  void dibujar(){
    
    //set colors
    strokeWeight( stroke_weight );
    stroke( stroke_color );
    fill( fill_color, opacity );
    
    
    if( bool_stroke == true ){
      noStroke();
    }
    
    if( bool_fill == true ){
      noFill();
    }
    
    //guardar la posición del punto de origen
    pushMatrix();
    
      //desplazar el punto de origen para crear cada cubo
      translate( displaceX + ( ancho * posX ), displaceY + ( alto * posY ), displaceZ - ( posZ * fondo));
      //crear el cubo      
      box( ancho, alto, fondo);
      
    //reposicionar la posición del punto de origen
    popMatrix();
    
  }
}//-------              fin de la clase Cubo

