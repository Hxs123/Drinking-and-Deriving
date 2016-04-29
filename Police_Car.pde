/**************************************************
* Police_Car class
* Author: Hector Solis
* Police cars to be used in the background
**************************************************/
public class Police_Car extends Entity{
  
   // Tracks whether the car is moving left or right
   private boolean shiftLeft = false;
  
   /* Creates a Police_Car object at yCoor moving 
      left if bool is true or right if it is false*/
   public Police_Car(float yCoor, boolean bool){
    // Initialize Entity inherited fields
    this.xCoor = 0;
    this.yCoor = yCoor;
    this.myWidth = 100;
    this.myHeight = 50;
    this.img = loadImage("PoliceCar.gif");
    shiftLeft = bool;
   } 
  
   /* Redraws the Police_Car*/
   void reDraw(){
    /* Moves the cars left for a while, 
       then moves them right after a certain distance*/
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
