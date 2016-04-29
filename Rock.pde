/**************************************************
* Rock class
* Author: Hector Solis
* Rocks that hurt the player and fill the BAC_Meter
**************************************************/
public class Rock extends Entity{

  // Value of getting hit by a rock in points
  private int scoreValue;

  // BAC_Meter penalty for hitting a rock
  private int BACValue;
  
  /* Creates a Rock object at yCoor*/
  public Rock(float yCoor){
    // Initialize Entity inherited variables
    this.xCoor = 1000;
    this.yCoor = yCoor;
    this.myWidth = 50;
    this.myHeight = 50;    
    this.xSpeed = 3;
    scoreValue = -300;
    BACValue = 5;
    this.img = loadImage("Obama.gif");
  }
  
  /* Redraws the Rock at its new location*/
  public void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight); 
  } 
  
  /* Returns the score penalty of the Rock*/
  public int getScoreValue(){
    return scoreValue;
  }
  
  /* Returns the BAC_Meter penalty of the Rock*/
  public int getBACValue(){
    return BACValue;
  }
  
}
