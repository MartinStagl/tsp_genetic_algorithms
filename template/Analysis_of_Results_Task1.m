result = readtable('results_ParameterTuning_Task1.csv');
result=result(result.ShortestPath>0,:);
%unique(result(result.ShortestPath==0,2:11));

%stackedplot(result);

figure;
subplot(2,3,1);
boxplot(result.ShortestPath,result.PR_MUT)
title('ShortestPath by PR-MUT')
xlabel('PR-MUT')
ylabel('Shortest Path Length')

subplot(2,3,2); 
boxplot(result.ShortestPath,result.PR_CROSS)
title('ShortestPath by PR-CROSS')
xlabel('PR-CROSS')
ylabel('Shortest Path Length')

subplot(2,3,3); 
boxplot(result.ShortestPath,result.NIND)
title('ShortestPath by NIND')
xlabel('NIND')
ylabel('Shortest Path Length')

subplot(2,3,4); 
boxplot(result.ShortestPath,result.MAXGEN)
title('ShortestPath by MAXGEN')
xlabel('MAXGEN')
ylabel('Shortest Path Length')

subplot(2,3,5); 
boxplot(result.ShortestPath,result.ELITIST)
title('ShortestPath by ELITIST')
xlabel('ELITIST')
ylabel('Shortest Path Length')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Interactions and Statistical Significance Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mdl = fitlm(result,'ShortestPath ~ NIND+MAXGEN+ELITIST+PR_CROSS+PR_MUT')
tbl = anova(mdl)

% [~,~,stats] = anovan(result.ShortestPath,{result.CROSSOVER ,result.NIND...
%     ,result.MAXGEN,result.ELITIST,result.PR_CROSS,result.PR_MUT},'model'...
%     ,'interaction','varnames',{'CROSSOVER','NIND','MAXGEN','ELITIST','PR_CROSS','PR_MUT'});
%multcompare_results = multcompare(stats,'CType','hsd')
% multcompare_results

