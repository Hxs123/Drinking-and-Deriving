public class BAC_Meter extends Entity{
  
  private float BAC_X;
  private float BAC_Y;
  private int fillWidth;
  private int fillHeight;
  
  public BAC_Meter(){
    this.xCoor = 900;
    this.yCoor = 70;
    myWidth = 80;
    myHeight = 460;  
    fillWidth = 65;
    fillHeight = 0; //0 start //max fill height = 385
    BAC_X = 907;
    BAC_Y = 456;//450
    img = loadImage("BAC.gif");
  }
  
  void reDraw(){
    noStroke();
    fill(237, 28, 36);
    rect(BAC_X, BAC_Y - fillHeight, fillWidth, fillHeight);
    
    image(img, xCoor, yCoor, myWidth, myHeight);
    
  }
  
  void incrementBAC(int increase){
    fillHeight += increase;
  }
  
  boolean isFull(){
    return fillHeight >= 385;
  }
}
