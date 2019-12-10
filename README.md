# Genetic Algorithms Project

[Links]
* https://www.overleaf.com/project/5dcffe110cbf6f000155d198

[Todo]
Tasks:

1. On Toledo, you can nd the GA Toolbox, the template program and tutorials about Matlab.
Test the Matlab program to solve a TSP.
### DONE
2. Perform a limited set of experiments by varying the parameters of the existing genetic algorithm
(population size, probabilities, . . . ) and evaluate the performance (quality of the solutions).
### DONE

3. Implement a stopping criterion that avoids that rather useless iterations (generations) are com-
puted.
### DONE

4. Implement and use another representation and appropriate crossover and mutation operators.
Perform some parameter tuning to identify proper combinations of the parameters.
### DONE

5. Test to which extent a local optimisation heuristic can improve the result.
* Implement Heuristic for Crossover -> Distance Preserving crossover DPX page 175
* Implement Tabu Search 180

6. Test the performance of your algorithm using some benchmark problems (available on Toledo)
and critically evaluate the achieved performance.
Keep in mind that for a large number of cities the search space is extremely large! If your
algorithm doesn't perform well for a rather small number of cities, it doesn't make sense to use
it for a benchmark problem with a large number of cities ...
Note: For most of the benchmark problems the length of the optimal tour is known. However,
the Matlab template program scales the data. Therefore this scaling must be switched o to be
able to compare your result with the optimal tour length.
### OPEN

7. You should select at least one task from the list below:
* (a) Implement and use two other parent selection methods, i.e. tness proportional selection
and tournament selection. Compare the results with those obtained using the default rank-
based selection.
* (b) Implement one survivor selection strategy (besides the already implemented elitism). Per-
form experiments and evaluate the results.
* (c) Implement and use one of the techniques aimed at preserving population diversity (e.g.
subpopulations/islands, crowding, . . . ). Perform experiments and evaluate the results.
* (d) Incorporate an adaptive or self-adaptive parameter control strategy (e.g. parameters that
depend on the state of the population, parameters that co-evolve with the population, . . . ).
Perform experiments and evaluate the results.
### IMPLEMENTATION DONE, TODO: TESTS, COMPARISONS

8. Write a report to describe your implementation and to explain your results. A template for the
report will be made available on Toledo. You must use this template and carefully follow the
guidelines of this template, in order to facilitate the correct evaluation of your project.
Note: A short report can contain a lot of information, if carefully written. Be precise but concise!
Do not repeat information from the handbook or slides.
### OPEN
