/**************************************************
* House class
* Author: Hector Solis
* House to be used in background generation
**************************************************/
public class House extends Entity{
  
  /* Creates a House object at the given xCoor and 
     yCoor*/
  public House(float xCoor, float yCoor){
    // Initialize Entity inherited variables
    this.xCoor = xCoor;
    this.yCoor = yCoor;
    this.myWidth = 100;
    this.myHeight = 100;    
    this.xSpeed = 10;
    this.img = loadImage("House.gif");
  }
 
  /* Redraws the house at its new location */
  void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
  
 
 
 
  
  
}
