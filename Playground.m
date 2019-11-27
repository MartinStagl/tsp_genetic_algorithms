% data
  x = [10 9 8 7 6 5 5 5 5 3 3 3 3 5];
% engine
MAXGEN=10
 n_percentage=0.3;
 maxEqualGeneration=MAXGEN*n_percentage;
 n_end=0;
 gen=0;
        
while gen<MAXGEN & n_end<=maxEqualGeneration
    x_iter=x(1:gen+1);
    i = find(diff(x_iter)) ;
    n = [i numel(x_iter)] - [0 i];
    n_end=n(end);
    gen=gen+1;
    if n_end==1
        maxEqualGeneration=ceil(gen*n_percentage);
    end
end


tic
A = rand(12000, 4400);
B = rand(12000, 4400);
t=toc
C = A'.*B';
toc
t

figure(1);
boxplot(best_end,mean_fits_end)
%plot([0:gen],best_end(1:gen+1),'r-', [0:gen],mean_fits_end(1:gen+1),'black', [0:gen],worst(1:gen+1),'g-', [0:gen],best_average(1:gen+1),'blue');

elements = {CROSSOVER ,NIND,MAXGEN,ELITIST,PR_CROSS,PR_MUT}; %cell array with N vectors to combine
 combinations = cell(1, numel(elements)); %set up the varargout result
 [combinations{:}] = ndgrid(elements{:});
 combinations = cellfun(@(x) x(:), combinations,'uniformoutput',false); %there may be a better way to do this
 result = splitvars(table([combinations{:,:}])); % NumberOfCombinations by N matrix. Each row is unique.
result.Properties.VariableNames ={'CROSSOVER','NIND','MAXGEN','ELITIST','PR_CROSS','PR_MUT'};
result.Time=zeros(size(result,1),1);
result.ShortestPath=zeros(size(result,1),1);
result.Generations=zeros(size(result,1),1);
 


%figure;
%stackedplot(result);
figure;
subplot(2,2,1);
boxplot(result.ShortestPath,result.CROSSOVER)
title('ShortestPath by CROSSOVER')
xlabel('CROSSOVER')
ylabel('Shortest Path Length')
subplot(2,2,2); 
boxplot(result.ShortestPath,result.PR_CROSS)
title('ShortestPath by PR_CROSS')
xlabel('PR_CROSS')
ylabel('Shortest Path Length')
subplot(2,2,[3,4]); 
boxplot(result.ShortestPath,result.NIND)
title('ShortestPath by NIND')
xlabel('NIND')
ylabel('Shortest Path Length')
result(1:5,:);
