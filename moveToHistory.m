function[myHistory, didExploit, timeInnovate, myRepertoire, roundsAlive, deaths, results, strategy, totPayPop]=moveToHistory(roundsAlive, move, myHistory, myRepertoire, timeInnovate, col, numIndiv, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy)

myHistory(1,roundsAlive)=roundsAlive; % sets first row of myHistory to the round number
po=1; % probability of observe error in payoff and risk
mu=0; % mu is the mean of the uniformly distributed numbers for observe error
sigma=1; % sigma is the stddev of the uniformly distributed numbers for observe error

% timesExp=myHistory(2,:)==1;
% payoffExp=myHistory(4,timesExp);
% sumPayExp=sum(payoffExp);
% totPayPop(1,numIndiv)=(sumPayExp/roundsAlive);
% meanPayPop=sum(totPayPop(1,:));
% Pr=(sumPayExp/roundsAlive)/meanPayPop;
% totPayPop(3,numIndiv)=Pr;

% totPayPop
% row1--> mean lifetime payoff of numIndiv (sumPayExp/roundsAlive)
% row2--> strategy numIndiv is following currently
% row3--> mean lifetime payoff of indiv divided by the sum of all of the indiv in population

% switch move
% case -1
% Note: case/switch code was changed to if/elseif due to case being imcompatible with a version of matlab used at a later time
if move == -1

        myHistory(2,roundsAlive)=-1; % input move of innovate into myHistory

        if timeInnovate<=100 % limit for innovating (learns nothing if all 100 acts are known)
            myHistory(3:4,roundsAlive)=behaviors(1:2,col(1,timeInnovate));
            % selects a the column of the randomized selection of acts and
            % places  both the act and its payoff in myHistory
        else
            myHistory(3:4,roundsAlive)=0; % if all acts are known, can no longer gain more knowledge of behaviors
        end

        if roundsAlive==1 
            myHistory(5,roundsAlive)=0; % on first round, totalPayoff=0 (only gains payoff from exploiting)
            % in dangerous environment, individual receives negative value
            % upon learning 
        else
            myHistory(5,roundsAlive)=myHistory(5,(roundsAlive-1));
            % cummulative payoff from exploiting
        end
        
        timeInnovate=timeInnovate+1; % counter for # of times innovating (can't learn after knowing all 100 acts)

        if myHistory(3,roundsAlive)>0 % if indiv learned a new act in current round
            myRepertoire(1:2,myHistory(3,roundsAlive)) = myHistory(3:4,roundsAlive); 
            myRepertoire(3,myHistory(3,roundsAlive))=behaviors(3,(myHistory(3,roundsAlive)));
            % puts the learned act and its payoff into a separate array, myRepertoire
        end
         
        if myHistory(4,roundsAlive)<0
            myHistory(5,roundsAlive)=myRepertoire(3,roundsAlive)+myHistory(5,roundsAlive);
        end
        % if indiv learned a "dangerous" act, put negative payoff in
        % cumulative payoff row of myHistory
        
        % Input strategy code (1, 2, or 3) into results and totPayPop
        % matrices for extracting strategy results after each loop
        if strategy=='strS1'
            results(4,deaths)=1;
            totPayPop(2,numIndiv)=1;
        elseif strategy=='strS2'
            results(4,deaths)=2;
            totPayPop(2,numIndiv)=2;
        else 
            results(4,deaths)=3;
            totPayPop(2,numIndiv)=3;
        end
        
%     case 0 % if strategy outputs observe
elseif move == 0

        if rounds==1
            myHistory(2:5)=0; % input move of observe into myHistory
        else 
        myHistory(2,roundsAlive)=0; % sets myHistory to the particular move corresponding with the round

        notMe=(didExploit(1,:)~=numIndiv);
        allOthers=didExploit(:,notMe);
        nnzObs=allOthers(:,(allOthers(3,:)~=0));
        expPrevious=(nnzObs(6,:)==(rounds-1));
        possibleObs=nnzObs(:,expPrevious);
        % looks only at the acts & their payoff from those who exploited in
        % previous round (excluding individual themself)     

        if isempty(possibleObs)==0 % if there are individuals that exploited in the past round
            
            indicesAllowKnow=(possibleObs(3,:)<=100);
            allowedKnowledge=possibleObs(:,indicesAllowKnow);
            
            if length(allowedKnowledge)>0
                
