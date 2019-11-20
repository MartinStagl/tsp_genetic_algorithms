%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND=[50];		% Number of individuals
MAXGEN=[100];		% Maximum no. of generations
NVAR=26;		% No. of variables
PRECI=1;		% Precision of variables
ELITIST=[0.05];    % percentage of the elite population
GGAP=1-ELITIST;		% Generation gap
STOP_PERCENTAGE=.95;    % percentage of equal fitness individuals for stopping
PR_CROSS=[.95];     % probability of crossover
PR_MUT=[.05];       % probability of mutation
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
axes(ah2);
xlabel('Generation');
ylabel('Distance (Min. - Gem. - Max.)');
ah3 = axes('Parent',fh,'Position',[.1 .1 .4 .4]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EXECUTION OF PARAMETER SELECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=1;
PARAMNUM=length(CROSSOVER)+length(NIND)+length(MAXGEN)+length(ELITIST)+length(PR_CROSS)+length(PR_MUT);

time=zeros(1,PARAMNUM+1);
best_end=zeros(1,PARAMNUM+1);
mean_fits_end=zeros(1,PARAMNUM+1);
gen=zeros(1,PARAMNUM+1);

for crosso=CROSSOVER 
    for individiuals=NIND
        for maxgenerations=MAXGEN
            for elite=ELITIST
                for cross=PR_CROSS
                    for mut=PR_MUT
                        tic;
[best_end(i),mean_fits_end(i),gen(i)]=run_ga_Project2019(x, y, individiuals, maxgenerations, NVAR, elite, STOP_PERCENTAGE, cross, mut, crosso, LOCALLOOP, ah1, ah2, ah3);
                        time(i)=toc;
                        i=i+1
                    end
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VISUALISATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boxplot(best_end,time)
%plot([0:gen],best(1:gen+1),'r-', [0:gen],mean_fits(1:gen+1),'black', [0:gen],worst(1:gen+1),'g-', [0:gen],best_average(1:gen+1),'blue');

