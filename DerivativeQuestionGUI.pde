/**************************************************
* DerivativeQuestionGUI class
* Author: Peter Le
* GUI for the Calculus questions
**************************************************/
color rectColor, baseColor;
color choice1Highlight, choice2Highlight, choice3Highlight, choice4Highlight;
color currentColor;
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
    

  this.xCoor = 167.0; //2x + (screenWidth/1.5) = screenWidth
  this.yCoor = 100.0;

  xCoorChoice1 = 167.0;
  yCoorChoice1 = 180.0;

  xCoorChoice2 = 167.0;
  yCoorChoice2 = 260.0;

  xCoorChoice3 = 167.0;
  yCoorChoice3 = 340.0;

  xCoorChoice4 = 167.0;
  yCoorChoice4 = 420.0;

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

  void reDraw() {
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
  void createText(String s, float x, float y) {
  textSize(20);
  text(s, x, y+30, 600, 60);
  fill(50);
  }

  void update(int x, int y) {
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
 




  boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
    return true;
  } else {
    return false;
  }
  }

}

