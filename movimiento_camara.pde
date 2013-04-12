//funcion movimiento_camara_mouse
//
// modificara las variables cam_moveX y moveY de acuerdo a la posición del ratón en la pantalla
// - en el eje horizontal la variable cam_moveX oscila entre -100 y 100
// - en el eje vertical la variable moveY oscila entre -100 y 100

void movimiento_camara_mouse() {

  float mapX = 0,// map de la posicion del mouse en X
        mapY = 0;// map de la posicion del mouse en Y
  
  
  
  //si el mouse en la horizontal está en la segunda mitad del dibujo
  if( mouseX > root_ancho / 2){
    
    //mapear la posicion
    mapX = map( mouseX, root_ancho/2, root_ancho, 0, -map_top);
    
    //si el contador de desplazamiento de la cámara no ha depasado el límite
    if( cam_moveX_count > -cam_limitX){
      
      // mover la cámara en X la cantidad mapeada
      cam_moveX = int(mapX);
      
    }else{
      //no mover la cámara
      cam_moveX = 0;
    }
    
  }else{//si el mouse en la horizontal está en la primera mitad del dibujo
    
    //mapear la posición
    mapX = map( mouseX, 0, root_ancho/2, map_top, 0);
    
    //si el contador de desplazamiento de la cámara no ha depasado el límite
    if( cam_moveX_count < cam_limitX ){
      
      //mover la cámara en X la cantidad mapeada
      cam_moveX = int(mapX);
      
    }else{
      //no mover la cámara
      cam_moveX = 0;
    }
  }
  
  
  
  // si el mouse en la vertical está en la mitad inferior
  if( mouseY > root_alto / 2){
    
    // mapear la posición
    mapY = map( mouseY, root_alto / 2, root_alto, 0, -map_top);
    
    // si el contador de desplazamiento de la cámara no ha depasado el límite
    if( cam_moveY_count > -cam_limitY){
      
      //mover la cámara en Y la cantidad mapeada
      cam_moveY = int(mapY);
      
    }else{
      //no mover la cámara
      cam_moveY = 0;
    }
    
  }else{// si el mouse en la vertical está en la mitad superior
  
    //mapear la posición  
    mapY = map( mouseY, 0, root_alto / 2, map_top, 0);
    
    //si el contador de desplazamiento de la cámara no ha depasado el límite
    if( cam_moveY_count < cam_limitY){
      
      //mover la cámara en Y la cantidad mapeada
      cam_moveY = int(mapY);
      
    }else{
      //no mover la cámara
      cam_moveY = 0;
    }
  }
}



void movimiento_camara_kinect() {

  int   posicionX = 0, 
  posicionY = 0, 
  posicionZ = 0;
  //println( "ID : " + objeto[0] + " | posX - " + objeto[1] + " | posY - " + objeto[2] + " | posZ - " + objeto[3] );

  if (objeto[0]==1) {
    //println("hay deteccion");
    posicionX = int( objeto[1] * 100);
    posicionY = int( objeto[2] * 100);
    posicionZ = int( objeto[3] * 100);

    
    if (posicionX > 50) {

      
      if (cam_moveX_count > -980) {
        
        cam_moveX = int( 50 - (((100 - float(posicionX)) / 50) * 50) );
        
        cam_moveX = -cam_moveX;
        //println( - cam_moveX );
      }
      else {
        cam_moveX = 0;
      }
      
    }
    else {
      
       if(cam_moveX_count < 2100){
         
         cam_moveX = int(( ( float(posicionX) / 50) * 50 ) - 50);
         
         cam_moveX = -cam_moveX;
         
       }else{
         
         cam_moveX = 0;
         
       }
       
    }
    
    println( cam_moveY_count );
    if( posicionY > 50){
      
        if( cam_moveY_count > -1080){
           cam_moveY = int( 50 - (((100 - float(posicionY)) / 50) * 50) );
           cam_moveY = - cam_moveY;
        }else{
            cam_moveY = 0;
        }
        
     }else{
       
       if( cam_moveY_count  < 1800){
         cam_moveY = int(( ( float(posicionY) / 50) * 50 ) - 50);
         cam_moveY = -cam_moveY;
       }else{
         cam_moveY = 0;
       }
      
     }
    
  }
}

