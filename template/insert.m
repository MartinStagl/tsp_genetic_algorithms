% low level function for TSP mutation
% Representation is an integer specifying which encoding is used
%	1 : adjacency representation
%	2 : path representation
%

function NewChrom = insert(OldChrom,Representation);

NewChrom=OldChrom;

if Representation==1 
	NewChrom=adj2path(NewChrom);
end

% select two positions in the tour
rndi = randperm(length(OldChrom), 2);
rndi = sort(rndi);

val = NewChrom(rndi(2));
NewChrom(rndi(2)) = [];
pom = NewChrom(rndi(1)+1:length(NewChrom));

NewChrom = [NewChrom(1:rndi(1)), val, pom];

if Representation==1
	NewChrom=path2adj(NewChrom);
end


% End of function