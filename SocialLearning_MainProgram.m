% SocialLearning_MainProgram uses Simple Strategies with 60 total individuals, 
% changes values of payoff for each round with a probability of pc,
% includes a "dangerous environment", with negative risk


%% Parameters 
pc=0.2; % Change in environmental conditions (probability of payoff changing each round)
pd=1; % Set to 1 for dangerous environment, 0 for safe environment
childhood = 1; % Set to 1 for "with childhood", 0 for "no childhood"
numRounds=2000; % The number of rounds 
numLoops=100; % The number of loops of each set of a given number of rounds (above)

%% Matrix Contents
% myHistory (applies to all individuals) contains 5 rows:
% row1--> Round Number
% row2--> Move used during that round (-1=innovate, 0=observe, 1=exploit)
% row3--> random act (for innovate) or exploited act (receives immediate payoff) or observed act
% row4--> corresponding payoff to known act (receives updated payoff from behaviors)
% row5--> cummulative summation of payoffs from exploiting (last column = total payoff)

% myRepertoire (applies to all individuals) contains 3 rows:
% row1--> known acts in chronological order (zeros are unknown behaviors)
% row2--> corresponding payoff of known acts
% row3--> corresponding risk of known acts
% row4--> sum of payoff and risk

% didExploit 
% row1--> number of individual 
% row2--> rounds alive
% row3--> act exploited
% row4--> corresponding payoff of act
% row5--> strategy of individual
% row6--> round 

% results (organizes final values of each individual) contains 3 rows:
% row1--> the round in which the individual dies
% row2--> the number of the individual
% row3--> the lifespan of the individual
% row4--> the strategy the individual followed (important for mutation)
% row5--> the total payoff of the individual after numRounds
% row6--> the number of known acts after numRounds

loop=1; % initializes loop 
strategyResults=zeros(numLoops,4); % creates a results matrix to add individual's info after death or at the end of the loop
strategyResults(:,1)=(1:numLoops); 
fractionMove = zeros(numLoops,10);
fractionMove(:,1)=(1:numLoops);
MLP = zeros(numLoops,4);
MLP(:,1)=(1:numLoops);

 
while loop<=numLoops

rounds=1; % initializes rounds
totIndiv=60; % total number of individuals
numActs = 100; % total number of acts/pieces of knowledge
behaviors=zeros(3,numActs); % "God's repertoire"--all knowing of acts and corresponding payoffs
behaviors(1,:)=1:numActs; % assigns first row to the number of each act 
didExploit=zeros(6,totIndiv); % used in 'move' function to determine observe values
didExploit(1,:)=1:totIndiv; % sets first row to each individual's number
a=1; % acts as a counter for a while loop to create behaviors array 
results=zeros(9,300); % creates an array to display results (see note above)
deaths=1; % sets a counter for the number of deaths to help create results array
totPayPop=zeros(3,totIndiv); 
popKnowledge=zeros((totIndiv+1),numActs);


% Individual 1 
numIndiv1=1; % Individual's number
roundsAlive1=1; % initializes num of rounds indiv lives for 
myHistory1=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire1=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate1=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col1=randperm(numActs); % creates a way to randomly select an act 1-100
strategy1='strS1';

% Individual 2 
numIndiv2=2; % Individual's number
roundsAlive2=1; % initializes num of rounds indiv lives for 
myHistory2=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire2=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate2=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col2=randperm(numActs); % creates a way to randomly select an act 1-100
strategy2='strS1';

% Individual 3 
numIndiv3=3; % Individual's number
roundsAlive3=1; % initializes num of rounds indiv lives for 
myHistory3=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire3=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate3=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col3=randperm(numActs); % creates a way to randomly select an act 1-100
strategy3='strS1';

% Individual 4 
numIndiv4=4; % Individual's number
roundsAlive4=1; % initializes num of rounds indiv lives for 
myHistory4=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire4=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate4=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col4=randperm(numActs); % creates a way to randomly select an act 1-100
strategy4='strS1';

% Individual 5 
numIndiv5=5; % Individual's number
roundsAlive5=1; % initializes num of rounds indiv lives for 
myHistory5=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire5=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate5=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col5=randperm(numActs); % creates a way to randomly select an act 1-100
strategy5='strS1';

% Individual 6 
numIndiv6=6; % Individual's number
roundsAlive6=1; % initializes num of rounds indiv lives for 
myHistory6=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire6=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate6=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col6=randperm(numActs); % creates a way to randomly select an act 1-100
strategy6='strS1';

% Individual 7 
numIndiv7=7; % Individual's number
roundsAlive7=1; % initializes num of rounds indiv lives for 
myHistory7=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire7=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate7=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col7=randperm(numActs); % creates a way to randomly select an act 1-100
strategy7='strS1';

% Individual 8
numIndiv8=8; % Individual's number
roundsAlive8=1; % initializes num of rounds indiv lives for 
myHistory8=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire8=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate8=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col8=randperm(numActs); % creates a way to randomly select an act 1-100
strategy8='strS1';

% Individual 9 
numIndiv9=9; % Individual's number
roundsAlive9=1; % initializes num of rounds indiv lives for 
myHistory9=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire9=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate9=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col9=randperm(numActs); % creates a way to randomly select an act 1-100
strategy9='strS1';

% Individual 10
numIndiv10=10; % Individual's number
roundsAlive10=1; % initializes num of rounds indiv lives for 
myHistory10=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire10=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate10=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col10=randperm(numActs); % creates a way to randomly select an act 1-100
strategy10='strS1';

% Individual 11 
numIndiv11=11; % Individual's number
roundsAlive11=1; % initializes num of rounds indiv lives for 
myHistory11=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire11=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate11=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col11=randperm(numActs); % creates a way to randomly select an act 1-100
strategy11='strS1';

% Individual 12 
numIndiv12=12; % Individual's number
roundsAlive12=1; % initializes num of rounds indiv lives for 
myHistory12=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire12=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate12=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col12=randperm(numActs); % creates a way to randomly select an act 1-100
strategy12='strS1';

% Individual 13 
numIndiv13=13; % Individual's number
roundsAlive13=1; % initializes num of rounds indiv lives for 
myHistory13=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire13=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate13=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col13=randperm(numActs); % creates a way to randomly select an act 1-100
strategy13='strS1';

% Individual 14 
numIndiv14=14; % Individual's number
roundsAlive14=1; % initializes num of rounds indiv lives for 
myHistory14=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire14=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate14=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col14=randperm(numActs); % creates a way to randomly select an act 1-100
strategy14='strS1';

% Individual 15 
numIndiv15=15; % Individual's number
roundsAlive15=1; % initializes num of rounds indiv lives for 
myHistory15=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire15=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate15=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col15=randperm(numActs); % creates a way to randomly select an act 1-100
strategy15='strS1';

% Individual 16 
numIndiv16=16; % Individual's number
roundsAlive16=1; % initializes num of rounds indiv lives for 
myHistory16=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire16=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate16=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col16=randperm(numActs); % creates a way to randomly select an act 1-100
strategy16='strS1';

% Individual 17 
numIndiv17=17; % Individual's number
roundsAlive17=1; % initializes num of rounds indiv lives for 
myHistory17=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire17=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate17=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col17=randperm(numActs); % creates a way to randomly select an act 1-100
strategy17='strS1';

% Individual 18 
numIndiv18=18; % Individual's number
roundsAlive18=1; % initializes num of rounds indiv lives for 
myHistory18=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire18=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate18=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col18=randperm(numActs); % creates a way to randomly select an act 1-100
strategy18='strS1';

