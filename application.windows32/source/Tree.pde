public class Tree extends Entity{
  
  public Tree(float xCoor, float yCoor){
    this.xCoor = xCoor;
    this.yCoor = yCoor;
    myWidth = 50;
    myHeight = 100;    
    xSpeed = 10;
    img = loadImage("Tree.gif");
  }
 
  void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
}
