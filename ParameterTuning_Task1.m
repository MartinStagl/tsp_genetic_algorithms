%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND=[32, 64, 96, 128];		% Number of individuals
MAXGEN=[30, 40, 60, 80, 100];		% Maximum no. of generations
NVAR=26;		% No. of variables
PRECI=1;		% Precision of variables
ELITIST=[0,0.05];    % percentage of the elite population
GGAP=1-ELITIST;		% Generation gap
STOP_PERCENTAGE=.95;    % percentage of equal fitness individuals for stopping
PR_CROSS=[0.05, 0.9, 0.95, 1.00];     % probability of crossover
PR_MUT=[0.05, 0.10, 0.95];       % probability of mutation
LOCALLOOP=[1];      % local loop removal
CROSSOVER = ["xalt_edges"];  % default crossover operator
InitializationMethode=[1];
RepresentationMethode=[1];
MutationMethode='inversion'; %exchange
SelectionMethode='sus';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stoppingCriteria=[4];
n_percentage=[1];
delta=[1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load the data sets
datasetslist = dir('../TSPBenchmark/');datasetslist = dir('../TSPBenchmark/');
datasets=cell( size(datasetslist,1)-2,1);datasets=cell( size(datasetslist,1)-2 ,1);
for i=1:size(datasets,1);
    datasets{i} = datasetslist(i+2).name;
end

% start with first dataset
data = load(['../TSPBenchmark/' datasets{4}]);
x=data(:,1);y=data(:,2);
NVAR=size(data,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% initialise the user interface
fh = figure('Visible','off','Name','TSP Tool','Position',[0,0,1024,768]);
ah1 = axes('Parent',fh,'Position',[.1 .55 .4 .4]);
%plot(x,y,'ko')
ah2 = axes('Parent',fh,'Position',[.55 .55 .4 .4]);
%uncommented this so there is no GUI
%axes(ah2);
xlabel('Generation');
ylabel('Distance (Min. - Gem. - Max.)');
ah3 = axes('Parent',fh,'Position',[.1 .1 .4 .4]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EXECUTION OF PARAMETER SELECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=1;
PARAMNUM=length(CROSSOVER)+length(NIND)+length(MAXGEN)+length(ELITIST)+length(PR_CROSS)...
    +length(PR_MUT)+length(stoppingCriteria)+length(n_percentage)+length(delta)...
    +length(InitializationMethode)+length(RepresentationMethode);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results Table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elements = {1:10,CROSSOVER ,NIND,MAXGEN,ELITIST,PR_CROSS,PR_MUT,stoppingCriteria...
    ,n_percentage,delta,InitializationMethode,RepresentationMethode}; %cell array with N vectors to combine
 combinations = cell(1, numel(elements)); %set up the varargout result
 [combinations{:}] = ndgrid(elements{:});
 combinations = cellfun(@(x) x(:), combinations,'uniformoutput',false); %there may be a better way to do this
 result = splitvars(table([combinations{:,:}])); % NumberOfCombinations by N matrix. Each row is unique.
result.Properties.VariableNames ={'NumberOfRuns','CROSSOVER','NIND','MAXGEN'...
    ,'ELITIST','PR_CROSS','PR_MUT','stoppingCriteria','n_percentage','delta'...
    ,'InitializationMethode','RepresentationMethode'};
result.Time=zeros(size(result,1),1);
result.ShortestPath=zeros(size(result,1),1);
result.Generations=zeros(size(result,1),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for row = 1:size(result,1)
    if(mod(row-1,10)==0)
        rng(0776982) 
    end
        tic;
        [help_ShortestPath,help_Generations]=run_ga_Project2019(x, y, double(table2array(result(row,'NIND')))...
            ,double(table2array(result(row,'MAXGEN'))), NVAR, double(table2array(result(row,'ELITIST')))...
            ,STOP_PERCENTAGE...
            ,double(table2array(result(row,'PR_CROSS'))), double(table2array(result(row,'PR_MUT')))...
            ,table2array(result(row,'CROSSOVER'))...
            ,LOCALLOOP, ah1, ah2, ah3,double(table2array(result(row,'stoppingCriteria')))...
            ,double(table2array(result(row,'n_percentage')))...
            ,double(table2array(result(row,'delta')))...
            ,double(table2array(result(row,'InitializationMethode')))...
            ,double(table2array(result(row,'RepresentationMethode')))...
            ,MutationMethode,SelectionMethode);
        help_Time=toc;
        result(row,{'ShortestPath','Generations'})={help_ShortestPath,help_Generations};                       
        result(row,{'Time'})={help_Time};

end

writetable(result,'results_ParameterTuning_Task1.csv')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VISUALISATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
result(1:5,:);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Interactions and Statistical Significance Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,~,stats] = anovan(result.ShortestPath,{result.CROSSOVER ,result.NIND...
    ,result.MAXGEN,result.ELITIST,result.PR_CROSS,result.PR_MUT},'model'...
    ,'interaction','varnames',{'CROSSOVER','NIND','MAXGEN','ELITIST','PR_CROSS','PR_MUT'});
multcompare_results = multcompare(stats,'CType','hsd');
multcompare_results