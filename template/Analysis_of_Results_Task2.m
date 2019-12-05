result = readtable('results_ParameterTuning_Task2.csv');
result=result(result.ShortestPath>0,:);
%unique(result(result.ShortestPath==0,2:11));

%stackedplot(result);

figure;
subplot(1,3,1);
boxplot(result.ShortestPath,result.stoppingCriteria)
title('ShortestPath by stoppingCriteria')
xlabel('stoppingCriteria')
ylabel('Shortest Path Length')

subplot(1,3,2); 
boxplot(result.ShortestPath,result.n_percentage)
title('ShortestPath by n-percentage')
xlabel('n-percentage')
ylabel('Shortest Path Length')

subplot(1,3,3); 
boxplot(result.ShortestPath,result.delta)
title('ShortestPath by delta')
xlabel('delta')
ylabel('Shortest Path Length')


figure;
subplot(1,3,1);
boxplot(result.Generations,result.stoppingCriteria)
title('Number of Generations by stoppingCriteria')
xlabel('stoppingCriteria')
ylabel('Number of Generations')

subplot(1,3,2); 
boxplot(result.Generations,result.n_percentage)
title('Number of Generations by n-percentage')
xlabel('n-percentage')
ylabel('Number of Generations')

subplot(1,3,3); 
boxplot(result.Generations,result.delta)
title('Number of Generations by delta')
xlabel('delta')
ylabel('Number of Generations')