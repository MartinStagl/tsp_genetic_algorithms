%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND=[20,50,100,200];		% Number of individuals
MAXGEN=[50,100,200,500];		% Maximum no. of generations
NVAR=26;		% No. of variables
PRECI=1;		% Precision of variables
ELITIST=[0.05,0.1,0.01,0];    % percentage of the elite population
GGAP=1-ELITIST;		% Generation gap
STOP_PERCENTAGE=.95;    % percentage of equal fitness individuals for stopping
PR_CROSS=[.95,.60,.10,.1];     % probability of crossover
PR_MUT=[.05,.10,.60,.85];       % probability of mutation
LOCALLOOP=0;      % local loop removal
CROSSOVER = ["xalt_edges"];  % default crossover operator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load the data sets
datasetslist = dir('datasets/');datasetslist = dir('datasets/');
datasets=cell( size(datasetslist,1)-2,1);datasets=cell( size(datasetslist,1)-2 ,1);
for i=1:size(datasets,1);
    datasets{i} = datasetslist(i+2).name;
end

% start with first dataset
data = load(['datasets/' datasets{1}]);
x=data(:,1)/max([data(:,1);data(:,2)]);y=data(:,2)/max([data(:,1);data(:,2)]);
NVAR=size(data,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% initialise the user interface
fh = figure('Visible','off','Name','TSP Tool','Position',[0,0,1024,768]);
ah1 = axes('Parent',fh,'Position',[.1 .55 .4 .4]);
plot(x,y,'ko')
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
PARAMNUM=length(CROSSOVER)+length(NIND)+length(MAXGEN)+length(ELITIST)+length(PR_CROSS)+length(PR_MUT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results Table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elements = {CROSSOVER ,NIND,MAXGEN,ELITIST,PR_CROSS,PR_MUT}; %cell array with N vectors to combine
 combinations = cell(1, numel(elements)); %set up the varargout result
 [combinations{:}] = ndgrid(elements{:});
 combinations = cellfun(@(x) x(:), combinations,'uniformoutput',false); %there may be a better way to do this
 result = splitvars(table([combinations{:,:}])); % NumberOfCombinations by N matrix. Each row is unique.
result.Properties.VariableNames ={'CROSSOVER','NIND','MAXGEN','ELITIST','PR_CROSS','PR_MUT'};
result.Time=zeros(size(result,1),1);
result.ShortestPath=zeros(size(result,1),1);
result.Generations=zeros(size(result,1),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for crosso=CROSSOVER 
    for individiuals=NIND
        for maxgenerations=MAXGEN
            for elite=ELITIST
                for cross=PR_CROSS
                    for mut=PR_MUT
                        help_ShortestPath=zeros(10,1);
                        help_Generations=zeros(10,1);
                        help_Time=zeros(10,1);
                        for iter = 1:10 
                            tic;
                            [help_ShortestPath(iter),help_Generations(iter)]=run_ga_Project2019(x, y, individiuals, maxgenerations, NVAR, elite, STOP_PERCENTAGE, cross, mut, crosso, LOCALLOOP, ah1, ah2, ah3);
                            help_Time(iter)=toc;
                        end
                        result(i,{'ShortestPath','Generations'})={mean(nonzeros(help_ShortestPath)),mean(nonzeros(help_Generations))};                       
                        result(i,{'Time'})={mean(nonzeros(help_Time))};
                        i=i+1;
                    end
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VISUALISATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
result(1:5,:);
stackedplot(result);

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