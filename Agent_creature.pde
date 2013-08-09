public class Agent_creature  {
   String species = "";
   int number_creatures;
   int energy = 300;
   boolean female = true;
   int estrus = 0;
   int wherex = 0;
   int wherey = 0;
   int fertility = 1;
   int intelligence = 0;
   String name = "";
   char direction = 'e';
   int speed = 1;
   int age = 20;
   boolean alive = false;
  
  public void increase_energy(int ene)  {
    energy += ene;
  }
  
  public void decrease_energy(int ene)  {
    energy -= ene;
  }
  
  public void move_relative(int relx, int rely)  {
    wherex += relx;
    wherey += rely;
  }
  
  public void state_energy()  {
    System.out.println(energy);
  }
  
  public void move_east()  {
    wherex++;
  }
  
  public void move_south()  {
    wherey++;
  }
  
  public char get_direction(int ind)  {
    return direction;
  }
  
  public void move()  {
    int distance = speed;
    
    if (direction == 'e')
//      wherex++;
      wherex += distance;
    else if (direction == 's')
      wherey += distance;
    else if (direction == 'w')
      wherex -= distance;
    else if (direction == 'n')
      wherey -= distance;
    else if (direction == '1')  {

      wherex += distance;
      wherey -= distance;
    }
    else if (direction == '2')  {

      wherex += distance;
      wherey += distance;
    }
    else if (direction == '3')  {

      wherex -= distance;
      wherey += distance;
    }
    else if (direction == '4')  {

      wherex -= distance;
      wherey -= distance;
    }
    energy--;
  }
}
