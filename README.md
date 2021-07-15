# social-learning-and-childhood

Readme for Matlab code of
“Implications of Childhood in Social Learning”
Created by Serena Holte

To get started, save the six Matlab files in a folder:


This is the main script with which to run and change parameters described below:
	
	SocialLearning_MainProgram.m 

This function uses the “move” output from each individual to update their knowledge matrices:
	
	moveToHistory.m

This function determines the move for “innovate” strategies (innovate or exploit):
	
	InnovateStrategy.m

This function determines the move for “observe” strategies (observe or exploit):
	
	ObserveStrategy.m

This function determines the move for “mixed” strategies (innovate, observe, or exploit):
	
	MixedStrategy.m

This function creates a compiled matrix of each individual’s information at death or end of loop:
	
	createResultsTable.m


Open the SocialLearning_MainProgram file to toggle parameters:

Line 6 begins the Parameter section of the code:
 

The variable “pc” adjusts the stability of the environment. Range values from 0 to 0.5 to increase the probability of a payoff changing each round.

Parameter “pd” is set to either 0 for a safe environment or 1 for a dangerous environment. A dangerous environment includes an action cost for each act; these are held constant for each run.

The “childhood” condition is set to either 0 for no childhood or 1 for childhood. Note: only the ‘observe’ and ‘mixed’ strategies will include a 10-round childhood when this variable is set to 1. 

For more information about other variables, see the following sections in SocialLearning_MainProgram; each variable will include a comment defining its function.
