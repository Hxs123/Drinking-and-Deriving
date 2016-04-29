import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import java.awt.Color; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.FileNotFoundException; 
import java.util.*; 
import java.io.IOException; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Drinking_and_Deriving extends PApplet {




String typing = "";
String saved = "";
boolean flash = true;
boolean begin = false;
boolean paused = false;
boolean question = false;
boolean theEnd = false;
float rectX1;
float rectX2;
float rectX3;
float rectX4;
int oldS = 0;
int oldM = 0;
int oldM2 = 15001;
int oldM3 = 0;
int s = second();
int m = millis();
int questionsCorrect = 0;
Car player;
BAC_Meter meter;
ArrayList<Tree> trees = new ArrayList<Tree>();
ArrayList<House> houses = new ArrayList<House>();
ArrayList<Coin> coins = new ArrayList<Coin>();
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Police_Car> police = new ArrayList<Police_Car>();
DerivativeQuestion dq;
DerivativeQuestionGUI qog;
Minim minim;
AudioPlayer bmusic;
AudioSample snd[];
PImage startScreen;
public void setup() {
  smooth();
  
  //audio section
  minim = new Minim(this);
  bmusic = minim.loadFile("A.M.G. Go hard like Vladimir Putin.mp3", 512);
  bmusic.setGain(-10);
  bmusic.loop(60);
  snd = new AudioSample[4];
  snd[0] = minim.loadSample("PickUpCoin.wav");
  snd[1] = minim.loadSample("wrong.wav");
  snd[2] = minim.loadSample("WrongAnswer.mp3");
  snd[3] = minim.loadSample("RightAnswer.wav");
  
  size(1000, 600);
  dq = new DerivativeQuestion();
  qog = new DerivativeQuestionGUI(dq.getCurrentQuestion(), dq.getTheRandomQuestionSets(), dq.getRightOrWrong());
  rectX1 = 1000;
  rectX2 = 750;
  rectX3 = 500;
  rectX4 = 250;
  
  startScreen = loadImage("PutinHead.gif");
}

public void draw() {
  textSize(40);
  int indent = 10;
  s = second();
  //System.out.println(paused);
  if (flash) {
    background(255,43,0);
    image(startScreen, 350.0f, 100.0f, 300.0f, 300.0f);
    
    textSize(60);
    text("Drinking and Deriving with Putin", 25, 100);
    
    textSize(40);
    if (s % 2 == 0) {
      text("Enter Name and Press ", 350, 430);
      text("ENTER to start! ", 400, 470);
    } 
    else if (keyCode == ENTER) {
      startGame();
      flash = false;
      keyCode = UP;
    } 
    text(typing.toUpperCase(), indent, 40);
  }
  else if(paused == false && !question && !theEnd){
    m = millis();
    if (begin) {
      instantiateObjects();
      begin = false;
      player = new Car();
      police.add(new Police_Car(150, true));
      police.add(new Police_Car(225, false));
      police.add(new Police_Car(300, true));
      police.add(new Police_Car(375, false));
      meter = new BAC_Meter();
    }
//    System.out.println(m);
    if (m - oldM > 500) {
      instantiateObjects();
      spawnMisc();
      oldM = m;
    } 
    drawBackground();
    drawMisc();
    meter.reDraw();
    player.update();
    player.reDraw();
    textSize(40);
    fill(255);
    text(saved.toUpperCase(),25,40);
    text("Score: " + player.getScore(),25,80);
    
    //All other game logic goes here
//    System.out.println("Seconds: " + s);
//    System.out.println("M's: " + (m - oldM2));
    if(m - oldM2 > 15000){
      oldM2 = millis();
      qog = new DerivativeQuestionGUI(dq.getCurrentQuestion(), dq.getTheRandomQuestionSets(), dq.getRightOrWrong()); 
      question = true;
      oldM3 = millis();
    }
    
    if(meter.isFull()){
      theEnd = true;  
      snd[2].trigger();
    }
  }
  else if(paused && !theEnd){
     fill(0);
    textSize(100);
    text("PAUSED", 300, 100);
    //fill(51,153,255);
    fill(255);
    textSize(20);
    text("Oh no!  Putin just annexed Crimea and invaded Ukraine and now \nObama from Team America: World Police is trying send Putin a stongly worded #tweet.\nHelp Putin escape from the American imperialist pigs by using the arrow keys.\nCollect all of the Putin heads (+100), Obama's are bad (-300).", 100, 170);
    text(" \nAlong the way, correctly answer the Calculus questions in order to boost Putin's stamina \nin his fight against the Ukrainian Nazis. The BAC (Body Anti-Integral Concentration) meter\nwill increase every time Putin gets an answer wrong,\nwhich increases Obama's chances of bringing Putin to Hague.  Slava Roosiya!", 100, 320);
  }
  else if(question && !theEnd){
     qog.reDraw();
      if(qog.choiceSelected()){
        if(qog.checkChoiceCorrect()){
          player.incrementScore(1000);
          snd[3].trigger();
          questionsCorrect++;
        }
        else{
          meter.incrementBAC(50);
          player.incrementScore(-1000);
          snd[2].trigger();
        }
        question = false;
        dq.popNewQuestionSet();  
        oldM2 = millis();
        if(dq.getCurrentQuestionSet() == null){
          theEnd = true;  
          snd[3].trigger();
        }
    }
    else if(millis() - oldM3 > 30000){
        snd[2].trigger();
        player.incrementScore(-1000);
        meter.incrementBAC(50);
        question = false;
        dq.popNewQuestionSet();  
        oldM2 = millis();
        if(dq.getCurrentQuestionSet() == null){
          theEnd = true;  
        }
    }
   // noStroke();
//    fill(0, 255, 0);
//    rect(500, 50, 50, 50);
    fill(0);
    text((30 - ((millis() - oldM3) / 1000)) + "", 750, 150);
  }
  else if(theEnd){
    background(0);
    fill(255);
    text("GAME OVER", 350, 300);
    text("Final Score: " + player.getScore(), 300, 400);
    text("Questions Correct: " + questionsCorrect, 300, 500);
  }
}

public void startGame() {
  background(0);
  if (saved != "") {
    text(saved.toUpperCase(), 25, 40);
  } 
  else {
    saved = "PLAYER";
    text(saved.toUpperCase(), 25, 40);
  }
  textSize(30);
  begin = true;
}

public void instantiateObjects() {
  float rand = random(1);
  if(rand > 0.4f){
    rand = random(1);
    if(rand >= 0.4f){ 
      trees.add(new Tree(1000, 25));
    }
    else{
      houses.add(new House(975, 25));
    }
  }
  rand = random(1);
  if(rand > 0.4f){
    rand = random(1);
    if(rand >= 0.6f){
      trees.add(new Tree(1000, 475));
    }
    else{
      houses.add(new House(975, 475));
    }
  }
}

public void drawBackground() {
  m = millis();
  background(0);
  stroke(0);          
  fill(0, 255, 0);
  rect(0, 0, 1000, 150); 
  rect(0, 450, 1000, 150);
  fill(255, 240, 50);
  rectX1 -= 10;
  if (rectX1 <= 0 && rectX1 + 100 >= 0) {
    rect(1000 + rectX1, 275, 100, 50);
  }
  else if(rectX1 <= 0 && rectX1 + 100 <= 0){
    rectX1 = 890;
  }
  rect(rectX1, 275, 100, 50);
  rectX2 -= 10;
  if (rectX2 <= 0 && rectX2 + 100 >= 0) {
    rect(1000 + rectX2, 275, 100, 50);
  }
  else if(rectX2 <= 0 && rectX2 + 100 <= 0){
    rectX2 = 890;
  }
  rect(rectX2, 275, 100, 50);
  rectX3 -= 10;
  if (rectX3 <= 0 && rectX3 + 100 >= 0) {
    rect(1000 + rectX3, 275, 100, 50);
  }
  else if(rectX3 <= 0 && rectX3 + 100 <= 0){
    rectX3 = 890;
  }
  rect(rectX3, 275, 100, 50);
  rectX4 -= 10;
  if (rectX4 <= 0 && rectX4 + 100 >= 0) {
    rect(1000 + rectX4, 275, 100, 50);
  }
  else if(rectX4 <= 0 && rectX4 + 100 <= 0){
    rectX4 = 890;
  }
  rect(rectX4, 275, 100, 50);
//  rect(1000 - (m % 1000), 275, 100, 50);
//  if (m % 1000 <= 100) {
//    rect(0, 275, 100 - (m % 1000), 50);
//  }
//  rect(750 - (m % 1000), 275, 100, 50);
//  if (m % 1000 >= 750) { 
//    rect(1000 + (750 - (m % 1000)), 275, 100, 50);
//  }
//  rect(500 - (m % 1000), 275, 100, 50);
//  if (m % 1000 >= 500) {
//    rect(1000 + (500 - (m % 1000)), 275, 100, 50);
//  }
//  rect(250 - (m % 1000), 275, 100, 50);
//  if (m % 1000 >= 250) {
//    rect(1000 + (250 - (m % 1000)), 275, 100, 50);
//  }
  //trees.add(new Tree(950, 25));
  drawTrees();
  drawHouses();
  drawPolice();
}

public void drawTrees() {
  for(int i = trees.size() - 1; i >= 0; i--){
    Tree t = trees.get(i);
    t.reDraw();
    if(t.getXCoordinate() + t.getWidth() < 0){
     trees.remove(i); 
    }
  }
}

public void drawHouses() {
  for(int i = houses.size() - 1; i >= 0; i--){
    House h = houses.get(i);
    h.reDraw();
    if(h.getXCoordinate() + h.getWidth() < 0){
     houses.remove(i); 
    }
  }
}

public void drawPolice() {
  for(int i = police.size() - 1; i >= 0; i--){
    Police_Car p = police.get(i);
    p.reDraw();
  }
}

public void spawnMisc(){
  float rand = random(1);
  if(rand > 0.85f){
    rand = random(1);
    if(rand > .75f){
      rand = random(150, 400); 
      coins.add(new Coin(rand));
    }
    else{
      rand = random(150, 400);
      rocks.add(new Rock(rand));
    }
  }
  rand = random(1);
  if(rand > 0.85f){
    rand = random(1);
    if(rand < .5f){ 
      rand = random(150, 400);
      coins.add(new Coin(rand));
    }
    else{
      rand = random(150, 400);
      rocks.add(new Rock(rand));
    }
  }
  
}

/**
* The following is the stop method, and it is used to stop any runningmusic or programs associated with this program
*/
public void stop()
{
bmusic.close();
minim.stop();
super.stop();
}

public void drawMisc(){
  //more logic later
  for(int i = coins.size() - 1; i >= 0; i--){
    Coin c = coins.get(i);
    c.reDraw();
    if(c.getXCoordinate() + c.getWidth() < 0){
     coins.remove(i); 
    }
    else if(c.hasCollided(player)){
      snd[0].trigger();
      player.incrementScore(c.getScoreValue());
      coins.remove(i); 
    }
  }
  for(int j = rocks.size() - 1; j >= 0; j--){
    Rock r = rocks.get(j);
    r.reDraw();
    if(r.getXCoordinate() + r.getWidth() < 0){
     rocks.remove(j); 
    }
    else if(r.hasCollided(player)){
      snd[1].trigger();
      player.incrementScore(r.getScoreValue());
      meter.incrementBAC(rocks.get(j).getBACValue());
      rocks.remove(j); 
    }
  }
  
}

public void keyPressed() {
  if(flash){
    // If the return key is pressed, save the String and clear it
    if (keyCode == '\n') {
      saved = typing;
      // A String can be cleared by setting it equal to ""
      typing = "";
    } 
    else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
  }
  if(!flash && key == 'p' && !question){
    paused = !paused;  
  }
  if (player != null && key == CODED){
    if (keyCode == LEFT) {
       player.keys[0] = true;
    }
    if (keyCode == RIGHT) {
       player.keys[1] = true;
    }
    if (keyCode == UP) {
       player.keys[2] = true;
    }
    if (keyCode == DOWN) {
       player.keys[3] = true;
    }
  }
}

public void keyReleased() {
    if (player != null && key == CODED){
      if (keyCode == LEFT) {
         player.keys[0] = false;
      }
      if (keyCode == RIGHT) {
         player.keys[1] = false;
      }
      if (keyCode == UP) {
         player.keys[2] = false;
      }
      if (keyCode == DOWN) {
         player.keys[3] = false;
      }
  }
}

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
  
  public void reDraw(){
    noStroke();
    fill(237, 28, 36);
    rect(BAC_X, BAC_Y - fillHeight, fillWidth, fillHeight);
    
    image(img, xCoor, yCoor, myWidth, myHeight);
    
  }
  
  public void incrementBAC(int increase){
    fillHeight += increase;
  }
  
  public boolean isFull(){
    return fillHeight >= 385;
  }
}
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
  
  public void update(){
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
  
  
  public void reDraw(){
    image(img, xCoor, yCoor, myWidth, myHeight);
    if(index + 1 < frames.size()){
      index++;
    }
    else{
      index = 0;
    }
    img = frames.get(index);
  } 
  
  public int getScore(){
     return score; 
  }
  
  public void incrementScore(int increase){
    score += increase;
    
  }
}
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
  
   public void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
  
  public int getScoreValue(){
    return scoreValue;
    
  }
  
}
/**
  This Class stores all of the user inputs and also the database for all of the 
  Derivatives and its answers
**/



 //imports everything



