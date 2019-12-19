result = readtable('results_ParameterTuning_Task4.csv');
result=result(result.ShortestPath>0,:);
%unique(result(result.ShortestPath==0,2:11));


figure;
subplot(3,2,1);
boxplot(result.Time,result.InitializationMethode)
title('Time by InitializationMethode')
xlabel('InitializationMethode')
ylabel('Time (in seconds)')

subplot(3,2,2);
boxplot(result.ShortestPath,result.InitializationMethode)
title('ShortestPath by InitializationMethode')
xlabel('InitializationMethode')
ylabel('Shortest Path Length')

resultInitial1=result(result.InitializationMethode==1,:);
resultInitial2=result(result.InitializationMethode==2,:);

subplot(3,2,3); 
boxplot(resultInitial1.ShortestPath,resultInitial1.MutationMethode)
title('ShortestPath by Mutation Methode and Non-Heuristic Initialization')
xlabel('MutationMethode')
ylabel('Shortest Path Length')

subplot(3,2,5); 
boxplot(resultInitial1.ShortestPath,resultInitial1.CROSSOVER)
title('ShortestPath by CROSSOVER Methode and Non-Heuristic Initialization')
xlabel('CROSSOVER Methode')
ylabel('Shortest Path Length')

subplot(3,2,4); 
boxplot(resultInitial2.ShortestPath,resultInitial2.MutationMethode)
title('ShortestPath by Mutation Methode and Heuristic Initialization')
xlabel('MutationMethode')
ylabel('Shortest Path Length')

subplot(3,2,6); 
boxplot(resultInitial2.ShortestPath,resultInitial2.CROSSOVER)
title('ShortestPath by CROSSOVER Methode and Heuristic Initialization')
xlabel('CROSSOVER Methode')
ylabel('Shortest Path Length')