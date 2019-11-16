% Permutation Representations: Order 1 crossover (see chapter 4)
% The algorithm chooses 2 random indices where it will split the parents.
% The child takes the part between these indices from the parent1.
% Then we will add the rest of the "numbers" into the child array 
% in the same order as they appear in parent 2.

function child = crossover_order1(parent1, parent2)

n = length(parent1);

% choose 2 random slice points and sort them
randIdcs = sort(randperm(n,2));

child(1, randIdcs(1):randIdcs(2)) = parent1(1, randIdcs(1):randIdcs(2));

added = randIdcs(2) - randIdcs(1) + 1;
trackInd = randIdcs(2);
addInd = trackInd;

while (added ~= n)
    trackInd = trackInd + 1;
    if (trackInd > n)
        trackInd = 1;
    end
    if (ismember(parent2(trackInd), child) == 0)
        addInd = addInd + 1;
        if (addInd > n)
            addInd = 1;
        end
        child(addInd) = parent2(trackInd);
        added = added + 1;
    end
end