public class DerivativeQuestion   {

        // GLOBAL FIELDS
        public  Queue<Question> randomQuestions = new LinkedList<Question>();
        private  ArrayList<Question> constructedWord = new ArrayList<Question>();
        private ArrayList allOfTheQuestionSetsTextFile;  //gets all of the textfile as arraylist
        private int questionSetLengthBEGIN;  //length of queue before modification  USE THIS FOR HEIREARCHY 
        private int numWrongGuesses; // dealt with in the isInWord method
        private String currentWord;
        private ArrayList<String> usedLetters = new ArrayList<String>();
        private List<String> newQuestionSet;
        private int score;

        // CONSTANTS
        public static final int MAX_NUM_GUESS = 6;

        public DerivativeQuestion() {

                // Code starts here::
                readsFromTextFile();
                randomizeQuestionSets();
                //newQuestionSet = getTheRandomQuestionSets();  //sets final list of question and its answers
               // printsQuestions();


        }
        
        
        //reads from textfile
        public void readsFromTextFile(){
           String[] getFromTextFile = loadStrings("QuestionSets.txt");
           
           //goes through each indivual lines and sends it to question to be provessed into individual bits
           for(int i= 0; i < getFromTextFile.length; i++){
                // Splitting a String based on |
                String[] list = split(getFromTextFile[i], "|");
                constructedWord.add(new Question(list));
                
                
           }
           
           questionSetLengthBEGIN = getFromTextFile.length;  //gets initial size FINAL
           
          
        }
        