% Individual 19 
numIndiv19=19; % Individual's number
roundsAlive19=1; % initializes num of rounds indiv lives for 
myHistory19=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire19=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate19=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col19=randperm(numActs); % creates a way to randomly select an act 1-100
strategy19='strS1';

% Individual 20
numIndiv20=20; % Individual's number
roundsAlive20=1; % initializes num of rounds indiv lives for 
myHistory20=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire20=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate20=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col20=randperm(numActs); % creates a way to randomly select an act 1-100
strategy20='strS1';

% Individual 21 
numIndiv21=21; % Individual's number
roundsAlive21=1; % initializes num of rounds indiv lives for 
myHistory21=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire21=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate21=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col21=randperm(numActs); % creates a way to randomly select an act 1-100
strategy21='strS2';

% Individual 22
numIndiv22=22; % Individual's number
roundsAlive22=1; % initializes num of rounds indiv lives for 
myHistory22=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire22=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate22=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col22=randperm(numActs); % creates a way to randomly select an act 1-100
strategy22='strS2';

% Individual 23 
numIndiv23=23; % Individual's number
roundsAlive23=1; % initializes num of rounds indiv lives for 
myHistory23=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire23=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate23=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col23=randperm(numActs); % creates a way to randomly select an act 1-100
strategy23='strS2';

% Individual 24 
numIndiv24=24; % Individual's number
roundsAlive24=1; % initializes num of rounds indiv lives for 
myHistory24=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire24=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate24=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col24=randperm(numActs); % creates a way to randomly select an act 1-100
strategy24='strS2';

% Individual 25 
numIndiv25=25; % Individual's number
roundsAlive25=1; % initializes num of rounds indiv lives for 
myHistory25=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire25=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate25=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col25=randperm(numActs); % creates a way to randomly select an act 1-100
strategy25='strS2';

% Individual 26 
numIndiv26=26; % Individual's number
roundsAlive26=1; % initializes num of rounds indiv lives for 
myHistory26=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire26=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate26=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col26=randperm(numActs); % creates a way to randomly select an act 1-100
strategy26='strS2';

% Individual 27 
numIndiv27=27; % Individual's number
roundsAlive27=1; % initializes num of rounds indiv lives for 
myHistory27=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire27=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate27=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col27=randperm(numActs); % creates a way to randomly select an act 1-100
strategy27='strS2';

% Individual 28 
numIndiv28=28; % Individual's number
roundsAlive28=1; % initializes num of rounds indiv lives for 
myHistory28=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire28=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate28=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col28=randperm(numActs); % creates a way to randomly select an act 1-100
strategy28='strS2';

% Individual 29 
numIndiv29=29; % Individual's number
roundsAlive29=1; % initializes num of rounds indiv lives for 
myHistory29=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire29=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate29=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col29=randperm(numActs); % creates a way to randomly select an act 1-100
strategy29='strS2';

% Individual 30 
numIndiv30=30; % Individual's number
roundsAlive30=1; % initializes num of rounds indiv lives for 
myHistory30=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire30=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate30=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col30=randperm(numActs); % creates a way to randomly select an act 1-100
strategy30='strS2';

% Individual 31 
numIndiv31=31; % Individual's number
roundsAlive31=1; % initializes num of rounds indiv lives for 
myHistory31=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire31=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate31=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col31=randperm(numActs); % creates a way to randomly select an act 1-100
strategy31='strS2';

% Individual 32 
numIndiv32=32; % Individual's number
roundsAlive32=1; % initializes num of rounds indiv lives for 
myHistory32=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire32=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate32=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col32=randperm(numActs); % creates a way to randomly select an act 1-100
strategy32='strS2';

% Individual 33 
numIndiv33=33; % Individual's number
roundsAlive33=1; % initializes num of rounds indiv lives for 
myHistory33=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire33=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate33=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col33=randperm(numActs); % creates a way to randomly select an act 1-100
strategy33='strS2';

% Individual 34 
numIndiv34=34; % Individual's number
roundsAlive34=1; % initializes num of rounds indiv lives for 
myHistory34=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire34=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate34=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col34=randperm(numActs); % creates a way to randomly select an act 1-100
strategy34='strS2';

% Individual 35 
numIndiv35=35; % Individual's number
roundsAlive35=1; % initializes num of rounds indiv lives for 
myHistory35=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire35=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate35=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col35=randperm(numActs); % creates a way to randomly select an act 1-100
strategy35='strS2';

% Individual 36
numIndiv36=36; % Individual's number
roundsAlive36=1; % initializes num of rounds indiv lives for 
myHistory36=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire36=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate36=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col36=randperm(numActs); % creates a way to randomly select an act 1-100
strategy36='strS2';

% Individual 37 
numIndiv37=37; % Individual's number
roundsAlive37=1; % initializes num of rounds indiv lives for 
myHistory37=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire37=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate37=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col37=randperm(numActs); % creates a way to randomly select an act 1-100
strategy37='strS2';

% Individual 38 
numIndiv38=38; % Individual's number
roundsAlive38=1; % initializes num of rounds indiv lives for 
myHistory38=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire38=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate38=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col38=randperm(numActs); % creates a way to randomly select an act 1-100
strategy38='strS2';

% Individual 39 
numIndiv39=39; % Individual's number
roundsAlive39=1; % initializes num of rounds indiv lives for 
myHistory39=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire39=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate39=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col39=randperm(numActs); % creates a way to randomly select an act 1-100
strategy39='strS2';

% Individual 40 
numIndiv40=40; % Individual's number
roundsAlive40=1; % initializes num of rounds indiv lives for 
myHistory40=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire40=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate40=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col40=randperm(numActs); % creates a way to randomly select an act 1-100
strategy40='strS2';

% Individual 41
numIndiv41=41; % Individual's number
roundsAlive41=1; % initializes num of rounds indiv lives for 
myHistory41=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire41=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate41=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col41=randperm(numActs); % creates a way to randomly select an act 1-100
strategy41='strS3';

% Individual 42 
numIndiv42=42; % Individual's number
roundsAlive42=1; % initializes num of rounds indiv lives for 
myHistory42=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire42=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate42=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col42=randperm(numActs); % creates a way to randomly select an act 1-100
strategy42='strS3';

% Individual 43 
numIndiv43=43; % Individual's number
roundsAlive43=1; % initializes num of rounds indiv lives for 
myHistory43=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire43=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate43=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col43=randperm(numActs); % creates a way to randomly select an act 1-100
strategy43='strS3';

% Individual 44 
numIndiv44=44; % Individual's number
roundsAlive44=1; % initializes num of rounds indiv lives for 
myHistory44=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire44=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate44=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col44=randperm(numActs); % creates a way to randomly select an act 1-100
strategy44='strS3';

% Individual 45 
numIndiv45=45; % Individual's number
roundsAlive45=1; % initializes num of rounds indiv lives for 
myHistory45=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire45=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate45=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col45=randperm(numActs); % creates a way to randomly select an act 1-100
strategy45='strS3';

% Individual 46 
numIndiv46=46; % Individual's number
roundsAlive46=1; % initializes num of rounds indiv lives for 
myHistory46=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire46=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate46=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col46=randperm(numActs); % creates a way to randomly select an act 1-100
strategy46='strS3';

% Individual 47 
numIndiv47=47; % Individual's number
roundsAlive47=1; % initializes num of rounds indiv lives for 
myHistory47=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire47=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate47=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col47=randperm(numActs); % creates a way to randomly select an act 1-100
strategy47='strS3';

