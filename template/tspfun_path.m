%
% ObjVal = tspfun(Phen, Dist)
% Implementation of the TSP fitness function
%	Phen contains the phenocode of the matrix coded in path representation
%	Dist is the matrix with precalculated distances between each pair of cities
%	ObjVal is a vector with the fitness values for each candidate tour (=each row of Phen)
%

function ObjVal = tspfun_path(Phen, Dist);
    si=size(Phen,2);
	ObjVal=diag(Dist(Phen(:,1),Phen(:,2)),0);

    for t=3:si
        if (t==si)
            ObjVal=ObjVal+diag(Dist(Phen(:,t),Phen(:,1)),0);
        end
        ObjVal=ObjVal+diag(Dist(Phen(:,t-1),Phen(:,t)),0);
	end

% End of function

