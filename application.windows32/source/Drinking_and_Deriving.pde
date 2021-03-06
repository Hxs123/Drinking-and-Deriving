import ddf.minim.*;
import java.awt.Color;
import java.util.ArrayList;
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
void setup() {
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

void draw() {
  textSize(40);
  int indent = 10;
  s = second();
  //System.out.println(paused);
  if (flash) {
    background(255,43,0);
    image(startScreen, 350.0, 100.0, 300.0, 300.0);
    
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

void startGame() {
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

void instantiateObjects() {
  float rand = random(1);
  if(rand > 0.4){
    rand = random(1);
    if(rand >= 0.4){ 
      trees.add(new Tree(1000, 25));
    }
    else{
      houses.add(new House(975, 25));
    }
  }
  rand = random(1);
  if(rand > 0.4){
    rand = random(1);
    if(rand >= 0.6){
      trees.add(new Tree(1000, 475));
    }
    else{
      houses.add(new House(975, 475));
    }
  }
}

void drawBackground() {
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

void drawTrees() {
  for(int i = trees.size() - 1; i >= 0; i--){
    Tree t = trees.get(i);
    t.reDraw();
    if(t.getXCoordinate() + t.getWidth() < 0){
     trees.remove(i); 
    }
  }
}

void drawHouses() {
  for(int i = houses.size() - 1; i >= 0; i--){
    House h = houses.get(i);
    h.reDraw();
    if(h.getXCoordinate() + h.getWidth() < 0){
     houses.remove(i); 
    }
  }
}

void drawPolice() {
  for(int i = police.size() - 1; i >= 0; i--){
    Police_Car p = police.get(i);
    p.reDraw();
  }
}

void spawnMisc(){
  float rand = random(1);
  if(rand > 0.85){
    rand = random(1);
    if(rand > .75){
      rand = random(150, 400); 
      coins.add(new Coin(rand));
    }
    else{
      rand = random(150, 400);
      rocks.add(new Rock(rand));
    }
  }
  rand = random(1);
  if(rand > 0.85){
    rand = random(1);
    if(rand < .5){ 
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
void stop()
{
bmusic.close();
minim.stop();
super.stop();
}

void drawMisc(){
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

void keyPressed() {
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

void keyReleased() {
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