% Individual 48 
numIndiv48=48; % Individual's number
roundsAlive48=1; % initializes num of rounds indiv lives for 
myHistory48=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire48=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate48=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col48=randperm(numActs); % creates a way to randomly select an act 1-100
strategy48='strS3';

% Individual 49 
numIndiv49=49; % Individual's number
roundsAlive49=1; % initializes num of rounds indiv lives for 
myHistory49=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire49=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate49=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col49=randperm(numActs); % creates a way to randomly select an act 1-100
strategy49='strS3';

% Individual 50 
numIndiv50=50; % Individual's number
roundsAlive50=1; % initializes num of rounds indiv lives for 
myHistory50=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire50=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate50=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col50=randperm(numActs); % creates a way to randomly select an act 1-100
strategy50='strS3';

% Individual 51 
numIndiv51=51; % Individual's number
roundsAlive51=1; % initializes num of rounds indiv lives for 
myHistory51=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire51=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate51=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col51=randperm(numActs); % creates a way to randomly select an act 1-100
strategy51='strS3';

% Individual 52 
numIndiv52=52; % Individual's number
roundsAlive52=1; % initializes num of rounds indiv lives for 
myHistory52=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire52=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate52=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col52=randperm(numActs); % creates a way to randomly select an act 1-100
strategy52='strS3';

% Individual 53 
numIndiv53=53; % Individual's number
roundsAlive53=1; % initializes num of rounds indiv lives for 
myHistory53=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire53=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate53=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col53=randperm(numActs); % creates a way to randomly select an act 1-100
strategy53='strS3';

% Individual 54 
numIndiv54=54; % Individual's number
roundsAlive54=1; % initializes num of rounds indiv lives for 
myHistory54=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire54=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate54=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col54=randperm(numActs); % creates a way to randomly select an act 1-100
strategy54='strS3';

% Individual 55 
numIndiv55=55; % Individual's number
roundsAlive55=1; % initializes num of rounds indiv lives for 
myHistory55=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire55=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate55=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col55=randperm(numActs); % creates a way to randomly select an act 1-100
strategy55='strS3';

% Individual 56 
numIndiv56=56; % Individual's number
roundsAlive56=1; % initializes num of rounds indiv lives for 
myHistory56=zeros(5,numRounds); % zeros array for myHistory1 w/ 4 rows by numRounds columns
myRepertoire56=zeros(3,numActs); % zeros array for myRepertoire1 w/ 3 rows by numRounds columns
timeInnovate56=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col56=randperm(numActs); % creates a way to randomly select an act 1-100
strategy56='strS3';

% Individual 57
numIndiv57=57; % Individual's number
roundsAlive57=1; % initializes num of rounds indiv lives for 
myHistory57=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire57=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate57=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col57=randperm(numActs); % creates a way to randomly select an act 1-100
strategy57='strS3';

% Individual 58 
numIndiv58=58; % Individual's number
roundsAlive58=1; % initializes num of rounds indiv lives for 
myHistory58=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire58=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate58=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col58=randperm(numActs); % creates a way to randomly select an act 1-100
strategy58='strS3';

% Individual 59 
numIndiv59=59; % Individual's number
roundsAlive59=1; % initializes num of rounds indiv lives for 
myHistory59=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire59=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate59=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col59=randperm(numActs); % creates a way to randomly select an act 1-100
strategy59='strS3';

% Individual 60 
numIndiv60=60; % Individual's number
roundsAlive60=1; % initializes num of rounds indiv lives for 
myHistory60=zeros(5,numRounds); % zeros array for myHistory2 w/ 4 rows by numRounds columns
myRepertoire60=zeros(3,numActs); % zeros array for myRepertoire2 w/ 3 rows by numRounds columns
timeInnovate60=1; % counter for # of times innovating (can no longer learn from innovate if all acts are known)
col60=randperm(numActs); % creates a way to randomly select an act 1-100
strategy60='strS3';


while rounds<=numRounds % creates  a loop for the function to continue until end of numRounds
 
    while a<=100 % creates a loop for the creation of "behavior" array or "God's Repertoire" 
                 % but allows the values of Payoff to change after each round with probability of pc
                                 
        if rounds==1 % on first round, create initial behavior array
           y=exprnd(1); % creates random value from exp. dist.
           Payoff=round(y.^2)*2; % squares, doubles, and rounds (to int) values of y for the Payoff array
                  
           if Payoff < 50 % sets a limit for the value of Payoff (50)

               y2=exprnd(1);
               risk=round(y2.^2)*2; 
               probDanger = rand;
               if (probDanger<=pd)&&(risk<50)
                   risk=-1*risk; % assigns a risk value for an act if within the danger probability 
               else 
                   risk=0;
               end

                behaviors(2,a)=Payoff;
                behaviors(3,a)=risk;
               % creates behavior array (known only to "God") of acts 1-100 & a corresponding payoff 
               a=a+1;
               % increases 'a' to continue loop until matrix fills to 100 acts
           end % ends payoff change
           
        else    
            probability=rand;
            if probability<=pc % if random value is less than or equal to 0.1 (10%), then change value of payoff
                y=exprnd(1); % creates random value from exp. dist.
                Payoff=round(y.^2)*2; % squares, doubles, and rounds (to int) values of y for the Payoff array
        
                if Payoff < 50 % sets a limit for the value of Payoff (50)
                    behaviors(2,a)=Payoff;
                    a=a+1;
                    % increases 'a' to continue loop until matrix fills to 100 acts
                end % ends payoff change
             else
                behaviors(2,a)=behaviors(2,a);
                a=a+1;
             end % end probability of each payoff value
        end % ends if loop determining if first round
    end % ends while loop of counter 'a'

    a=1; % resets the counter for the next round
    
    % The next section sends each individual to their designated strategy function where "move" is output
    % Then, the move of the individual is sent to the moveToHistory
    % function, where the move determines the act, payoff, and risk learned
    % in that round. These values are inputted into the individual's
    % information matrices (myHistory, myRepertoire). 

% individual 1
if strategy1=='strS1'
    [move]=InnovateStrategy(roundsAlive1);
elseif strategy1=='strS2'
    [move]=ObserveStrategy(roundsAlive1, childhood);
else
    [move]=MixedStrategy(roundsAlive1, childhood);
end
[myHistory1, didExploit, timeInnovate1, myRepertoire1, roundsAlive1, deaths, results, strategy1, totPayPop]=moveToHistory(roundsAlive1, move, myHistory1, myRepertoire1, timeInnovate1, col1, numIndiv1, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy1);                                        
    

% individual 2 
if strategy2=='strS1'
    [move]=InnovateStrategy(roundsAlive2);
elseif strategy2=='strS2'
    [move]=ObserveStrategy(roundsAlive2, childhood);
else    
    [move]=MixedStrategy(roundsAlive2, childhood);
end
[myHistory2, didExploit, timeInnovate2, myRepertoire2, roundsAlive2, deaths, results, strategy2, totPayPop]=moveToHistory(roundsAlive2, move, myHistory2, myRepertoire2, timeInnovate2, col2, numIndiv2, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy2);         


% individual 3 
if strategy3=='strS1'    
    [move]=InnovateStrategy(roundsAlive3);
elseif strategy3=='strS2'   
    [move]=ObserveStrategy(roundsAlive3, childhood);
else    
    [move]=MixedStrategy(roundsAlive3, childhood);
end
[myHistory3, didExploit, timeInnovate3, myRepertoire3, roundsAlive3, deaths, results, strategy3, totPayPop]=moveToHistory(roundsAlive3, move, myHistory3, myRepertoire3, timeInnovate3, col3, numIndiv3, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy3);    


% individual 4 
if strategy4=='strS1'    
    [move]=InnovateStrategy(roundsAlive4);
