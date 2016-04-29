/**************************************************
* Car class
* Author: Hector Solis
* Player controlled car that moves around
**************************************************/
public class Car extends Entity{

  // ArrayList of frames used to animate the car
  private ArrayList<PImage> frames;
  
  // The index of the current frame in the ArrayList
  private int index = 0;

  // Boolean of keyboard keys to handle user input
  public boolean[] keys;

  // The player's current Score
  private int score;
  
   /* Creates a new Car object for the player to control*/
   public Car(){
     // Initializing variables inherited from Entity
     this.xCoor = 100;
     this.yCoor = 275;
     this.myWidth = 100;
     this.myHeight = 50;
  	 this.xSpeed = 5;
     this.ySpeed = 5;

     // Creating the frames arraylist with different frames
     frames = new ArrayList<PImage>();
     frames.add(loadImage("Car1.gif"));
     frames.add(loadImage("Car2.gif"));
     frames.add(loadImage("Car3.gif"));
     frames.add(loadImage("Car4.gif"));

     // Sets the current frame
     this.img = frames.get(index);
     
     // Creates the keys array
     /*
		0 - Move Left
		1 - Move Right
		2 - Move Down
		3 - Move Up
     */
     keys = new boolean[4];
     keys[0] = false;
      keys[1] = false;
      keys[2] = false;
      keys[3] = false;
   }
  
  /* Updates the player's position and score */
  public void update(){
  	// Move Left
    if(keys[0] && xCoor - xSpeed >= 100){
      xCoor -= xSpeed; 
    }
    // Move Right
    if(keys[1] && xCoor + xSpeed + myWidth <= 900){
      xCoor += xSpeed; 
    }
    // Move Down
    if(keys[2] && yCoor - ySpeed >= 150){
      yCoor -= ySpeed; 
    }
    // Move Up
    if(keys[3] && yCoor + ySpeed + myHeight <= 450){
      yCoor += ySpeed; 
    }
    //Increment score
    score++;
  }
  
  /* Redraws the car*/
  public void reDraw(){
    // Draws image
    image(img, xCoor, yCoor, myWidth, myHeight);
    
    //Cycles through frames
    if(index + 1 < frames.size()){
      index++;
    }
    else{
      index = 0;
    }
    img = frames.get(index);
  } 
  
  /* Returns the current score of the player */
  public int getScore(){
     return score; 
  }
  
  /* Increments the player's score by the amount increase */
  public void incrementScore(int increase){
    score += increase;
    
  }
}
