public class Agent_core {
//  this class contains all the major non-display functions necessary to operate the model

public void push(int index)  {
  living_creatures[stk_ptr] = index;
  stk_ptr++;
}

public void init_buffer()  {
  for (int i=0; i<stk_ptr; i++)  {
    living_creatures[stk_ptr] = 0;
    stk_ptr = 0;
  }
  println("Initializing creature array...");
  output = "Initializing creature array...";
}

public int count_food()  {
  int total = 0;
  for (int i=0; i<MAX_FOOD; i++)  {
    if (food[i].stockpile > 0)
      total += food[i].stockpile;
  }
  return total;
}

public boolean creature_there(int testx, int testy)  {
  boolean answer = false;
  for (int i=0; i<MAX_CREATURES; i++)  {
    if (agent[i].alive == true)  {
      if ((testx == agent[i].wherex) && (testy == agent[i].wherey))  {
        answer = true;
      }
      else answer = false;
    }
  }
  return answer;
}
  
public int get_creature_index(int xval, int yval)  {
  int which = 0;
  for (int i = 0; i < MAX_CREATURES; i++)  {
    if ((agent[i].wherex == xval) && (agent[i].wherey == yval)) {
      which = i;
      break;
    }
  }
  return which;
}
  
public int met_creature(int index)  {
  int answer = -1;
  for (int i=0; i<MAX_CREATURES; i++)  {
    if (i != index)  {
      if ((agent[i].wherex == agent[index].wherex) && (agent[i].wherey == agent[index].wherey)) {
        answer = i;
      }
    }
    else answer = -1;
  }
  return answer;
}

public int near_creature(int index, int intel)  {
  int answer = -1;
  int startx, starty;
  for (startx = -intel; startx < intel + 1; startx++)  {
    for (starty = -intel; starty < intel + 1; starty++)  {
      for (int i=0; i<MAX_CREATURES; i++)  {
        if (i != index)  {
          if ((agent[i].wherex + startx == agent[index].wherex) && (agent[i].wherey + starty == agent[index].wherey)) {
            if (can_mate(i, index) == true)  {
              answer = i;
              println("Found partner " + i +  " near");
              break;
            }
          }
        }
      else answer = -1;
      }
    }
  }
  return answer;
}
  
public int count_creatures()  {
  int numb = 0;
  for (int i=0; i<MAX_CREATURES; i++)  {
    if (agent[i].alive == true)  {
      numb++;
//        push(i);
    }
  }
  num_creatures = numb;
  return numb;
}

public boolean eat_food(int index)  {
  boolean answer = false; 
  for (int i=0; i<MAX_FOOD; i++)  {
    if ((agent[index].wherex == food[i].wherex) && (agent[index].wherey == food[i].wherey))  {
      answer = true;
      if (food[i].stockpile >= food[i].food_decrement)  {
        String r = "Eating.  Creature " + String.valueOf(index) + " had " + String.valueOf(agent[index].energy);
        food[i].eat();
        agent[index].energy += 50;
        agent[index].energy += i;
        String t = "Now has " + String.valueOf(agent[index].energy);
        r = r + "  " + t;
        println(r);
        output = r;
      }
    }
  }
  return answer;
}
  
public boolean can_move(int index, int dist)  {
  boolean answer = true;
  if (agent[index].direction == 'e')  {
    if ((agent[index].wherex + dist) >= WORLD_X)
      answer = false;
  } 
  else if (agent[index].direction == 's')  {
    if ((agent[index].wherey + dist) >= WORLD_Y)
      answer = false;
  }
  else if (agent[index].direction == 'w')  {
    if ((agent[index].wherex - dist) < 0)
      answer = false;
  }
  else if (agent[index].direction == 'n')  {
    if ((agent[index].wherey - dist) < 0)
      answer = false;
  }
  else if (agent[index].direction == '1')  {
    if (((agent[index].wherex + dist) >= WORLD_X) || ((agent[index].wherey - dist) < 0))
      answer = false;
  }
  else if (agent[index].direction == '2')  {
    if (((agent[index].wherex + dist) >= WORLD_X) || ((agent[index].wherey + dist) >= WORLD_Y))
      answer = false;
  }
  else if (agent[index].direction == '3')  {
    if (((agent[index].wherex - dist) < 0) || ((agent[index].wherey + dist) >= WORLD_Y))
      answer = false;
  }
  else if (agent[index].direction == '4')  {
    if (((agent[index].wherex - dist) < 0) || ((agent[index].wherey - dist) < 0))
      answer = false;
  }
  else answer = true;
  return answer;
}
  
public void change_direction(int index)  {
  if (agent[index].direction == 'e')  {
    agent[index].direction = '3';
    if (can_move(index, 1) == false)
      agent[index].direction = '4';
  }
  else if (agent[index].direction == 's')  {
    agent[index].direction = '4';
    if (can_move(index, 1) == false)
      agent[index].direction = '1';
  }
  else if (agent[index].direction == 'w')  {
    agent[index].direction = '1';
    if (can_move(index, 1) == false)
      agent[index].direction = '2';
  }
  else if (agent[index].direction == 'n')  {
    agent[index].direction = '2';
    if (can_move(index, 1) == false)
      agent[index].direction = '3';
  }
  else if (agent[index].direction == '1')  {
    agent[index].direction = 'w';  
    if (can_move(index, 1) == false)
      agent[index].direction = 's';
  }
  else if (agent[index].direction == '2')  {
    agent[index].direction = 'n';
    if (can_move(index, 1) == false)
      agent[index].direction = 'w';
  }
  else if (agent[index].direction == '3')  {
    agent[index].direction = 'e';
    if (can_move(index, 1) == false)
      agent[index].direction = 's';
  }
  else if (agent[index].direction == '4')  {
    agent[index].direction = 's';
    if (can_move(index, 1) == false)
      agent[index].direction = 'n';
  }
}

public boolean coin_toss() {
  boolean answer= false;
  int seed = get_random(2); ;
  if (seed == 1)  
    answer = true;
  else 
    answer = false;
  return answer;
}
  
public boolean food_there(int x, int y)  {
  boolean answer = false;
  for (int i=0; i<MAX_FOOD; i++)  {
    if ((food[i].wherex == x) && (food[i].wherey == y))  {
      if (food[i].stockpile > 0)  {
        answer = true;
      }
    }
  }
  return answer;
}

//this method scans a square dist units around the creature for food or mates
public char scan_around(int cr_ind, int dist, boolean food)  {
  int x, y, j, k, i1, i2, fx, fy = -1;
  double vector, xvec, yvec, hype = 0;
  char answer = 'x';
  vector = 0;
  fx = -1;
  x = agent[cr_ind].wherex - dist;
  j = agent[cr_ind].wherex + dist;
  if (x <=0)  {
    x = 0;
  }
  if (j >= WORLD_X)  {
    j = WORLD_X;
  }
  y = agent[cr_ind].wherey - dist;
  k = agent[cr_ind].wherey + dist;
  if (y <= 0)  {
    y = 0;
  }
  if (k >= WORLD_Y)   {
    k = WORLD_Y;
  }
  for (i1=x; i1<j; i1++)  {
    for (i2=y; i2<k; i2++)  {
      if (food == true)  {
        if (food_there(i1, i2) == true)  {
          xvec = (float)i1 - (float)agent[cr_ind].wherex;
          yvec = (float)i2 - (float)agent[cr_ind].wherey;
          hype = Math.sqrt(Math.pow(xvec, 2) + Math.pow(yvec, 2));
          if (hype > vector)  {
            vector = hype;
            fx = i1;
            fy = i2;
          }
        }
      }
      else if (food == false) {
        if (creature_there(i1, i2) == true)  {
          String r = String.valueOf(cr_ind) + " is searching for a mate.";
          println(r);
          output = r;
          xvec = (float)i1 - (float)agent[cr_ind].wherex;
          yvec = (float)i2 - (float)agent[cr_ind].wherey;
          hype = Math.sqrt(Math.pow(xvec, 2) + Math.pow(yvec, 2));
          if (hype > vector)  {
            vector = hype;
            fx = i1;
            fy = i2;
          }
          int ind = get_creature_index(i1, i2);
//            agent[ind].speed = 0;
        }
      }
    }
  }
  if (fx != -1)  {
    if (((agent[cr_ind].wherex - fx) > 0) && ((agent[cr_ind].wherey - fy) > 0))
      answer = '4';
    else if (((agent[cr_ind].wherex - fx) > 0) && ((agent[cr_ind].wherey - fy) == 0))
      answer = 'w';
    else if (((agent[cr_ind].wherex - fx) > 0) && ((agent[cr_ind].wherey - fy) < 0))
      answer = '3';
    else if (((agent[cr_ind].wherex - fx) == 0) && ((agent[cr_ind].wherey - fy) > 0))
      answer = 'n';
    else if (((agent[cr_ind].wherex - fx) == 0) && ((agent[cr_ind].wherey - fy) == 0))
      answer = 'x';
    else if (((agent[cr_ind].wherex - fx) == 0) && ((agent[cr_ind].wherey - fy) < 0))
      answer = 's';
    else if (((agent[cr_ind].wherex - fx) < 0) && ((agent[cr_ind].wherey - fy) > 0))
      answer = '1';
    else if (((agent[cr_ind].wherex - fx) < 0) && ((agent[cr_ind].wherey - fy) == 0))
      answer = 'e';
    else if (((agent[cr_ind].wherex - fx) < 0) && ((agent[cr_ind].wherey - fy) < 0))
      answer = '2';
    else answer = 'x';
  }
  return answer;
}
  
public int find_next_living_creature()  {
  int answer = -1; 
  boolean found = false;
  for (int i=0; i<MAX_CREATURES; i++)  {
    if (agent[i].alive == false)  {
      if (found == false)  {
        answer = i;
        found = true;
      }
    }
  }
  if (found != true)  
      answer = -1;
  return answer;
}
  
public int find_next_empty_food()  {
  int answer = -1; 
  boolean found = false;
  for (int i=0; i<MAX_FOOD; i++)  {
    if (food[i].stockpile <= 0)  {
      if (found == false)  {
        answer = i;
        found = true;
      }
    }
  }
  if (found != true)  {
      answer = -1;
    }
  return answer;
}
  
public void new_food()  {
//    Random dice = new Random();
  int x, y;
  int ind = -1;
  x = int(random(WORLD_X));
  y = int(random(WORLD_Y));
  if (food_there(x, y) == false)  {
    ind = find_next_empty_food();
    if (ind != -1)  {
      food[ind].wherex = x;
      food[ind].wherey = y;
      food[ind].stockpile = 30;
      println("Growing food");
      output = "Growing food...";
    }
  }
}
  
public boolean can_mate(int cr1, int cr2)  { 
  boolean answer = false;
  if (agent[cr1].female != agent[cr2].female)  {
    println("Potential mate!");
    output = "Potential mate!";
    int difference = agent[cr1].age - agent[cr2].age;
    if (difference < 0)
      difference = difference * -1;
    if ((difference < 15) && (difference >= 0)){
      answer = false;   //prevents parent-child incest
    }
    else {
      if (agent[cr1].female == true)  {
        if (agent[cr1].estrus < ESTRUS_CYCLE)  {
          answer = false;
        }        //females can't mate again for ESTRUS_CYCLE 
        else {
          answer = true;
        }
      }
      if (agent[cr2].female == true)  {
        if (agent[cr2].estrus < ESTRUS_CYCLE)  {
          answer = false;
        }
        else {
          answer = true;
        }
      }
    }
  }
  return answer;
}
  
public void find_open(int ind)  {
  int dist;
  dist = agent[ind].speed;
  while (can_move(ind, dist) == false)  {
    change_direction(ind);
  }
}

public int get_random(int num)  {
  int dice = int(random(100));
  int result = dice % num;
  return result;
}
  
public void spawn (int mom, int gain, int dad)  {
  int fertility = get_random(7); 
  for (int t = 0; t <= fertility; t++)  {
    int i = find_next_living_creature();
    if (i != -1)  {
      agent[i].alive = true;
      agent[i].intelligence = recombine(agent[mom].intelligence, agent[dad].intelligence, 'i');
      num_creatures++;
      println("Spawning creature " + i);
      output = "Spawning creature ";
      agent[i].direction = agent[mom].direction;
      find_open(i);
      agent[i].energy = gain + SPAWN_BONUS;
      agent[i].female = coin_toss();
      agent[i].age = 1;
      switch (agent[i].direction)  {
        case 'e':
          agent[i].wherex = agent[mom].wherex + 1;
          agent[i].wherey = agent[mom].wherey;
          break;
        case 's':
          agent[i].wherex = agent[mom].wherex;
          agent[i].wherey = agent[mom].wherey + 1;
          break;
        case 'w':
          agent[i].wherex = agent[mom].wherex - 1;
          agent[i].wherey = agent[mom].wherey;
          break;
        case 'n':
          agent[i].wherex = agent[mom].wherex;
          agent[i].wherey = agent[mom].wherey - 1;
          break;
        case '1':
          agent[i].wherex = agent[mom].wherex + 1; 
          agent[i].wherey = agent[mom].wherey - 1;
          break;
        case '2':
          agent[i].wherex = agent[mom].wherex + 1;
          agent[i].wherey = agent[mom].wherey + 1;
          break;
        case '3':
          agent[i].wherex = agent[mom].wherex - 1;
          agent[i].wherey = agent[mom].wherey + 1;
          break;
        case '4':
          agent[i].wherex = agent[mom].wherex - 1;
          agent[i].wherey = agent[mom].wherey - 1;
          break;
        default:
      }
    }
  }
}

  
public void move_creatures()  {
  int loss1 = 0;
  int loss2 = 0;
  int cr_found = -1;
  char dir = 'x';
  for (int i=0; i<MAX_CREATURES; i++)  {
      if (agent[i].alive == true)  {
        agent[i].age++;   //each creature ages
        if (agent[i].female == true) {
          agent[i].estrus++;  //increase estrus cycle
        }
        if (agent[i].age > SENESCENCE)  {   //creatures get weaker as they age
          int discount = agent[i].age / 100;
          agent[i].energy -=discount;
        }
        int dist = agent[i].speed;
        eat_food(i);
        cr_found = near_creature(i, agent[i].intelligence);
        if (cr_found != -1)  {
          if (can_mate(cr_found, i) == true)  {
          String r = "Creatures " + String.valueOf(cr_found) + " and " + String.valueOf(i) + " mating; creature born!";
          println(r);
          output = r;
          if (agent[i].energy > 300)
            loss1 = 90;
          else if (agent[i].energy > 200)
            loss1 = 75;
          else if (agent[i].energy > 100)
             loss1 = 40;
          else if ((agent[i].energy > 50) && (agent[i].energy >= 0))
             loss1 = agent[i].energy;
          if (agent[cr_found].energy > 300)
            loss2 = 90;
          else if (agent[cr_found].energy > 200)
            loss2 = 75;
          else if (agent[cr_found].energy > 100)
             loss2 = 40;
          else if ((agent[cr_found].energy > 50) && (agent[cr_found].energy >= 0))
             loss2 = agent[i].energy;
          spawn(i, loss1 + loss2, cr_found);
          agent[i].energy -= loss1;
          agent[cr_found].energy -= loss2;
          if (agent[i].female == true)  {
            agent[i].estrus = 0;
          }
          if (agent[cr_found].female = true)  {
            agent[cr_found].estrus = 0;
          }
          }
        }
        dir = scan_around(i, 3 + agent[i].intelligence, true);  //scan for food
        if (dir != 'x')  {                //found food; move towards it
          agent[i].direction = dir;
          if (can_move(i, 1) == true) 
            agent[i].move();
        }
        else if (can_move(i, 1) == true)  {   //hasn't found anything; randomly change direction
            int seed = get_random(11);
            if (seed == 3)  {
              change_direction(i);
              find_open(i);
              agent[i].move();
            }
            else
              agent[i].move();
        }
        else {          // can't move; change direction
          find_open(i);
          agent[i].move();
        }
        if (agent[i].energy <= 0)  {
          agent[i].alive = false;
          String r = "Creature " + String.valueOf(i) + " is dead!";
          println(r);
          output = r;
          num_creatures--;
        }
        if (num_creatures <= 0)  {
          System.out.println("Game is over.");
          println("Ending period: " + timeClock);
        }
      }  // end if alive
    }  // end for
}

public void pushCreatures(int cr)  {
  for (int i = (GRAPH_BUFFER - 1); i > 0; i--)  {
    creatureGraph[i] = creatureGraph[i-1];
    creatureGraph[0] = cr;
  }
}

public void pushFood(int fd)  {
  for (int i = (GRAPH_BUFFER - 1); i > 0; i--)  {
    foodGraph[i] = foodGraph[i-1];
    foodGraph[0] = fd;
  }
}
  
// averages intelligence over all creatures living to
// test for evolution
public float average_intelligence()  {
  float intel = 0;
  int p;
  for (int i = 0; i < MAX_CREATURES; i++)  {
    if (agent[i].alive == true) {
      intel = intel + agent[i].intelligence;
    }
  }
  if ((p = count_creatures()) > 0) {
    intel = intel / count_creatures();
  }
  else intel = 0;
  return intel;
}

// child inherits mother's or father's intelligence or fertility with a 
//50 percent chance it will be oen or the other
public int recombine(int mother, int father, char quality)  {  
  int child = 1;
  if (quality == 'i') {
    if (coin_toss() == true) {
      child = agent[mother].intelligence;
    }
    else {
      child = agent[father].intelligence;
    }
  }
  else if (quality == 'f')  {
      if (coin_toss() == true) {
        child = agent[mother].fertility;
      }
      else {
        child = agent[father].fertility;
      }
  }
  return child;
}

public void set_intelligence()  {
    for (int i = 10; i < 60; i++)  {
      agent[i].intelligence = 2;
    }
}

public void position_creatures(Agent_creature[] Agent_cr)  {
  Agent_cr[0].alive = true;
  Agent_cr[0].wherex = 13;
  Agent_cr[0].wherey = 5;
  Agent_cr[0].direction = '1';
  Agent_cr[0].name = "Rob";
  Agent_cr[0].female = false;
  Agent_cr[1].alive = true;
  Agent_cr[1].wherex = 33;
  Agent_cr[1].wherey = 50;
  Agent_cr[1].direction = 'n';
  Agent_cr[1].direction = 'e';
  Agent_cr[1].name = "Henry";
  Agent_cr[1].female = false;
  Agent_cr[2].alive = true;
  Agent_cr[2].wherex = 6;
  Agent_cr[2].wherey = 25;
  Agent_cr[2].direction = 'n';
  Agent_cr[2].name = "Marsha";
  Agent_cr[2].female = true;
  Agent_cr[3].alive = true;
  Agent_cr[3].wherex = 57;
  Agent_cr[3].wherey = 6;
  Agent_cr[3].direction = '2';
  Agent_cr[3].name = "Tad";
  Agent_cr[3].female = false;
  Agent_cr[4].alive = true;
  Agent_cr[4].wherex = 56;
  Agent_cr[4].wherey = 5;
  Agent_cr[4].direction = '1';
  Agent_cr[4].name = "Wilma";
  Agent_cr[4].direction = '4';
  Agent_cr[5].alive = true;
  Agent_cr[5].wherex = 31;
  Agent_cr[5].wherey = 24;
  Agent_cr[5].direction = 'w';
  Agent_cr[5].name = "Ernie";
  Agent_cr[5].female = false;
  Agent_cr[6].alive = true;
  Agent_cr[6].wherex = 35;
  Agent_cr[6].wherey = 12;
  Agent_cr[6].direction = 'e';
  Agent_cr[6].name = "Joy";
  Agent_cr[6].direction = '2';
  Agent_cr[7].alive = true;
  Agent_cr[7].wherex = 17;
  Agent_cr[7].wherey = 41;
  Agent_cr[7].direction = '4';
  Agent_cr[7].name = "Ann";
  Agent_cr[7].female = false;
  Agent_cr[8].alive = true;
  Agent_cr[8].wherex = 22;
  Agent_cr[8].wherey = 53;
  Agent_cr[8].direction = '3';
  Agent_cr[8].name = "Art";
  Agent_cr[8].female = false;
  Agent_cr[9].alive = true;
  Agent_cr[9].wherex = 23;
  Agent_cr[9].wherey = 58;
  Agent_cr[9].direction = 's';
  Agent_cr[9].name = "Sue";
  Agent_cr[10].alive = true;
  Agent_cr[10].wherex = 28;
  Agent_cr[10].wherey = 57;
  Agent_cr[10].direction = 's';
  Agent_cr[10].name = "Sara";
  Agent_cr[11].alive = true;
  Agent_cr[11].wherex = 5;
  Agent_cr[11].wherey = 55;
  Agent_cr[11].direction = '2';
  Agent_cr[11].name = "Joe";
  Agent_cr[11].female = false;
  Agent_cr[12].alive = true;
  Agent_cr[12].wherex = 44;
  Agent_cr[12].wherey = 46;
  Agent_cr[12].direction = '2';
  Agent_cr[12].name = "Pete";
  Agent_cr[12].female = false;
  Agent_cr[13].alive = true;
  Agent_cr[13].wherex = 37;
  Agent_cr[13].wherey = 33;
  Agent_cr[13].direction = 's';
  Agent_cr[13].name = "Jill";
  Agent_cr[14].alive = true;
  Agent_cr[14].wherex = 3;
  Agent_cr[14].wherey = 2;
  Agent_cr[14].direction = 'e';
  Agent_cr[14].female = false;
  Agent_cr[14].name = "Albert";
  Agent_cr[15].alive = true;
  Agent_cr[15].wherex = 20;
  Agent_cr[15].wherey = 4;
  Agent_cr[15].direction = '3';
  Agent_cr[15].name = "May";
  Agent_cr[16].alive = true;
  Agent_cr[16].wherex = 69;
  Agent_cr[16].wherey = 57;
  Agent_cr[16].direction = '4';
  Agent_cr[16].name = "Ross";
  Agent_cr[16].female = false;
  Agent_cr[17].alive = true;
  Agent_cr[17].wherex = 50;
  Agent_cr[17].wherey = 50;
  Agent_cr[17].direction = '3';
  Agent_cr[17].name = "Georgette";
  Agent_cr[18].alive = true;
  Agent_cr[18].wherex = 19;
  Agent_cr[18].wherey = 61;
  Agent_cr[18].direction = '1';
  Agent_cr[18].name = "June";
  Agent_cr[18].female = true;
  Agent_cr[19].alive = true;
  Agent_cr[19].female = true;
  Agent_cr[19].name = "Susana";
  Agent_cr[19].wherex = 52;
  Agent_cr[19].wherey = 52;
  Agent_cr[19].intelligence = 3;
  Agent_cr[19].direction = 'e';
  Agent_cr[29].name = "Gudrun";
  Agent_cr[29].female = true;
  Agent_cr[20].name = "Helmut";
  Agent_cr[20].alive = true;
  Agent_cr[20].female = false;
  Agent_cr[20].wherex = 82;
  Agent_cr[20].wherey = 38;
  Agent_cr[20].direction = '3';
  Agent_cr[20].intelligence = 3;
  Agent_cr[21].name = "Frank";
  Agent_cr[21].female = false;
  Agent_cr[21].alive = true;
  Agent_cr[21].intelligence = 3;
  Agent_cr[21].direction = 's';;
  Agent_cr[21].wherex = 3;
  Agent_cr[21].wherey = 4;
  Agent_cr[22].name = "Laura";
  Agent_cr[22].female = true;
  Agent_cr[22].alive = true;
  Agent_cr[22].intelligence = 44;
  Agent_cr[22].direction = 'w';
  Agent_cr[22].wherex = 10;
  Agent_cr[22].wherey = 12;
  Agent_cr[23].name = "David";
  Agent_cr[23].female = false;
  Agent_cr[23].alive = true;
  Agent_cr[23].intelligence = 13;
  Agent_cr[23].direction = '4';
  Agent_cr[23].wherex = 20;
  Agent_cr[23].wherey = 50;
  Agent_cr[24].name = "Julia";
  Agent_cr[24].female = true;
  Agent_cr[24].alive = true;
  Agent_cr[24].direction = 'n';
  Agent_cr[24].intelligence = 4;
  Agent_cr[24].wherex = 22;
  Agent_cr[24].wherey = 8;
  Agent_cr[25].name = "John";
  Agent_cr[24].alive = true;
  Agent_cr[24].female = false;
  Agent_cr[24].direction = 's';
  Agent_cr[24].intelligence = 4;
  Agent_cr[24].wherex = 33;
  Agent_cr[24].wherey = 48;
  Agent_cr[30].name = "Olga";
  Agent_cr[30].alive = true;
  Agent_cr[30].female = true;
  Agent_cr[30].wherex = 70;
  Agent_cr[30].wherey = 70;
  Agent_cr[31].name = "Ian";
  Agent_cr[31].alive = true;
  Agent_cr[31].female = false;
  Agent_cr[31].wherex = 77;
  Agent_cr[31].wherey = 2;
  Agent_cr[31].direction = '3';
  Agent_cr[31].female = false;
  Agent_cr[32].name = "Cyndi";
  Agent_cr[32].female = true;
  Agent_cr[33].name = "Ricardo";
  Agent_cr[33].female = false;
  Agent_cr[34].name = "Raul";
  Agent_cr[34].female = false;
  Agent_cr[35].name = "Maria";
  Agent_cr[35].female = true;
  Agent_cr[36].name = "Anna";
  Agent_cr[36].female = true;
  Agent_cr[37].name = "Strom";
  Agent_cr[37].female = false;
  Agent_cr[38].name = "Helen";
  Agent_cr[38].female = true;
  Agent_cr[39].name = "Steve";
  Agent_cr[39].female = false;
  Agent_cr[40].name = "Jerry";
  Agent_cr[40].female = false;
  Agent_cr[41].name = "Wanda";
  Agent_cr[41].female = true;
  Agent_cr[41].alive = true;
  Agent_cr[41].intelligence = 3;
  Agent_cr[41].wherex = 28;
  Agent_cr[41].wherey = 62;
  Agent_cr[42].name = "Arnold";
  Agent_cr[42].female = false;
  Agent_cr[43].name = "Mary";
  Agent_cr[43].female = true;
  Agent_cr[44].name = "Alan";
  Agent_cr[44].female = false;
  Agent_cr[45].name = "April";
  Agent_cr[45].female = true;
  Agent_cr[46].name = "Richard";
  Agent_cr[46].female = false;
  Agent_cr[47].name = "Mark";
  Agent_cr[47].female = false;
  Agent_cr[48].name = "Pascale";
  Agent_cr[48].female = true;
  Agent_cr[49].name = "Erin";
Agent_cr[49].female = true;
println("Positioning creatures...");
}
  
public void init_energy()  {
  for (int i = 0; i < MAX_CREATURES; i++)  {
    agent[i].energy = 300;
  }
}
  
