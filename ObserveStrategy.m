function [move]=ObserveStrategy(roundsAlive, childhood)

% Strategy S2 (or simple strategy 2) will observe and exploit with 50/50 chance of each

probDie=rand;

if (probDie<=0.02) && (roundsAlive>1) % if the probability of death is less than or equal to 2%, then the indiv dies
    move = 'die';
   
% outputs a move probabilistically (either observe or exploit) 
else
    if (childhood == 1) && (roundsAlive<=10)
        move = 0; 
    else
        probMove = rand;
        if probMove <0.5
            move = 0;
        else 
            move = 1;
        end 
    end
end 
    