elseif strategy4=='strS2'
    [move]=ObserveStrategy(roundsAlive4, childhood);
else    
    [move]=MixedStrategy(roundsAlive4,  childhood);
end
[myHistory4, didExploit, timeInnovate4, myRepertoire4, roundsAlive4, deaths, results, strategy4, totPayPop]=moveToHistory(roundsAlive4, move, myHistory4, myRepertoire4, timeInnovate4, col4, numIndiv4, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy4);


% individual 5 
if strategy5=='strS1'
    [move]=InnovateStrategy(roundsAlive5);
elseif strategy5=='strS2'
    [move]=ObserveStrategy(roundsAlive5, childhood);
else 
    [move]=MixedStrategy(roundsAlive5, childhood);
end
[myHistory5, didExploit, timeInnovate5, myRepertoire5, roundsAlive5, deaths, results, strategy5, totPayPop]=moveToHistory(roundsAlive5, move, myHistory5, myRepertoire5, timeInnovate5, col5, numIndiv5, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy5);


% individual 6 
if strategy6=='strS1'
    [move]=InnovateStrategy(roundsAlive6);
elseif strategy6=='strS2'
    [move]=ObserveStrategy(roundsAlive6, childhood);
else 
    [move]=MixedStrategy(roundsAlive6, childhood);
end
[myHistory6, didExploit, timeInnovate6, myRepertoire6, roundsAlive6, deaths, results, strategy6, totPayPop]=moveToHistory(roundsAlive6, move, myHistory6, myRepertoire6, timeInnovate6, col6, numIndiv6, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy6);


% individual 7 
if strategy7=='strS1'
    [move]=InnovateStrategy(roundsAlive7);
elseif strategy7=='strS2'
    [move]=ObserveStrategy(roundsAlive7, childhood);
else 
    [move]=MixedStrategy(roundsAlive7, childhood);
end
[myHistory7, didExploit, timeInnovate7, myRepertoire7, roundsAlive7, deaths, results, strategy7, totPayPop]=moveToHistory(roundsAlive7, move, myHistory7, myRepertoire7, timeInnovate7, col7, numIndiv7, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy7);         


% individual 8 
if strategy8=='strS1'
    [move]=InnovateStrategy(roundsAlive8);
elseif strategy8=='strS2'
    [move]=ObserveStrategy(roundsAlive8, childhood);
else 
    [move]=MixedStrategy(roundsAlive8, childhood);
end
[myHistory8, didExploit, timeInnovate8, myRepertoire8, roundsAlive8, deaths, results, strategy8, totPayPop]=moveToHistory(roundsAlive8, move, myHistory8, myRepertoire8, timeInnovate8, col8, numIndiv8, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy8);         


% individual 9 
if strategy9=='strS1'
    [move]=InnovateStrategy(roundsAlive9);
elseif strategy9=='strS2'
    [move]=ObserveStrategy(roundsAlive9, childhood);
else 
    [move]=MixedStrategy(roundsAlive9, childhood);
end
[myHistory9, didExploit, timeInnovate9, myRepertoire9, roundsAlive9, deaths, results, strategy9, totPayPop]=moveToHistory(roundsAlive9, move, myHistory9, myRepertoire9, timeInnovate9, col9, numIndiv9, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy9);         


% individual 10 
if strategy10=='strS1'
    [move]=InnovateStrategy(roundsAlive10);
elseif strategy10=='strS2'
    [move]=ObserveStrategy(roundsAlive10, childhood);
else 
    [move]=MixedStrategy(roundsAlive10, childhood);
end
[myHistory10, didExploit, timeInnovate10, myRepertoire10, roundsAlive10, deaths, results, strategy10, totPayPop]=moveToHistory(roundsAlive10, move, myHistory10, myRepertoire10, timeInnovate10, col10, numIndiv10, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy10);         

% individual 11
if strategy11=='strS1'
    [move]=InnovateStrategy(roundsAlive11);
elseif strategy11=='strS2'
    [move]=ObserveStrategy(roundsAlive11, childhood);
else 
    [move]=MixedStrategy(roundsAlive11, childhood);
end
[myHistory11, didExploit, timeInnovate11, myRepertoire11, roundsAlive11, deaths, results, strategy11, totPayPop]=moveToHistory(roundsAlive11, move, myHistory11, myRepertoire11, timeInnovate11, col11, numIndiv11, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy11);                                        
    

% individual 12 
if strategy12=='strS1'
    [move]=InnovateStrategy(roundsAlive12);
elseif strategy12=='strS2'
    [move]=ObserveStrategy(roundsAlive12, childhood);
else 
    [move]=MixedStrategy(roundsAlive12, childhood);
end
[myHistory12, didExploit, timeInnovate12, myRepertoire12, roundsAlive12, deaths, results, strategy12, totPayPop]=moveToHistory(roundsAlive12, move, myHistory12, myRepertoire12, timeInnovate12, col12, numIndiv12, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy12);         


% individual 13 
if strategy13=='strS1'
    [move]=InnovateStrategy(roundsAlive13);
elseif strategy13=='strS2'
    [move]=ObserveStrategy(roundsAlive13, childhood);
else 
    [move]=MixedStrategy(roundsAlive13, childhood);
end
[myHistory13, didExploit, timeInnovate13, myRepertoire13, roundsAlive13, deaths, results, strategy13, totPayPop]=moveToHistory(roundsAlive13, move, myHistory13, myRepertoire13, timeInnovate13, col13, numIndiv13, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy13);    


% individual 14 
if strategy14=='strS1'
    [move]=InnovateStrategy(roundsAlive14);
elseif strategy14=='strS2'
    [move]=ObserveStrategy(roundsAlive14, childhood);
else 
    [move]=MixedStrategy(roundsAlive14, childhood);
end
[myHistory14, didExploit, timeInnovate14, myRepertoire14, roundsAlive14, deaths, results, strategy14, totPayPop]=moveToHistory(roundsAlive14, move, myHistory14, myRepertoire14, timeInnovate14, col14, numIndiv14, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy14);


% individual 15 
if strategy15=='strS1'
    [move]=InnovateStrategy(roundsAlive15);
elseif strategy15=='strS2'
    [move]=ObserveStrategy(roundsAlive15, childhood);
else 
    [move]=MixedStrategy(roundsAlive15, childhood);
end
[myHistory15, didExploit, timeInnovate15, myRepertoire15, roundsAlive15, deaths, results, strategy15, totPayPop]=moveToHistory(roundsAlive15, move, myHistory15, myRepertoire15, timeInnovate15, col15, numIndiv15, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy15);


% individual 16 
if strategy16=='strS1'
    [move]=InnovateStrategy(roundsAlive16);
elseif strategy16=='strS2'
    [move]=ObserveStrategy(roundsAlive16, childhood);
else 
    [move]=MixedStrategy(roundsAlive16, childhood);
end
[myHistory16, didExploit, timeInnovate16, myRepertoire16, roundsAlive16, deaths, results, strategy16, totPayPop]=moveToHistory(roundsAlive16, move, myHistory16, myRepertoire16, timeInnovate16, col16, numIndiv16, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy16);


% individual 17 
if strategy17=='strS1'
    [move]=InnovateStrategy(roundsAlive17);
elseif strategy17=='strS2'
    [move]=ObserveStrategy(roundsAlive17, childhood);
else 
    [move]=MixedStrategy(roundsAlive17, childhood);
end
[myHistory17, didExploit, timeInnovate17, myRepertoire17, roundsAlive17, deaths, results, strategy17, totPayPop]=moveToHistory(roundsAlive17, move, myHistory17, myRepertoire17, timeInnovate17, col17, numIndiv17, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy17);         


% individual 18 
if strategy18=='strS1'
    [move]=InnovateStrategy(roundsAlive18);
