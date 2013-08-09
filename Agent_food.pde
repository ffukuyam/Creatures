public class Agent_food  {
   int total_food;
   int food_decrement = 10;
  int wherex = -1;
  int wherey = -1;
  int stockpile = -1;
  boolean exists = false;
    
  public void eat()  {
    if (stockpile > food_decrement)  
      stockpile -= food_decrement;
    else if (stockpile <= food_decrement)
      stockpile = -1;
  }
}
