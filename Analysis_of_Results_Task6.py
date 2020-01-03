import pandas as pd


def find_best_result(selectionMethod):
    best_path = 1000
    time = 0
    for i in range(1, len(result)):
        if (result['SelectionMethode'][i] == selectionMethod) and (result['ShortestPath'][i] < best_path):
            best_path = result['ShortestPath'][i]
            time = result['Time'][i]

    return [best_path, time]


result = pd.read_csv('results_ParameterTuning_Task6.csv')
selectionMethods = ['sus', 'fps', 'tourwithoutrepl']
best_paths = []
times = []

for selectionMethod in selectionMethods:
    best_paths.append(find_best_result(selectionMethod)[0])
    times.append(find_best_result(selectionMethod)[1])

dfObj = pd.DataFrame()
dfObj['Selection Method'] = selectionMethods
dfObj['Best path'] = best_paths
dfObj['Time (s)'] = times
dfObj.to_csv('bestResults_Task6.csv', sep='\t')