elseif strategy18=='strS2'
    [move]=ObserveStrategy(roundsAlive18, childhood);
else 
    [move]=MixedStrategy(roundsAlive18, childhood);
end
[myHistory18, didExploit, timeInnovate18, myRepertoire18, roundsAlive18, deaths, results, strategy18, totPayPop]=moveToHistory(roundsAlive18, move, myHistory18, myRepertoire18, timeInnovate18, col18, numIndiv18, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy18);         


% individual 19 
if strategy19=='strS1'
    [move]=InnovateStrategy(roundsAlive19);
elseif strategy19=='strS2'
    [move]=ObserveStrategy(roundsAlive19, childhood);
else 
    [move]=MixedStrategy(roundsAlive19, childhood);
end
[myHistory19, didExploit, timeInnovate19, myRepertoire19, roundsAlive19, deaths, results, strategy19, totPayPop]=moveToHistory(roundsAlive19, move, myHistory19, myRepertoire19, timeInnovate19, col19, numIndiv19, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy19);         


% individual 20 
if strategy20=='strS1'
    [move]=InnovateStrategy(roundsAlive20);
elseif strategy20=='strS2'
    [move]=ObserveStrategy(roundsAlive20, childhood);
else 
    [move]=MixedStrategy(roundsAlive20, childhood);
end
[myHistory20, didExploit, timeInnovate20, myRepertoire20, roundsAlive20, deaths, results, strategy20, totPayPop]=moveToHistory(roundsAlive20, move, myHistory20, myRepertoire20, timeInnovate20, col20, numIndiv20, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy20);         

% individual 21
if strategy21=='strS1'
    [move]=InnovateStrategy(roundsAlive21);
elseif strategy21=='strS2'
    [move]=ObserveStrategy(roundsAlive21, childhood);
else 
    [move]=MixedStrategy(roundsAlive21, childhood);
end
[myHistory21, didExploit, timeInnovate21, myRepertoire21, roundsAlive21, deaths, results, strategy21, totPayPop]=moveToHistory(roundsAlive21, move, myHistory21, myRepertoire21, timeInnovate21, col21, numIndiv21, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy21);                                        
    

% individual 22 
if strategy22=='strS1'
    [move]=InnovateStrategy(roundsAlive22);
elseif strategy22=='strS2'
    [move]=ObserveStrategy(roundsAlive22, childhood);
else    
    [move]=MixedStrategy(roundsAlive22, childhood);
end
[myHistory22, didExploit, timeInnovate22, myRepertoire22, roundsAlive22, deaths, results, strategy22, totPayPop]=moveToHistory(roundsAlive22, move, myHistory22, myRepertoire22, timeInnovate22, col22, numIndiv22, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy22);         


% individual 23 
if strategy23=='strS1'    
    [move]=InnovateStrategy(roundsAlive23);
elseif strategy23=='strS2'   
    [move]=ObserveStrategy(roundsAlive23, childhood);
else    
    [move]=MixedStrategy(roundsAlive23, childhood);
end
[myHistory23, didExploit, timeInnovate23, myRepertoire23, roundsAlive23, deaths, results, strategy23, totPayPop]=moveToHistory(roundsAlive23, move, myHistory23, myRepertoire23, timeInnovate23, col23, numIndiv23, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy23);    


% individual 24 
if strategy24=='strS1'    
    [move]=InnovateStrategy(roundsAlive24);
elseif strategy24=='strS2'
    [move]=ObserveStrategy(roundsAlive24, childhood);
else    
    [move]=MixedStrategy(roundsAlive24, childhood);
end
[myHistory24, didExploit, timeInnovate24, myRepertoire24, roundsAlive24, deaths, results, strategy24, totPayPop]=moveToHistory(roundsAlive24, move, myHistory24, myRepertoire24, timeInnovate24, col24, numIndiv24, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy24);


% individual 25 
if strategy25=='strS1'
    [move]=InnovateStrategy(roundsAlive25);
elseif strategy25=='strS2'
    [move]=ObserveStrategy(roundsAlive25, childhood);
else 
    [move]=MixedStrategy(roundsAlive25, childhood);
end
[myHistory25, didExploit, timeInnovate25, myRepertoire25, roundsAlive25, deaths, results, strategy25, totPayPop]=moveToHistory(roundsAlive25, move, myHistory25, myRepertoire25, timeInnovate25, col25, numIndiv25, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy25);


% individual 26 
if strategy26=='strS1'
    [move]=InnovateStrategy(roundsAlive26);
elseif strategy26=='strS2'
    [move]=ObserveStrategy(roundsAlive26, childhood);
else 
    [move]=MixedStrategy(roundsAlive26, childhood);
end
[myHistory26, didExploit, timeInnovate26, myRepertoire26, roundsAlive26, deaths, results, strategy26, totPayPop]=moveToHistory(roundsAlive26, move, myHistory26, myRepertoire26, timeInnovate26, col26, numIndiv26, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy26);


% individual 27 
if strategy27=='strS1'
    [move]=InnovateStrategy(roundsAlive27);
elseif strategy27=='strS2'
    [move]=ObserveStrategy(roundsAlive27, childhood);
else 
    [move]=MixedStrategy(roundsAlive27, childhood);
end
[myHistory27, didExploit, timeInnovate27, myRepertoire27, roundsAlive27, deaths, results, strategy27, totPayPop]=moveToHistory(roundsAlive27, move, myHistory27, myRepertoire27, timeInnovate27, col27, numIndiv27, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy27);         


% individual 28 
if strategy28=='strS1'
    [move]=InnovateStrategy(roundsAlive28);
elseif strategy28=='strS2'
    [move]=ObserveStrategy(roundsAlive28, childhood);
else 
    [move]=MixedStrategy(roundsAlive28, childhood);
end
[myHistory28, didExploit, timeInnovate28, myRepertoire28, roundsAlive28, deaths, results, strategy28, totPayPop]=moveToHistory(roundsAlive28, move, myHistory28, myRepertoire28, timeInnovate28, col28, numIndiv28, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy28);         


% individual 29 
if strategy29=='strS1'
    [move]=InnovateStrategy(roundsAlive29);
elseif strategy29=='strS2'
    [move]=ObserveStrategy(roundsAlive29, childhood);
else 
    [move]=MixedStrategy(roundsAlive29, childhood);
end
[myHistory29, didExploit, timeInnovate29, myRepertoire29, roundsAlive29, deaths, results, strategy29, totPayPop]=moveToHistory(roundsAlive29, move, myHistory29, myRepertoire29, timeInnovate29, col29, numIndiv29, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy29);         


% individual 30 
if strategy30=='strS1'
    [move]=InnovateStrategy(roundsAlive30);
elseif strategy30=='strS2'
    [move]=ObserveStrategy(roundsAlive30, childhood);
else 
    [move]=MixedStrategy(roundsAlive30, childhood);
end
[myHistory30, didExploit, timeInnovate30, myRepertoire30, roundsAlive30, deaths, results, strategy30, totPayPop]=moveToHistory(roundsAlive30, move, myHistory30, myRepertoire30, timeInnovate30, col30, numIndiv30, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy30);         


% individual 31
if strategy31=='strS1'
    [move]=InnovateStrategy(roundsAlive31);
elseif strategy31=='strS2'
    [move]=ObserveStrategy(roundsAlive31, childhood);
else 
    [move]=MixedStrategy(roundsAlive31, childhood);
end
[myHistory31, didExploit, timeInnovate31, myRepertoire31, roundsAlive31, deaths, results, strategy31, totPayPop]=moveToHistory(roundsAlive31, move, myHistory31, myRepertoire31, timeInnovate31, col31, numIndiv31, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy31);                                        
    

