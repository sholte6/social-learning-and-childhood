function [results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive, numIndiv, myHistory, myRepertoire, strategy, popKnowledge)

% results (organizes final values of each individual) contains 3 rows:
% row1--> the round in which the individual dies
% row2--> the number of the individual
% row3--> the lifespan of the individual
% row4--> the strategy the individual followed (important for mutation)
% row5--> the total payoff of the individual after numRounds
% row6--> the number of known acts after numRounds
% row7--> fraction of life spent innovating
% row8--> fraction of life spent observing
% row9--> fraction of life spent exploiting

if (roundsAlive-1)>=1 % if the indiv happened to die on the last round, set results portion for them to zero
    roundsAlive=roundsAlive-1;

    results(1,deaths)=rounds;
    results(2,deaths)=numIndiv; % sets the second row of results to the # of Indiv
    results(3,deaths)=roundsAlive; % sets the third row to the indiv's lifespan
    
    results(5,deaths)=(myHistory(5,roundsAlive)); % sets the 4th row to total payoff
    results(6,deaths)=(nnz(myRepertoire(1,:))); % sets the 5th row to the # of known acts
    
    results(7,deaths)=(length(find(myHistory(2,:)==-1)))/roundsAlive; % fraction of innovate
    nnzM = myHistory(:,(myHistory(1,:)~=0));
    results(8,deaths)=(length(find(nnzM(2,:)==0)))/roundsAlive; % fraction of observe
    results(9,deaths)=(length(find(myHistory(2,:)==1)))/roundsAlive; % fraction of exploit
       
    % Input the strategy of the individual upon death (or last round) into
    % results
    if strategy=='strS1'
        results(4,deaths)=1;
    elseif strategy=='strS2'
        results(4,deaths)=2;
    else 
        results(4,deaths)=3;
    end 
    results(4,deaths)=round(results(4,deaths),1);

else % this function is referenced at the end of the loop -- results of individuals 
    % that died before the last round are already in results matrix
    results(1,deaths)=rounds;
    results(2,deaths)=numIndiv;
    results(3,deaths)=0;
    results(5:6,deaths)=0;
    results(7,deaths)=(length(find(myHistory(2,:)==-1)))/roundsAlive; % fraction of innovate
    nnzM = myHistory(:,(myHistory(1,:)~=0));
    results(8,deaths)=(length(find(nnzM(2,:)==0)))/roundsAlive; % fraction of observe
    results(9,deaths)=(length(find(myHistory(2,:)==1)))/roundsAlive; % fraction of exploit
    
    if strategy=='strS1'
        results(4,deaths)=1;
    elseif strategy=='strS2'
        results(4,deaths)=2;
    else 
        results(4,deaths)=3;
    end 
    results(4,deaths)=round(results(4,deaths),1);

end 

popKnowledge(numIndiv,:)=myRepertoire(1,:);
    
    deaths=deaths+1; % increases counter used to set up 'results'