        //TEST ONLY, prints out question sets
        public void printsQuestions(){
           for(int i = 0; i < questionSetLengthBEGIN; i++){
               //System.out.println(getCurrentQuestion() + " || " +  getCurrentAnswer());
               System.out.println(getCurrentQuestion() + " || " + getTheRandomQuestionSets());
               popNewQuestionSet();
               
           }
        }
                
                
        // get the current word from arraylist of constructedWord
        public String getCurrentWord() {
                return this.currentWord;
        }

        // randomize the questions to be put in a queue
        public void randomizeQuestionSets() {
                while (constructedWord.size() > 0) {
                        int random = (int) (Math.random() * constructedWord.size());
                        // condition so no repeats of questions
                        if (constructedWord.get(random) != null) {
                                randomQuestions.add(constructedWord.get(random));
                                constructedWord.remove(random);
                        }
                }
        }




        // gets the queue of questions
        public Queue<Question> getQuestionsAndAnswers() {
                return randomQuestions;
        }

        // gets the sets of questions and answer
        public Queue<Question> getQuestionSet() {
                return randomQuestions;
        }

        // pops the queue for new question and answer set
        public void popNewQuestionSet() {
                randomQuestions.remove();
        }

        // gets the question from in front of the queue (current)
        public Question getCurrentQuestionSet() {
                return randomQuestions.peek();
        }

