% low level function for TSP mutation
% Representation is an integer specifying which encoding is used
%	1 : adjacency representation
%	2 : path representation
%

function NewChrom = scramble(OldChrom,Representation);

NewChrom=OldChrom;

if Representation==1 
	NewChrom=adj2path(NewChrom);
end

% select two positions in the tour

rndi=zeros(1,2);

while rndi(1)==rndi(2)
	rndi=rand_int(1,2,[1 length(NewChrom)]);
end
rndi = sort(rndi);

pom = NewChrom(rndi(1):rndi(2));

NewChrom(rndi(1):rndi(2)) = pom(randperm(length(pom)));

if Representation==1
	NewChrom=path2adj(NewChrom);
end


% End of function