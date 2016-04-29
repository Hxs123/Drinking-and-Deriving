public class Coin extends Entity{
  private int scoreValue;
  
  public Coin(float yCoor){
    this.xCoor = 1000;
    this.yCoor = yCoor;
    myWidth = 50;
    myHeight = 50;    
    xSpeed = 3;
    scoreValue = 100;
    img = loadImage("Putin.gif");
  }
  
   void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
  
  int getScoreValue(){
    return scoreValue;
    
  }
  
}
