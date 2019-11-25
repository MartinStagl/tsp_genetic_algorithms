%
% ObjVal = tspfun(Phen, Dist)
% Implementation of the TSP fitness function
%	Phen contains the phenocode of the matrix coded in path representation
%	Dist is the matrix with precalculated distances between each pair of cities
%	ObjVal is a vector with the fitness values for each candidate tour (=each row of Phen)
%

function ObjVal = tspfun_path(Phen, Dist);
    n = size(Phen, 2);
    pom = Dist(Phen(:,1),Phen(:, 2));
    ObjVal=pom(:, 1);
    t = 2;
	while rem(t,n)~=1
        if rem(t, n) == 0
           pom = Dist(Phen(:,t),Phen(:, 1));
        else
           pom = Dist(Phen(:,t),Phen(:, t+1));
        end
    	ObjVal=ObjVal+pom(:, 1);
        t = t+1;
	end


% End of function

