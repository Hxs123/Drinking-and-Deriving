/**
  This Class stores all of the user inputs and also the database for all of the 
  Derivatives and its answers
  Author: Peter Le
**/

import java.io.File;
import java.io.FileNotFoundException;
import java.util.*; //imports everything
import java.io.IOException;


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