% individual 32 
if strategy32=='strS1'
    [move]=InnovateStrategy(roundsAlive32);
elseif strategy32=='strS2'
    [move]=ObserveStrategy(roundsAlive32, childhood);
else 
    [move]=MixedStrategy(roundsAlive32, childhood);
end
[myHistory32, didExploit, timeInnovate32, myRepertoire32, roundsAlive32, deaths, results, strategy32, totPayPop]=moveToHistory(roundsAlive32, move, myHistory32, myRepertoire32, timeInnovate32, col32, numIndiv32, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy32);         


% individual 33 
if strategy33=='strS1'
    [move]=InnovateStrategy(roundsAlive33);
elseif strategy33=='strS2'
    [move]=ObserveStrategy(roundsAlive33, childhood);
else 
    [move]=MixedStrategy(roundsAlive33, childhood);
end
[myHistory33, didExploit, timeInnovate33, myRepertoire33, roundsAlive33, deaths, results, strategy33, totPayPop]=moveToHistory(roundsAlive33, move, myHistory33, myRepertoire33, timeInnovate33, col33, numIndiv33, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy33);    


% individual 34 
if strategy34=='strS1'
    [move]=InnovateStrategy(roundsAlive34);
elseif strategy34=='strS2'
    [move]=ObserveStrategy(roundsAlive34, childhood);
else 
    [move]=MixedStrategy(roundsAlive34, childhood);
end
[myHistory34, didExploit, timeInnovate34, myRepertoire34, roundsAlive34, deaths, results, strategy34, totPayPop]=moveToHistory(roundsAlive34, move, myHistory34, myRepertoire34, timeInnovate34, col34, numIndiv34, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy34);


% individual 35 
if strategy35=='strS1'
    [move]=InnovateStrategy(roundsAlive35);
elseif strategy35=='strS2'
    [move]=ObserveStrategy(roundsAlive35, childhood);
else 
    [move]=MixedStrategy(roundsAlive35, childhood);
end
[myHistory35, didExploit, timeInnovate35, myRepertoire35, roundsAlive35, deaths, results, strategy35, totPayPop]=moveToHistory(roundsAlive35, move, myHistory35, myRepertoire35, timeInnovate35, col35, numIndiv35, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy35);


% individual 36 
if strategy36=='strS1'
    [move]=InnovateStrategy(roundsAlive36);
elseif strategy36=='strS2'
    [move]=ObserveStrategy(roundsAlive36, childhood);
else 
    [move]=MixedStrategy(roundsAlive36, childhood);
end
[myHistory36, didExploit, timeInnovate36, myRepertoire36, roundsAlive36, deaths, results, strategy36, totPayPop]=moveToHistory(roundsAlive36, move, myHistory36, myRepertoire36, timeInnovate36, col36, numIndiv36, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy36);


% individual 37 
if strategy37=='strS1'
    [move]=InnovateStrategy(roundsAlive37);
elseif strategy37=='strS2'
    [move]=ObserveStrategy(roundsAlive37, childhood);
else 
    [move]=MixedStrategy(roundsAlive37, childhood);
end
[myHistory37, didExploit, timeInnovate37, myRepertoire37, roundsAlive37, deaths, results, strategy37, totPayPop]=moveToHistory(roundsAlive37, move, myHistory37, myRepertoire37, timeInnovate37, col37, numIndiv37, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy37);         


% individual 38 
if strategy38=='strS1'
    [move]=InnovateStrategy(roundsAlive38);
elseif strategy38=='strS2'
    [move]=ObserveStrategy(roundsAlive38, childhood);
else 
    [move]=MixedStrategy(roundsAlive38, childhood);
end
[myHistory38, didExploit, timeInnovate38, myRepertoire38, roundsAlive38, deaths, results, strategy38, totPayPop]=moveToHistory(roundsAlive38, move, myHistory38, myRepertoire38, timeInnovate38, col38, numIndiv38, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy38);         


% individual 39 
if strategy39=='strS1'
    [move]=InnovateStrategy(roundsAlive39);
elseif strategy39=='strS2'
    [move]=ObserveStrategy(roundsAlive39, childhood);
else 
    [move]=MixedStrategy(roundsAlive39, childhood);
end
[myHistory39, didExploit, timeInnovate39, myRepertoire39, roundsAlive39, deaths, results, strategy39, totPayPop]=moveToHistory(roundsAlive39, move, myHistory39, myRepertoire39, timeInnovate39, col39, numIndiv39, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy39);         


% individual 40 
if strategy40=='strS1'
    [move]=InnovateStrategy(roundsAlive40);
elseif strategy40=='strS2'
    [move]=ObserveStrategy(roundsAlive40, childhood);
else 
    [move]=MixedStrategy(roundsAlive40, childhood);
end
[myHistory40, didExploit, timeInnovate40, myRepertoire40, roundsAlive40, deaths, results, strategy40, totPayPop]=moveToHistory(roundsAlive40, move, myHistory40, myRepertoire40, timeInnovate40, col40, numIndiv40, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy40);         


% individual 41
if strategy41=='strS1'
    [move]=InnovateStrategy(roundsAlive41);
elseif strategy41=='strS2'
    [move]=ObserveStrategy(roundsAlive41, childhood);
else 
    [move]=MixedStrategy(roundsAlive41, childhood);
end
[myHistory41, didExploit, timeInnovate41, myRepertoire41, roundsAlive41, deaths, results, strategy41, totPayPop]=moveToHistory(roundsAlive41, move, myHistory41, myRepertoire41, timeInnovate41, col41, numIndiv41, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy41);                                        
    

% individual 42 
if strategy42=='strS1'
    [move]=InnovateStrategy(roundsAlive42);
elseif strategy42=='strS2'
    [move]=ObserveStrategy(roundsAlive42, childhood);
else    
    [move]=MixedStrategy(roundsAlive42, childhood);
end
[myHistory42, didExploit, timeInnovate42, myRepertoire42, roundsAlive42, deaths, results, strategy42, totPayPop]=moveToHistory(roundsAlive42, move, myHistory42, myRepertoire42, timeInnovate42, col42, numIndiv42, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy42);         


% individual 43 
if strategy43=='strS1'    
    [move]=InnovateStrategy(roundsAlive43);
elseif strategy43=='strS2'   
    [move]=ObserveStrategy(roundsAlive43, childhood);
else    
    [move]=MixedStrategy(roundsAlive43, childhood);
end
[myHistory43, didExploit, timeInnovate43, myRepertoire43, roundsAlive43, deaths, results, strategy43, totPayPop]=moveToHistory(roundsAlive43, move, myHistory43, myRepertoire43, timeInnovate43, col43, numIndiv43, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy43);    


% individual 44 
if strategy44=='strS1'    
    [move]=InnovateStrategy(roundsAlive44);
elseif strategy44=='strS2'
    [move]=ObserveStrategy(roundsAlive44, childhood);
else    
    [move]=MixedStrategy(roundsAlive44, childhood);
end
[myHistory44, didExploit, timeInnovate44, myRepertoire44, roundsAlive44, deaths, results, strategy44, totPayPop]=moveToHistory(roundsAlive44, move, myHistory44, myRepertoire44, timeInnovate44, col44, numIndiv44, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy44);


% individual 45 
if strategy45=='strS1'
    [move]=InnovateStrategy(roundsAlive45);
elseif strategy45=='strS2'
    [move]=ObserveStrategy(roundsAlive45, childhood);
else 
    [move]=MixedStrategy(roundsAlive45, childhood);
end
[myHistory45, didExploit, timeInnovate45, myRepertoire45, roundsAlive45, deaths, results, strategy45, totPayPop]=moveToHistory(roundsAlive45, move, myHistory45, myRepertoire45, timeInnovate45, col45, numIndiv45, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy45);


