% low level function for TSP mutation
% Representation is an integer specifying which encoding is used
%	1 : adjacency representation
%	2 : path representation
%

function NewChrom = swapping(OldChrom,Representation);

NewChrom=OldChrom;

if Representation==1 
	NewChrom=adj2path(NewChrom);
end

% choosing 2 random indices
randIndcs = randperm(length(OldChrom), 2);

val = OldChrom(randIndcs(1));
NewChrom(randIndcs(1)) = NewChrom(randIndcs(2));
NewChrom(randIndcs(2)) = val;

if Representation==1
	NewChrom=path2adj(NewChrom);
end


% End of function