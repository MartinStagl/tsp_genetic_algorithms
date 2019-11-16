% Partially Mapped Crossover opeator: read section 2.1.1. here:
% https://www.hindawi.com/journals/cin/2017/7430125/

function [child1, child2] = pmx(parent1, parent2)

n = length(parent1);

% choose 2 random slice points and sort them
randIdcs = sort(randperm(n,2));

% first initialisation of children - look at step (2) in the article
child1(1, randIdcs(1):randIdcs(2)) = parent2(1, randIdcs(1):randIdcs(2));
child2(1, randIdcs(1):randIdcs(2)) = parent1(1, randIdcs(1):randIdcs(2));

trackInd = randIdcs(2);

% arrays that will hold missing/empty spots for child1 and child2
missing1 = [];
missing2 = [];

% check step (3) in the article
while (trackInd - randIdcs(1)~= -1) && (trackInd - randIdcs(1)~= n-1)
    trackInd = trackInd + 1;
    if (trackInd > n)
        trackInd = 1;
    end
 
    if (ismember(parent1(trackInd), child1) == 0)
        child1(trackInd) = parent1(trackInd);
    else
        missing1 = [missing1, trackInd];
    end
    
    if (ismember(parent2(trackInd), child2) == 0)
        child2(trackInd) = parent2(trackInd);
    else
        missing2 = [missing2, trackInd];
    end 
end

% filling missing spots for child1 (step(4))
for i = 1:length(missing1)
    number = parent1(missing1(i));
    added = false;
    while (added == false)
        index = find(child1 == number);
        number = child2(index);
        if (ismember(number, child1) == false)
            child1(missing1(i)) = number;
            added = true;
        end
    end
end

% filling missing spots for child2 (step(5))
for i = 1:length(missing2)
    number = parent2(missing2(i));
    added = false;
    while (added == false)
        index = find(child2 == number);
        number = child1(index);
        if (ismember(number, child2) == false)
            child2(missing2(i)) = number;
            added = true;
        end
    end
end