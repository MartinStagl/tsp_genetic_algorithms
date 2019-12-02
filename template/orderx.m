%order crossover for path represenation

function [child1, child2] = orderx(Parents);

parent1 = Parents(1, :);
parent2 = Parents(2, :);
n = length(parent1);

% choose 2 random slice points and sort them
randIdcs = sort(randperm(n,2));

% first initialisation of children - look at step (7) in the article
child1(1, randIdcs(1):randIdcs(2)) = parent1(1, randIdcs(1):randIdcs(2));
child2(1, randIdcs(1):randIdcs(2)) = parent2(1, randIdcs(1):randIdcs(2));

trackInd = randIdcs(2);

list1 = []; list2 = [];

for i = 1:n
    pom = rem(trackInd + i, n);
    if (pom == 0)
        pom = n;
    end
    list1 = [list1, parent2(pom)];
    list2 = [list2, parent1(pom)];
end

for i = randIdcs(1):randIdcs(2)
    list1 = list1(list1 ~= child1(i));
    list2 = list2(list2 ~= child2(i));
end

trackInd = randIdcs(2);

for i=1:numel(list1)
    trackInd = trackInd + 1;
    index = mod(trackInd, n);
    if index==0
        index = n;
    end
    child1(index) = list1(i);
end

trackInd = randIdcs(2);

for i=1:numel(list2)
    trackInd = trackInd + 1;
    index = mod(trackInd, n);
    if index==0
        index = n;
    end
    child2(index) = list2(i);
end
