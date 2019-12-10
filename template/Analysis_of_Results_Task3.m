result = readtable('results_ParameterTuning_Task3.csv');
result=result(result.ShortestPath>0,:);
%unique(result(result.ShortestPath==0,2:11));


figure;
subplot(1,2,2);
boxplot(result.Time,result.InitializationMethode)
title('Time by InitializationMethode')
xlabel('InitializationMethode')
ylabel('Shortest Path Length')

subplot(1,2,1); 
boxplot(result.ShortestPath,result.InitializationMethode)
title('ShortestPath by InitializationMethode')
xlabel('InitializationMethode')
ylabel('Shortest Path Length')