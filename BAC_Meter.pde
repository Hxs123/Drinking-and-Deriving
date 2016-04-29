/**************************************************
* BAC_Meter class
* Author: Hector Solis
* Meter to be on the side of the screen. When this 
* meter is full, the game is over.
**************************************************/
public class BAC_Meter extends Entity{
  
  // X location of red bar that will fill the meter
  private float BAC_X;

  // Y location of red bar that will fill the meter
  private float BAC_Y;

  // Width of red bar that will fill the meter
  private int fillWidth;

  // Height of red bar that will fill the meter
  private int fillHeight;
  
  public BAC_Meter(){
    // Initializing Entity inherited values
    this.xCoor = 900;
    this.yCoor = 70;
    this.myWidth = 80;
    this.myHeight = 460;  

    // Initialize BAC_Meter fields
    BAC_X = 907;
    BAC_Y = 456;
    fillWidth = 65;
    fillHeight = 0; //0 start //max fill height = 385
    
    this.img = loadImage("BAC.gif");
  }
  
  /* Redraws the BAc_Meter at its new fullness */
  public void reDraw(){
    noStroke();
    fill(237, 28, 36);
    rect(BAC_X, BAC_Y - fillHeight, fillWidth, fillHeight);
    
    image(img, xCoor, yCoor, myWidth, myHeight);
    
  }
  
  /* Increment the Meter's height by increase */
  public void incrementBAC(int increase){
    fillHeight += increase;
  }
  
  /* Checks if the Meter is full */
  public boolean isFull(){
    return fillHeight >= 385;
  }
}
