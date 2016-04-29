public class Car extends Entity{
  
  private ArrayList<PImage> frames;
  private int index = 0;
  public boolean[] keys;
  private int score;
  
   public Car(){
     this.xCoor = 100;
     this.yCoor = 275;
     myWidth = 100;
     myHeight = 50;
     frames = new ArrayList<PImage>();
     frames.add(loadImage("Car1.gif"));
     frames.add(loadImage("Car2.gif"));
     frames.add(loadImage("Car3.gif"));
     frames.add(loadImage("Car4.gif"));
     img = frames.get(index);
     keys = new boolean[4];
      keys[0] = false;
      keys[1] = false;
      keys[2] = false;
      keys[3] = false;
     xSpeed = 5;
     ySpeed = 5;
   }
  
  void update(){
    if(keys[0] && xCoor - xSpeed >= 100){
      xCoor -= xSpeed; 
    }
    if(keys[1] && xCoor + xSpeed + myWidth <= 900){
      xCoor += xSpeed; 
    }
    if(keys[2] && yCoor - ySpeed >= 150){
      yCoor -= ySpeed; 
    }
    if(keys[3] && yCoor + ySpeed + myHeight <= 450){
      yCoor += ySpeed; 
    }
    score++;
  }
  
  
  void reDraw(){
    image(img, xCoor, yCoor, myWidth, myHeight);
    if(index + 1 < frames.size()){
      index++;
    }
    else{
      index = 0;
    }
    img = frames.get(index);
  } 
  
  int getScore(){
     return score; 
  }
  
  void incrementScore(int increase){
    score += increase;
    
  }
}