% individual 46 
if strategy46=='strS1'
    [move]=InnovateStrategy(roundsAlive46);
elseif strategy46=='strS2'
    [move]=ObserveStrategy(roundsAlive46, childhood);
else 
    [move]=MixedStrategy(roundsAlive46, childhood);
end
[myHistory46, didExploit, timeInnovate46, myRepertoire46, roundsAlive46, deaths, results, strategy46, totPayPop]=moveToHistory(roundsAlive46, move, myHistory46, myRepertoire46, timeInnovate46, col46, numIndiv46, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy46);


% individual 47 
if strategy47=='strS1'
    [move]=InnovateStrategy(roundsAlive47);
elseif strategy47=='strS2'
    [move]=ObserveStrategy(roundsAlive47, childhood);
else 
    [move]=MixedStrategy(roundsAlive47, childhood);
end
[myHistory47, didExploit, timeInnovate47, myRepertoire47, roundsAlive47, deaths, results, strategy47, totPayPop]=moveToHistory(roundsAlive47, move, myHistory47, myRepertoire47, timeInnovate47, col47, numIndiv47, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy47);         


% individual 48 
if strategy48=='strS1'
    [move]=InnovateStrategy(roundsAlive48);
elseif strategy48=='strS2'
    [move]=ObserveStrategy(roundsAlive48, childhood);
else 
    [move]=MixedStrategy(roundsAlive48, childhood);
end
[myHistory48, didExploit, timeInnovate48, myRepertoire48, roundsAlive48, deaths, results, strategy48, totPayPop]=moveToHistory(roundsAlive48, move, myHistory48, myRepertoire48, timeInnovate48, col48, numIndiv48, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy48);         


% individual 49 
if strategy49=='strS1'
    [move]=InnovateStrategy(roundsAlive49);
elseif strategy49=='strS2'
    [move]=ObserveStrategy(roundsAlive49, childhood);
else 
    [move]=MixedStrategy(roundsAlive49, childhood);
end
[myHistory49, didExploit, timeInnovate49, myRepertoire49, roundsAlive49, deaths, results, strategy49, totPayPop]=moveToHistory(roundsAlive49, move, myHistory49, myRepertoire49, timeInnovate49, col49, numIndiv9, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy49);         


% individual 50 
if strategy50=='strS1'
    [move]=InnovateStrategy(roundsAlive50);
elseif strategy50=='strS2'
    [move]=ObserveStrategy(roundsAlive50, childhood);
else 
    [move]=MixedStrategy(roundsAlive50, childhood);
end
[myHistory50, didExploit, timeInnovate50, myRepertoire50, roundsAlive50, deaths, results, strategy50, totPayPop]=moveToHistory(roundsAlive50, move, myHistory50, myRepertoire50, timeInnovate50, col50, numIndiv50, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy50);         

% individual 51
if strategy51=='strS1'
    [move]=InnovateStrategy(roundsAlive51);
elseif strategy51=='strS2'
    [move]=ObserveStrategy(roundsAlive51, childhood);
else 
    [move]=MixedStrategy(roundsAlive51, childhood);
end
[myHistory51, didExploit, timeInnovate51, myRepertoire51, roundsAlive51, deaths, results, strategy51, totPayPop]=moveToHistory(roundsAlive51, move, myHistory51, myRepertoire51, timeInnovate51, col51, numIndiv51, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy51);                                        
    

% individual 52 
if strategy52=='strS1'
    [move]=InnovateStrategy(roundsAlive52);
elseif strategy52=='strS2'
    [move]=ObserveStrategy(roundsAlive52, childhood);
else 
    [move]=MixedStrategy(roundsAlive52, childhood);
end
[myHistory52, didExploit, timeInnovate52, myRepertoire52, roundsAlive52, deaths, results, strategy52, totPayPop]=moveToHistory(roundsAlive52, move, myHistory52, myRepertoire52, timeInnovate52, col52, numIndiv52, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy52);         


% individual 53 
if strategy53=='strS1'
    [move]=InnovateStrategy(roundsAlive53);
elseif strategy53=='strS2'
    [move]=ObserveStrategy(roundsAlive53, childhood);
else 
    [move]=MixedStrategy(roundsAlive53, childhood);
end
[myHistory53, didExploit, timeInnovate53, myRepertoire53, roundsAlive53, deaths, results, strategy53, totPayPop]=moveToHistory(roundsAlive53, move, myHistory53, myRepertoire53, timeInnovate53, col53, numIndiv53, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy53);    


% individual 54 
if strategy54=='strS1'
    [move]=InnovateStrategy(roundsAlive54);
elseif strategy54=='strS2'
    [move]=ObserveStrategy(roundsAlive54, childhood);
else 
    [move]=MixedStrategy(roundsAlive54, childhood);
end
[myHistory54, didExploit, timeInnovate54, myRepertoire54, roundsAlive54, deaths, results, strategy54, totPayPop]=moveToHistory(roundsAlive54, move, myHistory54, myRepertoire54, timeInnovate54, col54, numIndiv54, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy54);


% individual 55 
if strategy55=='strS1'
    [move]=InnovateStrategy(roundsAlive55);
elseif strategy55=='strS2'
    [move]=ObserveStrategy(roundsAlive55, childhood);
else 
    [move]=MixedStrategy(roundsAlive55, childhood);
end
[myHistory55, didExploit, timeInnovate55, myRepertoire55, roundsAlive55, deaths, results, strategy55, totPayPop]=moveToHistory(roundsAlive55, move, myHistory55, myRepertoire55, timeInnovate55, col55, numIndiv55, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy55);


% individual 56 
if strategy56=='strS1'
    [move]=InnovateStrategy(roundsAlive56);
elseif strategy56=='strS2'
    [move]=ObserveStrategy(roundsAlive56, childhood);
else 
    [move]=MixedStrategy(roundsAlive56, childhood);
end
[myHistory56, didExploit, timeInnovate56, myRepertoire56, roundsAlive56, deaths, results, strategy56, totPayPop]=moveToHistory(roundsAlive56, move, myHistory56, myRepertoire56, timeInnovate56, col56, numIndiv56, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy56);


% individual 57 
if strategy57=='strS1'
    [move]=InnovateStrategy(roundsAlive57);
elseif strategy57=='strS2'
    [move]=ObserveStrategy(roundsAlive57, childhood);
else 
    [move]=MixedStrategy(roundsAlive57, childhood);
end
[myHistory57, didExploit, timeInnovate57, myRepertoire57, roundsAlive57, deaths, results, strategy57, totPayPop]=moveToHistory(roundsAlive57, move, myHistory57, myRepertoire57, timeInnovate57, col57, numIndiv57, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy57);         


% individual 58 
if strategy58=='strS1'
    [move]=InnovateStrategy(roundsAlive58);
elseif strategy58=='strS2'
    [move]=ObserveStrategy(roundsAlive58, childhood);
else 
    [move]=MixedStrategy(roundsAlive58, childhood);
end
[myHistory58, didExploit, timeInnovate58, myRepertoire58, roundsAlive58, deaths, results, strategy58, totPayPop]=moveToHistory(roundsAlive58, move, myHistory58, myRepertoire58, timeInnovate58, col58, numIndiv58, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy58);         


% individual 59 
if strategy59=='strS1'
    [move]=InnovateStrategy(roundsAlive59);
elseif strategy59=='strS2'
    [move]=ObserveStrategy(roundsAlive59, childhood);
else 
    [move]=MixedStrategy(roundsAlive59, childhood);
