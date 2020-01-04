import pandas as pd


def average_result(survivorMethod, q=None):
    average_path = 0
    average_time = 0
    count = 0
    for i in range(1, len(result)):
        if q is None:
            average_path += result['ShortestPath'][i]
            average_time += result['Time'][i]
            count += 1
        else:
            if (result['SurvivalMethode'][i] == survivorMethod) and (result['q'][i] == q):
                average_path += result['ShortestPath'][i]
                average_time += result['Time'][i]
                count += 1

    average_path = average_path / count
    average_time = average_time / count

    return [average_path, average_time]


result = pd.read_csv('results_ParameterTuning_Task6_2.csv')
survivorMethods = [1, 2]  # 1-Round-robin tournament: use parameter q
qs = [5, 10, 50, 100]
average_path_length = []
average_time = []

for survivorMethod in survivorMethods:
    if survivorMethod == 1:
        for q in qs:
            average_path_length.append(average_result(survivorMethod, q)[0])
            average_time.append(average_result(survivorMethod, q)[1])
    else:
        average_path_length.append(average_result(survivorMethod)[0])
        average_time.append(average_result(survivorMethod)[1])

dfObj = pd.DataFrame()
dfObj['Survivor Method'] = [1, 1, 1, 1, 2]
dfObj['q'] = ['5', '10', '50', '100', '-']
dfObj['Average path length'] = average_path_length
dfObj['Average time (s)'] = average_time
dfObj.to_csv('results_Task6_2.csv', sep='\t')

