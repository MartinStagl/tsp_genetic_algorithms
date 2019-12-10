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

NewChrIx = zeros(Nsel, 1);

% perform windowing
minFitnV = min(FitnV);
newFitnV = FitnV - minFitnV;

sumFitnV = sum(newFitnV);
probOfBeingPicked = newFitnV ./ sumFitnV;
selected = mink(probOfBeingPicked, Nsel);

for i=1:Nsel
    NewChrIx(i) = find(probOfBeingPicked == selected(i));
end