end
[myHistory59, didExploit, timeInnovate59, myRepertoire59, roundsAlive59, deaths, results, strategy59, totPayPop]=moveToHistory(roundsAlive59, move, myHistory59, myRepertoire59, timeInnovate59, col59, numIndiv59, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy59);         


% individual 60 
if strategy60=='strS1'
    [move]=InnovateStrategy(roundsAlive60);
elseif strategy60=='strS2'
    [move]=ObserveStrategy(roundsAlive60, childhood);
else 
    [move]=MixedStrategy(roundsAlive60, childhood);
end
[myHistory60, didExploit, timeInnovate60, myRepertoire60, roundsAlive60, deaths, results, strategy60, totPayPop]=moveToHistory(roundsAlive60, move, myHistory60, myRepertoire60, timeInnovate60, col60, numIndiv60, didExploit, behaviors, results, deaths, numRounds, rounds, totPayPop, strategy60);         

    rounds=rounds+1; % increases round #
    
 end % ends while loop   
 
 rounds=rounds-1;
 
 % The next portion sends each individuals data to a results function that
 % compiles the desired information (populationKnowledge,
 % meanLifetimePayoff, etc.)
 
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive1, numIndiv1, myHistory1, myRepertoire1, strategy1, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive2, numIndiv2, myHistory2, myRepertoire2, strategy2, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive3, numIndiv3, myHistory3, myRepertoire3, strategy3, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive4, numIndiv4, myHistory4, myRepertoire4, strategy4, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive5, numIndiv5, myHistory5, myRepertoire5, strategy5, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive6, numIndiv6, myHistory6, myRepertoire6, strategy6, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive7, numIndiv7, myHistory7, myRepertoire7, strategy7, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive8, numIndiv8, myHistory8, myRepertoire8, strategy8, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive9, numIndiv9, myHistory9, myRepertoire9, strategy9, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive10, numIndiv10, myHistory10, myRepertoire10, strategy10, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive11, numIndiv11, myHistory11, myRepertoire11, strategy11, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive12, numIndiv12, myHistory12, myRepertoire12, strategy12, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive13, numIndiv13, myHistory13, myRepertoire13, strategy13, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive14, numIndiv14, myHistory14, myRepertoire14, strategy14, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive15, numIndiv15, myHistory15, myRepertoire15, strategy15, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive16, numIndiv16, myHistory16, myRepertoire16, strategy16, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive17, numIndiv17, myHistory17, myRepertoire17, strategy17, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive18, numIndiv18, myHistory18, myRepertoire18, strategy18, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive19, numIndiv19, myHistory19, myRepertoire19, strategy19, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive20, numIndiv20, myHistory20, myRepertoire20, strategy20, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive21, numIndiv21, myHistory21, myRepertoire21, strategy21, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive22, numIndiv22, myHistory22, myRepertoire22, strategy22, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive23, numIndiv23, myHistory23, myRepertoire23, strategy23, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive24, numIndiv24, myHistory24, myRepertoire24, strategy24, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive25, numIndiv25, myHistory25, myRepertoire25, strategy25, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive26, numIndiv26, myHistory26, myRepertoire26, strategy26, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive27, numIndiv27, myHistory27, myRepertoire27, strategy27, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive28, numIndiv28, myHistory28, myRepertoire28, strategy28, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive29, numIndiv29, myHistory29, myRepertoire29, strategy29, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive30, numIndiv30, myHistory30, myRepertoire30, strategy30, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive31, numIndiv31, myHistory31, myRepertoire31, strategy31, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive32, numIndiv32, myHistory32, myRepertoire32, strategy32, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive33, numIndiv33, myHistory33, myRepertoire33, strategy33, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive34, numIndiv34, myHistory34, myRepertoire34, strategy34, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive35, numIndiv35, myHistory35, myRepertoire35, strategy35, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive36, numIndiv36, myHistory36, myRepertoire36, strategy36, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive37, numIndiv37, myHistory37, myRepertoire37, strategy37, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive38, numIndiv38, myHistory38, myRepertoire38, strategy38, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive39, numIndiv39, myHistory39, myRepertoire39, strategy39, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive40, numIndiv40, myHistory40, myRepertoire40, strategy40, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive41, numIndiv41, myHistory41, myRepertoire41, strategy41, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive42, numIndiv42, myHistory42, myRepertoire42, strategy42, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive43, numIndiv43, myHistory43, myRepertoire43, strategy43, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive44, numIndiv44, myHistory44, myRepertoire44, strategy44, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive45, numIndiv45, myHistory45, myRepertoire45, strategy45, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive46, numIndiv46, myHistory46, myRepertoire46, strategy46, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive47, numIndiv47, myHistory47, myRepertoire47, strategy47, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive48, numIndiv48, myHistory48, myRepertoire48, strategy48, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive49, numIndiv49, myHistory49, myRepertoire49, strategy49, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive40, numIndiv40, myHistory50, myRepertoire50, strategy50, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive51, numIndiv51, myHistory51, myRepertoire51, strategy51, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive52, numIndiv52, myHistory52, myRepertoire52, strategy52, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive53, numIndiv53, myHistory53, myRepertoire53, strategy53, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive54, numIndiv54, myHistory54, myRepertoire54, strategy54, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive55, numIndiv55, myHistory55, myRepertoire55, strategy55, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive56, numIndiv56, myHistory56, myRepertoire56, strategy56, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive57, numIndiv57, myHistory57, myRepertoire57, strategy57, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive58, numIndiv58, myHistory58, myRepertoire58, strategy58, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive59, numIndiv59, myHistory59, myRepertoire59, strategy59, popKnowledge);
[results, deaths, popKnowledge]=createResultsTable(rounds, results, deaths, roundsAlive60, numIndiv60, myHistory60, myRepertoire60, strategy60, popKnowledge);

emptyCol=(results(1,:)~=0);
finalResults=results(:,emptyCol);

% Sort rows of results matrix into different strategies
sS1 = results(:,results(4,:)==1);
sS2 = results(:,results(4,:)==2);
sS3 = results(:,results(4,:)==3);

% Computes the fractions each strategy used observe, innovate, and exploit
% Note: values were not considered relevant to our study
sS1Move = [(mean(sS1(7,:))),(mean(sS1(8,:))),(mean(sS1(9,:)))];
sS2Move = [(mean(sS2(7,:))),(mean(sS2(8,:))),(mean(sS2(9,:)))];
sS3Move = [(mean(sS3(7,:))),(mean(sS3(8,:))),(mean(sS3(9,:)))];
fractionMove(loop,2:10)=[sS1Move,sS2Move,sS3Move];


lastRoundIndices=(finalResults(1,:)==numRounds);
lastRound=finalResults(:,lastRoundIndices);

indicesS1=sum(lastRound(4,:)==1);
numS1=sum(indicesS1);

indicesS2=sum(lastRound(4,:)==2);
numS2=sum(indicesS2);

indicesS3=sum(lastRound(4,:)==3);
numS3=sum(indicesS3);

% Calculates how many behaviors out of the numActs were learned by the
% population
popKnowledge(41,:)=sum(popKnowledge(1:40,:)~=0);
populationKnowledge=nnz(popKnowledge(41,:));

strategyResults(loop,2:4)=[numS1, numS2, numS3];

disp(loop)
loop=loop+1;

end


% The data from results tables are outputted as excel files for extraction
% of values.

strategyResultsTbl=array2table(strategyResults);

strategyResultsTbl.Properties.VariableNames = {'Loop' 'Innovate' 'Observe' 'Mixed'};

filename = 'strategyResults.xlsx';

writetable(strategyResultsTbl, filename, 'Sheet', 1, 'Range', 'A1')
