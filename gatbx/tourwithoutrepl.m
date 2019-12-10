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
%Check the input values
K=10;
if (length(FitnV)-Nsel*K < 0)
    %error("Check Nsel and K in the Tournament selection without replacement.");
end

current_member = 1;
pomFitnV = FitnV;
NewChrIx = zeros(Nsel,1);

while (current_member <= Nsel)
    %Pick K individuals randomly without replacement
    pomFitnV = pomFitnV
    picked = sort(pomFitnV(randperm(length(pomFitnV),K)));
    
    %Compare these K individuals and select the best of them
<<<<<<< HEAD
    %best = 0;
    %for ind=1:K
    %    if picked(ind)>best
    %        best = picked(ind);
    %    end
    %end
    NewChrIx(current_member) = find(FitnV==picked(1,1),1);
    current_member = current_member+1;
    
    %throw out the already K selected members
    pomFitnV = pomFitnV(pomFitnV~=picked(1,1));  
=======
    best = picked(1);
    for ind=2:K
        if picked(ind)<best
            best = picked(ind);
        end
    end
    NewChrIx(current_member) = find(FitnV==best,1);
    current_member = current_member+1;
    
    %throw out the already K selected members
    pomFitnV = pomFitnV(pomFitnV~=best);  
>>>>>>> dcaf58dfe850c4d51a6eb998e659c8508b0e1930
end
end