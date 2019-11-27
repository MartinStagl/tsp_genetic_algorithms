function [best_end,gen] = run_ga_Project2019(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}

% Own Parameters to optimize later:
% Stopping Criteria (stop EA when criteria holds): 
% if stoppingCriteria is 1 then:
%   if E_1(T)=min(F) stays in the interval [E_1(T)-delta,E_1(T)+delta] for n_percentage of following
%   generations
% if stoppingCriteria is 2 then:
%   if E_2(T)=mean(F) stays in the interval [E_1(T)-delta,E_1(T)+delta] for n_percentage of following
%   generation
% if stoppingCriteria is 3 then:
%   if E_3(T)=mean(min(F)) stays in the interval [E_1(T)-delta,E_1(T)+delta] for n_percentage of following
%   generations
stoppingCriteria=2;
% percentage of generations the EA will stop if they produce the same
% output for several generations
n_percentage=0.1;
% tuning parameter for stopping criteria
delta=0.02; 


        GGAP = 1 - ELITIST;
        mean_fits=zeros(1,MAXGEN+1);
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR);
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        % initialize population
        Chrom=zeros(NIND,NVAR);
        for row=1:NIND
            %adjacency representation
        	%Chrom(row,:)=path2adj(randperm(NVAR));
            %adjacency representation with heuristic
            Chrom(row,:)=path2adj(nearestneighbour(NVAR,Dist));
            %path representation
            %----------------------------------------
            %here for heuristic initialization
            %Chrom(row,:)=randperm(NVAR);
            %Chrom(row,:)=nearestneighbour(NVAR,Dist);
            
            %----------------------------------------
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        ObjV = tspfun(Chrom,Dist);
        %ObjV = tspfun_path(Chrom,Dist);
        best=zeros(1,MAXGEN);
        best_average=zeros(1,MAXGEN);
        
        % generational loop    with additional stopping criteria:
        % the Stopping criteria is if the (Mean|Minimum) fitness value of a
        % population over generations is not changing in the further n% of 
        % the generations the stopping criteria will hold and the programm
        % exits
        maxEqualGeneration=MAXGEN*n_percentage;
        n_end=0;
        
        while gen<MAXGEN 
            
            sObjV=sort(ObjV);
          	best(gen+1)=min(ObjV);
            best_average(gen+1)=mean(nonzeros(best));
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum)
                    break;
                end
            end

            
            visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3,best_average);
            %visualizeTSP(x,y,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3,best_average);

            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
        	%assign fitness values to entire population
        	FitnV=ranking(ObjV);
        	%select individuals for breeding
        	SelCh=select('sus', Chrom, FitnV, GGAP);
        	%recombine individuals (crossover)
            SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            SelCh=mutateTSP('inversion',SelCh,PR_MUT);
            
            %evaluate offspring, call objective function
            ObjVSel = tspfun(SelCh,Dist);
        	%ObjVSel = tspfun_path(SelCh,Dist);
            
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);     
            
            %----------------------------------------------------------
            % here the Stopping code: if n_end (=number of consecutive elements) are the same
            % as the maxEqualGenerations then we should terminate the
            % programm.
            %----------------------------------------------------------
            if(stoppingCriteria==1)
                % E_1
                di=abs(diff(best(1:gen+1)))
                di(di<delta)=0;
                i = find(di);
                n = [i numel(best(1:gen+1))] - [0 i];
                n_end=n(end);
            elseif(stoppingCriteria==2)
                % E_2
                di=abs(diff(mean_fits(1:gen+1)))
                di(di<delta)=0;
                i = find(di);
                n = [i numel(mean_fits(1:gen+1))] - [0 i];
                n_end=n(end);
            elseif(stoppingCriteria==3 )
                % E_3
                di=abs(diff(best_average(1:gen+1)))
                di(di<delta)=0;
                i = find(di);
                n = [i numel(best_average(1:gen+1))] - [0 i];
                n_end=n(end);
            end  
            if n_end==1
                    maxEqualGeneration=ceil(gen+1*n_percentage);
            end
            if(n_end>maxEqualGeneration &maxEqualGeneration>5)
                 break;
            end
            
            %increment generation counter
        	gen=gen+1; 
        end 
        best_end=best(end);
end
