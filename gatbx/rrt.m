% Round-robin tournament
% Survivor Selection Mechanism (replacement strategy)
% This algorithm is performed after creation of offspring from the
% selected parents.
%
% Syntax:  NewChrIx = rrt(FitnV, Nsel)
%
% Input parameters:
%    FitnV     - Column vector containing the fitness values of the
%                individuals in the population AND the offspring.
%    Nsel      - number of individuals to be selected
%
% Output parameters:
%    NewChrIx  - column vector containing the indexes of the selected
%                individuals for the next generation.

function NewChrIx = rrt(FitnV, Nsel);

% parameter q allows tuning selection pressure
q = 10;

n = length(FitnV);
wins = zeros(n, 1);

for individual = 1:n
    randomIx = randperm(n);
    randomIx = randomIx(randomIx~=individual);
    opponents = randomIx(1:q);
    
    for i = 1:length(opponents)
        if FitnV(individual) < FitnV(opponents(i))
            wins(individual) = wins(individual) + 1;
        elseif FitnV(individual) > FitnV(opponents(i))
            wins(opponents(i)) = wins(opponents(i)) + 1;
        end
    end
end

% select Nsel individuals with highest number of wins
[selected, NewChrIx] = maxk(wins(:), Nsel);