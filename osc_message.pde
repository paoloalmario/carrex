/* incoming osc message are forwarded to the oscEvent method. */

////// COMO LLEGA EL MENSAJE??? Y COMO LO PARSEO???
/*void oscEvent(OscMessage theOscMessage) {   
   
  
  
  if (theOscMessage.isPlugged()==false) {*/
    /* print the address pattern and the typetag of the received OscMessage */
    //println("### received an osc message.");
    //println("### addrpattern\t"+theOscMessage.addrPattern());
    //println("### typetag\t"+theOscMessage.typetag());
    
//    
//    if( match(theOscMessage.addrPattern(), "ID") != null ){
//      
//      lastAddress = theOscMessage.addrPattern();
//      
//      objeto[0] = theOscMessage.get(0).intValue();
//      objeto[1] = theOscMessage.get(1).floatValue();
//      objeto[2] = theOscMessage.get(2).floatValue();
//      objeto[3] = theOscMessage.get(3).floatValue();
//      //println( "ID : " + theOscMessage.get(0).intValue() + " | posX - " + objeto[0] + " | posY - " + objeto[1] + " | posZ - " + objeto[2] );
//      //println("DETECCION!");
//       
//    }else{
//       
//      if( lastAddress.equals(theOscMessage.addrPattern()) ){
//        //println("no hay nada");
//        objeto[0] = 0;
//      }
//      lastAddress = theOscMessage.addrPattern();
//    }
//    
//  }
//}

