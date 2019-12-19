data = round(10*rand(10,4));
data(:,2)=2*data(:,2);
data(:,3)=3*data(:,3);
data(:,4)=2*3*data(:,4);
group = {reshape(repmat('A':'B',2,1),4,1) repmat((1:2)',2,1)};
boxplot(data,group)