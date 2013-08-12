Creatures
=========

repository for the Creatures agent-based model

This is an agent-based simulation written in the Processing language.

When you run the program, you will see a pond with little creatures swimming around in it.  The red ones are females and the blue ones are males.  The black squares are food, which the creatures eat when they run into them.  They gain energy by eating food.  If a male and female meet, they can mate and produce offspring.  The offspring inherit some combination of the mother's and father's intelligence (their ability to search for food), so over time there should be some evolution in the aggregate intelligence of the population.  The creatures expend energy by searching for food and mating, and pass some of their energy on to their offspring (the creatures' length shows how much energy they have).  

The characteristics of the initial population of creatures is fixed by the program, but subsequent behavior is subject to several randomizing parameters.  This means that the outcome of the simulation will be different every time you run the program.  (If you want to cheat, you can add new creatures by left-clicking your mouse over the pond; new creatures will appear at the location of the mouse pointer.) 

The simulation is agent-based, meaning that each individual creature is modeled but there is no attempt to model the aggregate behavior of the population.  (The characteristics of each creature are defined in the Agent_creature class; one of the nice things about object-oriented programming is that you can easily add new characteristics to the agents.)  Behavior of the population as a whole simply emerges from the behavior of the individual agents as they interact.  If you are patient and run the program several times, you will see simulations in which the whole population dies out, others in which there is a population explosion, and others in which the population oscillates.  Following a population explosion, the new creatures tend to travel in flocks; I don't know why this is true but that's the beauty of agent-based models.  

In order to run the program, you must download and install the Processing Integrated Development Interface (IDE) from the web site of Processing.org.  The program requires four files, AgentP.pde, Agent_core.pde, Agent_creature.pde, and Agent_food.pde, all of which must be placed in your "Sketchbook" folder.  These files can be downloaded here.  (You can see where this folder is located by going to the File  Preferences menu item in the Processing IDE; you can also set a different directory if you wish.)  

If you're into programming, you should play with the parameters defined at the top of the AgentP.pde program, especially SPAWN_BONUS, GROW_CYCLE, ESTRUS_CYCLE, and SENESCENCE.  You can also change the size of the pond, or the initial group of creatures.  In order to get to reasonably stable populations, I found I had to introduce rules to prevent newly-hatched brothers and sisters from mating, to prevent parents mating with their children, and to prevent males and females from immediately re-mating (that's why the females have an estrus cycle).  So I guess incest prohibitions have a certain natural logic to them.  The inheritance/evolutionary aspect of the program doesn't seem to work very well, so that's a project for the future.  

People should feel free to modify or distribute the program, and let me know if they come up with any interesting variants. 
