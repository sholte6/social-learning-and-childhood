function [move]=InnovateStrategy(roundsAlive)

% Strategy S1 (or simple strategy 1) will innovate and exploit with 50/50 chance of each

probDie=rand;

if (probDie<=0.02) && (roundsAlive>1) % if the probability of death is less than or equal to 2%, then the indiv dies
    move = 'die';
   
% outputs a move probabilistically (either innovate or exploit) 
else
    probMove = rand;
    if probMove <0.5
        move = -1;
    else 
        move = 1;
    end 
    
end 
    
   