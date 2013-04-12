/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                  Acciones de monitoreo con el teclado                   ////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////


void teclado(){ //función que es llamada desde draw()
  keyPress('s',1); //verifica si la tecla indicada es presionada y ejecuta la acción del segundo parametro
  keyPress('h',2); //menos cubos en el eje X
  keyPress('k',3); //más cubos en el eje X
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


void keyPress(char letra,int accion){
  
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


void accionesTeclado(int ac){
  
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
