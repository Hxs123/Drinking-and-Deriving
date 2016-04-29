public class Rock extends Entity{
  private int scoreValue;
  private int BACValue;
  
  public Rock(float yCoor){
    this.xCoor = 1000;
    this.yCoor = yCoor;
    myWidth = 50;
    myHeight = 50;    
    xSpeed = 3;
    scoreValue = -300;
    BACValue = 5;
    img = loadImage("Obama.gif");
  }
  
   void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight); 
  } 
  
  int getScoreValue(){
    return scoreValue;
  }
  
  int getBACValue(){
    return BACValue;
  }
  
}
