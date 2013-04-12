class pixelsKinect {
  
  
  // -- Variables locales
  
 int[][] pos;
 int anchoK = 213,
     altoK = 480,
     posXK = int(ancho)+marginLeft+10+640/3,
     posYK = 0;
  //  --  Constructor
  
  pixelsKinect() {
   
  }

  //  --  MÉTODO UPDATE
  
  void update() { 
    pos = new int[divHor][divVert];
    this.fillArray();
  }
  
  
  //  --  MÉTODO PINTARROJO
  
  void pintarRojo(int x, int y){
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
  
  //  --  MÉTODO GETCOLOR
  
  int getColor(int x, int y){
    
     int puntoIX = ((anchoK/divHor)*x),
        puntoIY = ((altoK/divVert)*y),
        cantPixels = ((anchoK / divHor)*(altoK / divVert)),
        i = 0,
        j = 0,
        rojo = 0,
        contador = 0,
        verde = 0,
        azul = 0;
        
     color elColor;
     
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
  
 void fillArray(){
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

  //  --  MÉTODO MEDIA TOTAL
  
  void media(){
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
    
    mediaTotal = int(acumulador / contador);
  }
  
}
  
