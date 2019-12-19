% Tournament selection without replacement (an individual can only be picked once)
%
% Input parameters:
%    FitnV     - Column vector containing the fitness values of the
%                individuals in the population.
%    Nsel      - number of individuals to be selected
%
% Important parameter:
%    K         - number of members we want to select of a pool of Nsel individuals
%
% Output parameters:
%    NewChrIx  - column vector containing the indexes of the selected
%                individuals relative to the original population, shuffled.
%                The new population, ready for mating, can be obtained
%                by calculating OldChrom(NewChrIx,:).

function NewChrIx = tourwithoutrepl(FitnV, Nsel)

K=10;
current_member = 1;
pomFitnV = sort(FitnV);
NewChrIx = zeros(Nsel,1);

while (current_member <= Nsel)
    %Pick K individuals randomly without replacement
    permutation = randperm(length(pomFitnV),K);
    picked = sort(pomFitnV(permutation));
    
    indices = find(FitnV==picked(K));
    NewChrIx(current_member) = indices(1);
    current_member = current_member+1;
    
    %throw out the already selected best member
    pomFitnV(max(permutation)) = [];  
end
end