        // gets the current question
        public String getCurrentQuestion() {
                return randomQuestions.peek().getQuestion();
        }

        // gets the current answer
        public String getCurrentAnswer() {
                return randomQuestions.peek().getCorrectAnswer();
        }
        
        //gets wrong answer 1
        public String getWrongAnswer1() {
                return randomQuestions.peek().getWrongAnswer1();
        }
        
        //gets wrong answer 2
        public String getWrongAnswer2() {
                return randomQuestions.peek().getWrongAnswer2();
        }
        
        //gets wrong answer 3
        public String getWrongAnswer3() {
                return randomQuestions.peek().getWrongAnswer3();
        }
        
        //gets random getRandomQuestionSet
        public List<String> getTheRandomQuestionSets(){
              List<String> temp = new ArrayList<String>(); 
              temp = randomQuestions.peek().getRandomQuestionSet();
              newQuestionSet = temp;
              return newQuestionSet;
        }
        
      
        
        //returns an array of what is right, what is wrong answer
        public List<Boolean> getRightOrWrong(){
          List<Boolean> listsRorW = new ArrayList<Boolean>(4);
             listsRorW.add(compareAnswerCorrect(newQuestionSet.get(0)));
             listsRorW.add(compareAnswerCorrect(newQuestionSet.get(1)));
             listsRorW.add(compareAnswerCorrect(newQuestionSet.get(2)));
             listsRorW.add(compareAnswerCorrect(newQuestionSet.get(3)));
             
             return listsRorW;
        }
        
       