  public void position_food(Agent_food[] food)  {
    food[0].wherex = 10;
    food[0].wherey = 10;
    food[0].stockpile = 30;
    food[1].wherex = 20;
    food[1].wherey = 16;
    food[1].stockpile = 30;
    food[2].wherex = 30;
    food[2].wherey = 4;
    food[2].stockpile = 30;
    food[3].wherex = 40;
    food[3].wherey = 15;
    food[3].stockpile = 30;
    food[4].wherex = 50;
    food[4].wherey = 22;
    food[4].stockpile = 30;
    food[5].wherex = 60;
    food[5].wherey = 22;
    food[5].stockpile = 30;
    food[6].wherex = 13;
    food[6].wherey = 40;
    food[6].stockpile = 30;
    food[7].wherex = 24;
    food[7].wherey = 36;
    food[7].stockpile = 30;
    food[8].wherex = 31;
    food[8].wherey = 33;
    food[8].stockpile = 30;
    food[9].wherex = 44;
    food[9].wherey = 39;
    food[9].stockpile = 30;
    food[10].wherex = 55;
    food[10].wherey = 41;
    food[10].stockpile = 30;
    food[11].wherex = 63;
    food[11].wherey = 59;
    food[11].stockpile = 30;
    food[12].wherex = 12;
    food[12].wherey = 60;
    food[13].stockpile = 30;
    food[13].wherex = 22;
    food[13].wherey = 62;
    food[14].wherex = 33;
    food[14].wherey = 55;
    food[14].stockpile = 30;
    food[15].wherex = 39;
    food[15].wherey = 66;
    food[15].stockpile = 30;
    food[16].wherex = 50;
    food[16].wherey = 58;
    food[16].stockpile = 30;
    food[17].wherex = 33;
    food[17].wherey = 61;
    food[17].stockpile = 30;
    food[18].wherex = 10;
    food[18].wherey = 1;
    food[18].stockpile = 20;
    food[19].wherex = 0;
    food[19].wherey = 66;
    food[19].stockpile = 30;
    food[20].wherex = 69;
    food[20].wherey = 3;
    food[20].stockpile = 30;
    food[21].wherex = 67;
    food[21].wherey = 66;
    food[21].stockpile = 30;
    food[22].wherex = 22;
    food[22].wherey = 3;
    food[22].stockpile = 30;
    food[23].wherex = 12;
    food[23].wherey = 22;
    food[23].stockpile = 30;
    food[24].wherex = 68;
    food[24].wherey = 50;
    food[24].stockpile = 30;
    food[25].wherex = 27;
    food[25].wherey = 23;
    food[25].stockpile = 30;
//    food[26].wherex = 63;
//    food[26].wherey = 2;
//    food[26].stockpile = 30;
//    food[27].wherex = 51;
//    food[27].wherey = 5;
//    food[27].stockpile = 30;
//    food[28].wherex = 12;
//    food[28].wherey = 26;
//    food[28].stockpile = 30;
//    food[29].wherex = 18;
//    food[29].wherey = 37;
//    food[29].stockpile = 30;

    println("Positioning food...");
  }

}
