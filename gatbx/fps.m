% Fitness Proportional Selection (FPS) with windowing.
% This function performs parent selection based on individuals' fitnesses.
%
% Syntax:  NewChrIx = fps(FitnV, Nsel)
%
% Input parameters:
%    FitnV     - Column vector containing the fitness values of the
%                individuals in the population.
%    Nsel      - number of individuals to be selected
%
% Output parameters:
%    NewChrIx  - column vector containing the indexes of the selected
%                individuals relative to the original population, shuffled.
%                The new population, ready for mating, can be obtained
%                by calculating OldChrom(NewChrIx,:).

function NewChrIx = fps(FitnV, Nsel);
NewChrIx = [];

% perform windowing
minFitnV = min(FitnV);
newFitnV = FitnV - minFitnV;

sumFitnV = sum(newFitnV);
probOfBeingPicked = newFitnV ./ sumFitnV;
selected = maxk(probOfBeingPicked, Nsel);

previous = -1;

for i=1:Nsel
    if selected(i)~=previous
        NewChrIx = [NewChrIx; find(probOfBeingPicked == selected(i))];
        previous = selected(i);
    end
end