% Observe Random
                obsData = randperm(length(allowedKnowledge(1,:)),1); 
                % randomly selects from those that exploited previously
                myHistory(3,roundsAlive)=allowedKnowledge(3,obsData); 
                % places the act into myHistory
                myHistory(4,roundsAlive)=behaviors(2,(myHistory(3,roundsAlive))); 
                % places the updated payoff of observed act into myHistory

            else 
                myHistory(3:4,roundsAlive)=0; 
                % if there are no other individuals that exploited in the 
                % previous round, individual can not observe new information
            end 
                
        
        else 
            myHistory(3:4,roundsAlive)=0;
            % if no individuals exploited in last round, gains no new knowledge from observing
        end
        
        if roundsAlive>1
            myHistory(5,roundsAlive)=myHistory(5,(roundsAlive-1)); % cummulative summation of payoff from exploiting
        else 
            myHistory(5,roundsAlive)=0;
        end 
        
        if myHistory(3,roundsAlive)>0 % if indiv learned a new act in current round
            myRepertoire(1:2,myHistory(3,roundsAlive)) = myHistory(3:4,roundsAlive); 
            myRepertoire(3,myHistory(3,roundsAlive))=behaviors(3,(myHistory(3,roundsAlive)));
            % puts the learned act and its payoff into a separate array, myRepertoire
        end
        
            prob=rand; % used to determine observe error in the payoff with given probability, po
            if (prob<=po) && (myHistory(3,roundsAlive)~=0)
                r=abs(round(normrnd(mu,sigma))); % gives a random value with a mean of 0 and stddev of 1
                myRepertoire(2,(myHistory(3,roundsAlive)))=(myHistory(4,roundsAlive)+r); % adds the error to the observed payoff
            end % ends observe error portion for payoff
            
            prob1=rand; % used to determine observe error in the risk with the same given probability, po
            if (prob1<=po) && (myHistory(3,roundsAlive)~=0)
                s=round(normrnd(mu,sigma)); % gives a random value with a mean of 0 and stddev of 1
                if (myRepertoire(3,(myHistory(3,roundsAlive)))+s)<=0
                    myRepertoire(3,(myHistory(3,roundsAlive)))=myRepertoire(3,(myHistory(3,roundsAlive)))+s; 
                    % adds the error to the observed risk
                else 
                    myRepertoire(3,(myHistory(3,roundsAlive)))=-1*(myRepertoire(3,(myHistory(3,roundsAlive)))+s);
                    % if the value of s made the risk positive, change to negative (preserve concept of risk)
                end                 
            end % ends observe error portion for risk
        end 
        
        
        % Input strategy code (1, 2, or 3) into results and totPayPop
        % matrices for extracting strategy results after each loop
        if strategy=='strS1'
            results(4,deaths)=1;
            totPayPop(2,numIndiv)=1;
        elseif strategy=='strS2'
            results(4,deaths)=2;
            totPayPop(2,numIndiv)=2;
        else 
            results(4,deaths)=3;
            totPayPop(2,numIndiv)=3;
        end

