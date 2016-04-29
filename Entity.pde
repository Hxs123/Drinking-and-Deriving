/**************************************************
* Entity class
* Author: Hector Solis
* Entity provides a basic framework for all game 
* entities.
**************************************************/
abstract class Entity{
  
  // X coordinate of the entity
  protected float xCoor;

  // Y coordinate of the entity
  protected float yCoor;
  
  // Width of the entity
  protected int myWidth;
  
  // Height of the entity
  protected int myHeight;
  
  // X-Speed of the entity
  protected int xSpeed;

  // Y-Speed of the entity
  protected int ySpeed;

  // Image of the entity
  protected PImage img;
  
  /* Abstract method for updating the state of the entity */
  public void update(){
    
  }
  
  /* Abstract method for redrawing the entity */
  public void reDraw(){
    
  }
  
  /* Returns the x coordinate of the entity */
  public float getXCoordinate(){
    return xCoor;
  }
    
  /* Returns the y coordinate of the entity */
  public float getYCoordinate(){
    return yCoor;
  }

  /* Returns the width of the entity */
  public int getWidth(){
    return myWidth;
  }
  
  /* Returns the height of the entity */
  public int getHeight(){
    return myHeight;
  }
  
  /* Checks if the Entity has collided with other */
  public boolean hasCollided(Entity other){
    // Standard rectangle collision test
    if( xCoor <= other.getXCoordinate() + other.getWidth() && 
        xCoor + myWidth  >= other.getXCoordinate() && 
        yCoor <= other.getYCoordinate() + other.getHeight() && 
        yCoor + myHeight >= other.getYCoordinate()) {
      return true; 
    }
    return false;   
  }
}