abstract class Entity{
  
  protected float xCoor;
  protected float yCoor;
  protected int myWidth;
  protected int myHeight;
  protected int xSpeed;
  protected int ySpeed;
  protected PImage img;
  
  void update(){
    
  }
  
  void reDraw(){
    
  }
  
  float getXCoordinate(){
    return xCoor;
  }
    
  float getYCoordinate(){
    return yCoor;
  }

  int getWidth(){
    return myWidth;
  }
  
  int getHeight(){
    return myHeight;
  }
  
  boolean hasCollided(Entity other){
    if( xCoor <= other.getXCoordinate() + other.getWidth() && xCoor + myWidth  >= other.getXCoordinate() && yCoor <= other.getYCoordinate() + other.getHeight() && yCoor + myHeight >= other.getYCoordinate()){
      return true; 
    }
    return false;
    
  }
  
}
//if (xCoor + width <= 0) remove entity from arraylist
