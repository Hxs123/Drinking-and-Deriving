/**************************************************
* Coin class
* Author: Hector Solis
* Coin that can be picked up for points
**************************************************/
public class Coin extends Entity{
  
  // Value of the coin in points
  private int scoreValue;
  
  /* Creates a Coin object at the given yCoor */
  public Coin(float yCoor){
    // Initializing Entity inherited values
    this.xCoor = 1000;
    this.yCoor = yCoor;
    this.myWidth = 50;
    this.myHeight = 50;    
    this.xSpeed = 3;
    // Initialize the Coin's value
    scoreValue = 100;
    this.img = loadImage("Putin.gif");
  }

  /* Redrawd the Coin at its new location*/
  public void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
  
  /* Returns the value of the Coin*/
  public int getScoreValue(){
    return scoreValue;
  }
  
}
