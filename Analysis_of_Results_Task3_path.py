import pandas as pd


def count_average_length(crossover, pr_cross, mutation, pr_mut, elitist):
    sum_length = 0
    sum_time = 0
    count = 0
    for i in range(1, len(result)):
        if result['CROSSOVER'][i] == crossover and result['PR_CROSS'][i] == pr_cross \
                and result['MutationMethode'][i] == mutation and result['PR_MUT'][i] == pr_mut \
                and result['ELITIST'][i] == elitist and result['InitializationMethode'][i] == 2:
            count += 1
            sum_length += result['ShortestPath'][i]
            sum_time += result['Time'][i]
    average_len = sum_length / count
    average_time = sum_time / count

    return [average_len, average_time]


result = pd.read_csv('results_ParameterTuning_Task3_path.csv')

# parameters
crossover = ['xalt_edges', 'xpmx', 'x_orderx']
pr_cross = [0.7, 0.65, 0.15]
mutation = ['inversion', 'reciprocal_exchange', 'scramble', 'insert', 'swapping']
pr_mut = [0.15, 0.3, 0.7]
elitist = [0.01, 0.05, 0.1]

combinations = []
for cross in crossover:
    for pr_cr in pr_cross:
        for mut in mutation:
            for pr_m in pr_mut:
                for elit in elitist:
                    combinations.append({
                        'CROSSOVER': cross,
                        'PR_CROSS': pr_cr,
                        'MutationMethode': mut,
                        'PR_MUT': pr_m,
                        'ELITIST': elit
                    })

average_length = []
average_time = []
for combination in combinations:
    average_length.append(count_average_length(combination['CROSSOVER'], combination['PR_CROSS'], combination['MutationMethode'], combination['PR_MUT'], combination['ELITIST'])[0])
    average_time.append(count_average_length(combination['CROSSOVER'], combination['PR_CROSS'], combination['MutationMethode'], combination['PR_MUT'], combination['ELITIST'])[1])

# save mean path values for all possible combinations of our parameters
dfObj = pd.DataFrame(combinations, columns=['CROSSOVER', 'PR_CROSS', 'MutationMethode', 'PR_MUT', 'ELITIST'])
dfObj['Average_path_length'] = average_length
dfObj['Average_time'] = average_time
dfObj.to_csv('filteredResults_Task3_path.csv', sep='\t')

# print only 10 best paths
best_ten = dfObj.sort_values(by=['Average_path_length'], ascending=True)
best_ten = best_ten[:10]
best_ten.to_csv('best_10_path.csv', sep='\t')