        // gets the current answer length
        public int getCurrentAnswerLength() {
                return getCurrentAnswer().length();
        }
        
        //gets current questionset's length
        public int getCurrentQuestionSetLength() {
                return randomQuestions.size();
        }
        
        //compares the answer that user inputs to the real answer
        public boolean compareAnswerCorrect(String ans){
           
            return ans.equals(getCurrentAnswer());
        }

}
int rectColor, baseColor;
int choice1Highlight, choice2Highlight, choice3Highlight, choice4Highlight;
int currentColor;
float xCoorChoice1, yCoorChoice1, xCoorChoice2, yCoorChoice2, xCoorChoice3, yCoorChoice3, xCoorChoice4, yCoorChoice4;
String currentQuestion;
List<String> randomAnswers;
List<Boolean> rightOrwrong;

boolean choice1 = false;
boolean choice2 = false;
boolean choice3 = false;
boolean choice4 = false;


public class DerivativeQuestionGUI extends Entity {

  public DerivativeQuestionGUI(String quest, List<String> randAnsw, List<Boolean> rightoRong) {
  //instantiates the correct answer booleans
  currentQuestion = quest;
  randomAnswers = randAnsw;
  rightOrwrong = rightoRong;
    

  this.xCoor = 167.0f; //2x + (screenWidth/1.5) = screenWidth
  this.yCoor = 100.0f;

  xCoorChoice1 = 167.0f;
  yCoorChoice1 = 180.0f;

  xCoorChoice2 = 167.0f;
  yCoorChoice2 = 260.0f;

  xCoorChoice3 = 167.0f;
  yCoorChoice3 = 340.0f;

  xCoorChoice4 = 167.0f;
  yCoorChoice4 = 420.0f;

  myWidth = 667;
  myHeight = 80;
  rectColor = color(102);

 
  choice1Highlight = color(41);
  choice2Highlight = color(41);
  choice3Highlight = color(41);
  choice4Highlight = color(41);

  baseColor = color(170);
  currentColor = baseColor;

  }

