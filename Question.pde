/*
     This class implements the Questions class.  It allows for the DerivativeQuestion to get 
     a basic structure of the each individual Questions/Answers the use inputs into the game.
     THIS CLASS SHOULD NOT BE MODIFIED, modify the  DerivativeQuestion instead
     Author: Peter Le
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
