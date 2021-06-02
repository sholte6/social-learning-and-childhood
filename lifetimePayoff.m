function[tableMeanLifePay]=lifetimePayoff(results)
    % This function was not used in the final results, as it was not
    % relevant to area of research
    
nnzRes=results(3,:)~=0;
res=results(:,nnzRes);
meanLifetimePayoff=(res(5,:))./(res(3,:));

resX = (res(4,:)==1);
lifePayX = meanLifetimePayoff(1,resX);
avgX = mean(lifePayX);

resX2 = (res(4,:)==2);
lifePayX2 = meanLifetimePayoff(1,resX2);
avgX2 = mean(lifePayX2);

resX3 = (res(4,:)==3);
lifePayX3 = meanLifetimePayoff(1,resX3);
avgX3 = mean(lifePayX3);

tableMeanLifePay = [avgX,avgX2,avgX3];
% edit to also record just the last remaining indiv

end 