public class House extends Entity{
  
  public House(float xCoor, float yCoor){
    this.xCoor = xCoor;
    this.yCoor = yCoor;
    myWidth = 100;
    myHeight = 100;    
    xSpeed = 10;
    img = loadImage("House.gif");
  }
 
  void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
  
 
 
 
  
  
}
