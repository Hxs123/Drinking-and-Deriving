/**************************************************
* Tree class
* Author: Hector Solis
* Trees are used in the background
**************************************************/
public class Tree extends Entity{
  
  /* Creates a Tree object at xCoor, yCoor */
  public Tree(float xCoor, float yCoor){
    // Iniitialize Entity inherited variables
    this.xCoor = xCoor;
    this.yCoor = yCoor;
    this.myWidth = 50;
    this.myHeight = 100;    
    this.xSpeed = 10;
    this.img = loadImage("Tree.gif");
  }
 
  /* Redraws the Tree object at its new location*/
  void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
}