%     case 1 % if strategy outputs exploit, exploit the act with highest known payoff
elseif move == 1

         myHistory(2,roundsAlive)=1; % input move of exploit into myHistory
        
        if roundsAlive == 1
            myHistory(3:5,roundsAlive)=0;
            % individual can not exploit information on their first round
            % alive because they will not have learned anything yet
        else 
            
        % Version 3 of Dangerous Environments -- Ranks the sum of reward and payoff to determine act to exploit    
        indices = myRepertoire(1,:)~=0; % looks at only known acts to rank payoff for
        nonzeros = myRepertoire(:,indices);
        rankedSum = sortrows(nonzeros',-4); % ranks sum of reward and dangerous payoff
        if isempty(rankedSum)==0
            expAct=rankedSum(1,1); % selects the act with the highest sum
            myHistory(3,roundsAlive)=expAct; % puts exploited act in myHistory
            myHistory(4,roundsAlive)=behaviors(2,expAct); % puts updated payoff of the exploited act into myHistory
            myHistory(5,roundsAlive)=(myHistory(5,(roundsAlive-1)))+(behaviors(2,expAct))+(behaviors(3,expAct));
            % if exploiting a dangerous payoff, receive reward + negative
            % payoff --> cumulative with previous rounds
            didExploit(2,numIndiv)=roundsAlive; % adds to array used for observe to determine when indivs exploit
            didExploit(3:4,numIndiv)=myHistory(3:4,roundsAlive);
            didExploit(6,numIndiv)=rounds;
        else 
            myHistory(3:4,roundsAlive) = 0;
            myHistory(5,roundsAlive)=myHistory(5,(roundsAlive-1));
        end 
   
        end

        if myHistory(3,roundsAlive)>0 % if indiv learned updated payoff of act, put in rep.
           myRepertoire(1:2,myHistory(3,roundsAlive)) = myHistory(3:4,roundsAlive); 
           myRepertoire(3,myHistory(3,roundsAlive))=behaviors(3,(myHistory(3,roundsAlive)));
           % puts the learned act and its payoff into a separate array, myRepertoire
        end
        
        % Input strategy code (1, 2, or 3) into results and totPayPop
        % matrices for extracting strategy results after each loop
        if strategy=='strS1'
            results(4,deaths)=1;
            totPayPop(2,numIndiv)=1;
            didExploit(5,numIndiv)=1;
        elseif strategy=='strS2'
            results(4,deaths)=2;
            totPayPop(2,numIndiv)=2;
            didExploit(5,numIndiv)=2;
        else
            results(4,deaths)=3;
            totPayPop(2,numIndiv)=3;
            didExploit(5,numIndiv)=3;
        end
        
%     case 'die' % if the indiv dies on this round,
elseif move =='die'

    % Input information of individual into results matrix
        results(1,deaths)=(rounds-1); % Inputs round in loop where individual dies
        results(2,deaths)=numIndiv; % Inputs the individual's number
        results(3,deaths)=(roundsAlive-1); % Inputs the "age" or roundsAlive of the individual
        results(5,deaths)=(myHistory(5,(roundsAlive-1))); % Inputs accumulated payoff
        results(6,deaths)=(nnz(myRepertoire(1,:))); % Inputs acts learned
        results(7,deaths)=(length(find(myHistory(2,:)==-1)))/roundsAlive; % Determines fraction of innovate
        nnzM = myHistory(:,(myHistory(1,:)~=0));
        results(8,deaths)=(length(find(nnzM(2,:)==0)))/roundsAlive; % Determines fraction of observe
        results(9,deaths)=(length(find(myHistory(2,:)==1)))/roundsAlive; % Determines fraction of exploit
        
        % Input strategy code (1, 2, or 3) into results and totPayPop
        % matrices for extracting strategy results after each loop
        if strategy=='strS1'
            results(4,deaths)=1;
            totPayPop(2,numIndiv)=1;
        elseif strategy=='strS2'
            results(4,deaths)=2;
            totPayPop(2,numIndiv)=2;
        else 
            results(4,deaths)=3;
            totPayPop(2,numIndiv)=3;
        end
        
        % Initialize a second totPayPop matrix for determining strategy of
        % offspring of individual (essentially what strategy the individual
        % will be replaced with)
        totPayPop2=zeros(3,60); % 3 rows by the number of individuals
        totPayPop2(1:2,:)=totPayPop(1:2,:);
     
        for k=1:60 % number of individuals
        if totPayPop(3,k)<0
            totPayPop2(3,k)=0;
        else 
            totPayPop2(3,k)=totPayPop(3,k);
        end 
        end 
            
        % Each individual contributes a given amount of a probability
        % depending on their mean lifetime payoff. For individuals will
        % higher mean lifetime payoff, the more successful they are. Thus,
        % the higher likelihood that this individual will obtain the
        % strategy of the more successful individuals. 
        for b=1
            whatStrat=rand;
            if sum(totPayPop2(3,:))==0
                break
            elseif whatStrat<=(totPayPop2(3,1))
                strategy=totPayPop(2,1);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:2)))
                strategy=totPayPop(2,2);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:3)))
                strategy=totPayPop(2,3);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:4)))
                strategy=totPayPop(2,4);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:5)))
                strategy=totPayPop(2,5);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:6)))
                strategy=totPayPop(2,6);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:7)))
                strategy=totPayPop(2,7);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:8)))
                strategy=totPayPop(2,8);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:9)))  
                strategy=totPayPop(2,9);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:10)))
                strategy=totPayPop(2,10);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:11)))
                strategy=totPayPop(2,11);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:12)))
                strategy=totPayPop(2,12);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:13)))
                strategy=totPayPop(2,13);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:14)))
                strategy=totPayPop(2,14);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:15)))
                strategy=totPayPop(2,15);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:16)))
                strategy=totPayPop(2,16);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:17)))
                strategy=totPayPop(2,17);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:18)))
                strategy=totPayPop(2,18);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:19)))  
                strategy=totPayPop(2,19);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:20))) 
                strategy=totPayPop(2,20);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:21)))
                strategy=totPayPop(2,21);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:22)))
                strategy=totPayPop(2,22);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:23)))
                strategy=totPayPop(2,23);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:24)))
                strategy=totPayPop(2,24);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:25)))
                strategy=totPayPop(2,25);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:26)))
                strategy=totPayPop(2,26);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:27)))
                strategy=totPayPop(2,27);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:28)))
                strategy=totPayPop(2,28);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:29)))  
                strategy=totPayPop(2,29);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:30)))
                strategy=totPayPop(2,30);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:31)))
                strategy=totPayPop(2,31);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:32)))
                strategy=totPayPop(2,32);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:33)))
                strategy=totPayPop(2,33);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:34)))
                strategy=totPayPop(2,34);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:35)))
                strategy=totPayPop(2,35);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:36)))
                strategy=totPayPop(2,36);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:37)))
                strategy=totPayPop(2,37);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:38)))
                strategy=totPayPop(2,38);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:39)))  
                strategy=totPayPop(2,39);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:40)))
                strategy=totPayPop(2,40);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:41)))
                strategy=totPayPop(2,41);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:42)))
                strategy=totPayPop(2,42);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:43)))
                strategy=totPayPop(2,43);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:44)))
                strategy=totPayPop(2,44);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:45)))
                strategy=totPayPop(2,45);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:46)))
                strategy=totPayPop(2,46);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:47)))
                strategy=totPayPop(2,47);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:48)))
                strategy=totPayPop(2,48);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:49)))  
                strategy=totPayPop(2,49);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:50)))
                strategy=totPayPop(2,50);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:51)))
                strategy=totPayPop(2,51);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:52)))
                strategy=totPayPop(2,52);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:53)))
                strategy=totPayPop(2,53);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:54)))
                strategy=totPayPop(2,54);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:55)))
                strategy=totPayPop(2,55);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:56)))
                strategy=totPayPop(2,56);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:57)))
                strategy=totPayPop(2,57);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:58)))
                strategy=totPayPop(2,58);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:59)))  
                strategy=totPayPop(2,59);
                break
            elseif whatStrat<=(sum(totPayPop2(3,1:60)))
                strategy=totPayPop(2,60);
                break
            else 
                
            end  
            
        end 
        
        % Assigns the code of the strategy to the individual for further
        % rounds
        if strategy==1
            strategy='strS1';
        elseif strategy==2
            strategy='strS2';
        else 
            strategy='strS3';
        end
        
        deaths=deaths+1; % increase number of population deaths -- determines column of matrix in results of each individual that dies
        roundsAlive=0; % reinitializes "age" of individual
        timeInnovate=1; % reinitializes counter for the innovate section of code

        % Reinitialize individual's matrices 
        myHistory=zeros(5,numRounds);
        myRepertoire=zeros(4,100); 

end 

% Inputs mean lifetime payoff value (total accumulated payoff divided by
% their rounds alive) of the individual into totPayPop matrix
if roundsAlive>0
    totPayPop(1,numIndiv)=((myHistory(5,roundsAlive))/roundsAlive);
else 
    totPayPop(1,numIndiv)=0;
end 

meanPayPop=sum(totPayPop(1,:));
totPayPop(3,:)=totPayPop(1,:)./(abs(meanPayPop));
roundsAlive=roundsAlive+1; % increases counter for roundsAlive for indiv

myRepertoire(4,:)=myRepertoire(2,:)+myRepertoire(3,:); % add sum of risk and payoff for each known act into row 4 of myRepertoire

clear move;