  public void reDraw() {
  update(mouseX, mouseY);
  //Question Label  (non-mutable)
  fill(255);
  rect(xCoor, yCoor, myWidth, 80);
  fill(170);
  textSize(20);
  createText(currentQuestion, 200, yCoor-20);
  fill(baseColor);
  createText(currentQuestion, 200, yCoor-20);


  //choice 1
  if (choice1) {
    fill(choice1Highlight);
  }



  rect(xCoorChoice1, yCoorChoice1, myWidth, 80);
  fill(baseColor);

  createText(randomAnswers.get(0), 200, yCoorChoice1);
  //choice 2

  if (choice2) {
    fill(choice2Highlight);
  }



  rect(xCoorChoice2, yCoorChoice2, myWidth, 80);
  fill(baseColor);
  createText(randomAnswers.get(1), 200, yCoorChoice2);

  //choice 3

  if (choice3) {
    fill(choice3Highlight);
  }



  rect(xCoorChoice3, yCoorChoice3, myWidth, 80);
  fill(baseColor);
  createText(randomAnswers.get(2), 200, yCoorChoice3);

  //choice 4

  if (choice4) {
    fill(choice4Highlight);
  }



  rect(xCoorChoice4, yCoorChoice4, myWidth, 80);
  fill(baseColor);
  createText(randomAnswers.get(3), 200, yCoorChoice4);
  }
 
  public boolean choiceSelected(){
  if (mousePressed == true && (choice1 || choice2 || choice3 || choice4)) {
      return true;
    }
    return false;
  }
 
  public boolean checkChoiceCorrect(){
  //choice 1
  if (choice1) {
    if (mousePressed == true) {
      return checksIfCorrect(0);

    }
  }

  //choice 2
  if (choice2) {
    if (mousePressed == true) {
      return checksIfCorrect(1);
    }
  }

  //choice 3
  if (choice3) {
    if (mousePressed == true) {
      return checksIfCorrect(2);
    }
  }

  //choice 4
  if (choice4) {
    if (mousePressed == true) {
      return checksIfCorrect(3);
    }
  }
  return false;
  }
 
  //checks if the answer that the user chose is correct
  public boolean checksIfCorrect(int n){
  if(rightOrwrong.get(n) == true)
       return true;
   else
       return false;
   
  }

  //creates the text answers to show on screen
  public void createText(String s, float x, float y) {
  textSize(20);
  text(s, x, y+30, 600, 60);
  fill(50);
  }

  public void update(int x, int y) {
  if (overRect(Math.round(xCoor), Math.round(yCoor), myWidth, 80)) {
    
    choice1 = false;
    choice3 = false;
    choice2 = false;
    choice4 = false;
  }
  //choice 1
  else if (overRect(Math.round(xCoorChoice1), Math.round(yCoorChoice1), myWidth, 80)) {
    choice1 = true;
    
    choice2 = false;
    choice3 = false;
    choice4 = false;
  }

  //choice 2
  else if (overRect(Math.round(xCoorChoice2), Math.round(yCoorChoice2), myWidth, 80)) {
    choice2 = true;
    
    choice1 = false;
    choice3 = false;
    choice4 = false;
  }

  //choice 3
  else if (overRect(Math.round(xCoorChoice3), Math.round(yCoorChoice3), myWidth, 80)) {
    choice3 = true;
    
    choice1 = false;
    choice2 = false;
    choice4 = false;
  }

  //choice 4
  else if (overRect(Math.round(xCoorChoice4), Math.round(yCoorChoice4), myWidth, 80)) {
    choice4 = true;
    
    choice1 = false;
    choice2 = false;
    choice3 = false;
  } else {
    
    choice1 = false;
    choice2 = false;
    choice3 = false;
    choice4 = false;
  }
  }
 




  public boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
    return true;
  } else {
    return false;
  }
  }

}

abstract class Entity{
  
  protected float xCoor;
  protected float yCoor;
  protected int myWidth;
  protected int myHeight;
  protected int xSpeed;
  protected int ySpeed;
  protected PImage img;
  
  public void update(){
    
  }
  
  public void reDraw(){
    
  }
  
  public float getXCoordinate(){
    return xCoor;
  }
    
  public float getYCoordinate(){
    return yCoor;
  }

  public int getWidth(){
    return myWidth;
  }
  
  public int getHeight(){
    return myHeight;
  }
  
