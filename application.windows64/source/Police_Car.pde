public class Police_Car extends Entity{
  
    boolean shiftLeft = false;
  
   public Police_Car(float yCoor, boolean bool){
    this.xCoor = 0;
    this.yCoor = yCoor;
    myWidth = 100;
    myHeight = 50;
    img = loadImage("PoliceCar.gif");
    shiftLeft = bool;
   } 
  
   void reDraw(){
    if(shiftLeft){
      xCoor -= 1;
      if(xCoor <= -20){
        shiftLeft = false;
      }
    }
    else{
      xCoor += 1;
      if(xCoor >= 20){
        shiftLeft = true;
      }
    }
    image(img, xCoor, yCoor, myWidth, myHeight); 
  } 
  
  
}
