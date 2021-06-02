function [move]=MixedStrategy(roundsAlive, childhood)

% Strategy S3 (or simple 3) will innovate/observe with a 25% chance of
% each, then exploit with a 50% chance

probDie=rand;

if (probDie<=0.02) && (roundsAlive>1) % if the probability of death is less than or equal to 2%, then the indiv dies
    move = 'die';
     
% outputs a move probabilistically (either innovate, observe, or exploit) 
else
    if (childhood == 1) && (roundsAlive<=10)
        probMove = rand;
        if probMove<=0.5
            move = -1;
        else 
            move = 0;
        end 
    else
        probMove = rand;
        if probMove <0.25
            move = -1;
        elseif probMove <0.5
            move = 0;
        else 
            move = 1;
        end  
    end   
end 
    