  public boolean hasCollided(Entity other){
    if( xCoor <= other.getXCoordinate() + other.getWidth() && xCoor + myWidth  >= other.getXCoordinate() && yCoor <= other.getYCoordinate() + other.getHeight() && yCoor + myHeight >= other.getYCoordinate()){
      return true; 
    }
    return false;
    
  }
  
}
//if (xCoor + width <= 0) remove entity from arraylist
public class House extends Entity{
  
  public House(float xCoor, float yCoor){
    this.xCoor = xCoor;
    this.yCoor = yCoor;
    myWidth = 100;
    myHeight = 100;    
    xSpeed = 10;
    img = loadImage("House.gif");
  }
 
  public void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
  
 
 
 
  
  
}
public class Police_Car extends Entity{
  
    boolean shiftLeft = false;
  
   public Police_Car(float yCoor, boolean bool){
    this.xCoor = 0;
    this.yCoor = yCoor;
    myWidth = 100;
    myHeight = 50;
    img = loadImage("PoliceCar.gif");
    shiftLeft = bool;
   } 
  
   public void reDraw(){
    if(shiftLeft){
      xCoor -= 1;
      if(xCoor <= -20){
        shiftLeft = false;
      }
    }
    else{
      xCoor += 1;
      if(xCoor >= 20){
        shiftLeft = true;
      }
    }
    image(img, xCoor, yCoor, myWidth, myHeight); 
  } 
  
  
}
/*
     This class implements the Questions class.  It allows for the DerivativeQuestion to get 
     a basic structure of the each individual Questions/Answers the use inputs into the game.
     THIS CLASS SHOULD NOT BE MODIFIED, modify the  DerivativeQuestion instead
*/
public class Question{
  private String questionText;
  private String correctChoice, wrongChoice1,wrongChoice2,wrongChoice3;
  
  //pass in a question set
  //the constructor will split it into appropiate sections
  public Question(String[] lists){
       classifiesTheList(lists);
  }

  
  //classifies the list into appropiate answer choices (right wrong, the question itself etc..)
  // [QUESTION, CORRECT ANSWER, WRONG 1, WRONG 2, WRONG 3]
  public void classifiesTheList(String[] list){
       for(int i =0 ; i < list.length; i++){
          //first element is the Derivative Question
          if(i == 0) 
             questionText = list[i];
          //second element is the correct answer
          else if(i == 1)
             correctChoice = list[i];
          //third element is the wrong answer 1
          else if(i == 2)
             wrongChoice1 = list[i];
          //fourth element is the wrong answer 2
          else if(i == 3)
             wrongChoice2 = list[i];
          //fifth element is the wrong answer 3
          else if(i == 4)
              wrongChoice3 = list[i];
          else
             questionText = list[i];
       }
  }

  public String getQuestion() {
    return questionText;
  }
  
  public String getCorrectAnswer(){
    return correctChoice;
  }
  
  public String getWrongAnswer1(){
    return wrongChoice1;
  }
  
  public String getWrongAnswer2(){
    return wrongChoice2;
  }
  
  public String getWrongAnswer3(){
    return wrongChoice3;
  }
  
  
  //**IMPORTANT FOR MC **  gets all sets of questions in random order
        public List<String> getRandomQuestionSet(){
            // create array list object       
            List<String> sets = new ArrayList();
      
            // populate the list
            sets.add(getCorrectAnswer());
            sets.add(getWrongAnswer1());
            sets.add(getWrongAnswer2());  
            sets.add(getWrongAnswer3()); 
      
           // shuffle the list
           Collections.shuffle(sets);
      
           return sets;       
        }
}
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
  
   public void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight); 
  } 
  
  public int getScoreValue(){
    return scoreValue;
  }
  
  public int getBACValue(){
    return BACValue;
  }
  
}
public class Tree extends Entity{
  
  public Tree(float xCoor, float yCoor){
    this.xCoor = xCoor;
    this.yCoor = yCoor;
    myWidth = 50;
    myHeight = 100;    
    xSpeed = 10;
    img = loadImage("Tree.gif");
  }
 
  public void reDraw(){
    xCoor -= xSpeed;
    image(img, xCoor, yCoor, myWidth, myHeight);
  } 
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Drinking_and_Deriving" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
