data_task1<-read.csv("template/results_ParameterTuning_Task1.csv", header=T)
data_task2<-read.csv("template/results_ParameterTuning_Task2.csv", header=T)
names(data_task1)
library(tidyverse)

data_task1_aggregated<-data_task1%>%group_by(CROSSOVER,NIND ,MAXGEN,ELITIST,PR_CROSS,PR_MUT,stoppingCriteria,n_percentage,delta,InitializationMethode,RepresentationMethode) %>%summarise(mean_ShortestPath=mean(ShortestPath,na.rm=T),mean_Generations=mean(Generations))%>%filter(mean_ShortestPath>0)%>%arrange(mean_ShortestPath)
data_task1_aggregated[1:10,]
names(data_task1_aggregated)

data_task2_aggregated<-data_task2%>%group_by(CROSSOVER,NIND ,MAXGEN,ELITIST,PR_CROSS,PR_MUT,stoppingCriteria,n_percentage,delta,InitializationMethode,RepresentationMethode) %>%summarise(mean_ShortestPath=mean(ShortestPath,na.rm=T),mean_Generations=mean(Generations))%>%filter(mean_ShortestPath>0)%>%arrange(mean_ShortestPath)
data_task2_aggregated[1:10,]
names(data_task2_aggregated)

x=data_task1[data_task1$NIND==128&data_task1$MAXGEN==100&data_task1$ELITIST==0.05&data_task1$PR_CROSS==0.05&data_task1$PR_MUT==0.95,'ShortestPath']
y=data_task2[data_task2$NIND==128&data_task2$MAXGEN==100&data_task2$stoppingCriteria==1&data_task2$n_percentage==0.2&data_task2$delta==50,'ShortestPath']

t.test(x,y,paired = T)
wilcox.test(x,y,paired = T)

data_task3_adj<-read.csv("template/results_ParameterTuning_Task3_adj.csv", header=T)
data_task3_path<-read.csv("template/results_ParameterTuning_Task3_path.csv", header=T)

data_task3_adj_aggregated<-data_task3_adj%>%group_by(CROSSOVER,NIND ,MAXGEN,ELITIST,PR_CROSS,PR_MUT,stoppingCriteria,n_percentage,delta,InitializationMethode,RepresentationMethode) %>%summarise(mean_ShortestPath=mean(ShortestPath,na.rm=T),mean_Generations=mean(Generations))%>%filter(mean_ShortestPath>0)%>%arrange(mean_ShortestPath)
data_task3_adj_aggregated[1:10,]
names(data_task3_adj_aggregated)

data_task3_path_aggregated<-data_task3_path%>%group_by(CROSSOVER,NIND ,MAXGEN,ELITIST,PR_CROSS,PR_MUT,stoppingCriteria,n_percentage,delta,InitializationMethode,RepresentationMethode) %>%summarise(mean_ShortestPath=mean(ShortestPath,na.rm=T),mean_Generations=mean(Generations))%>%filter(mean_ShortestPath>0)%>%arrange(mean_ShortestPath)
data_task3_path_aggregated[1:10,]
names(data_task3_path_aggregated)

z=data_task3_adj[data_task3_adj$CROSSOVER=='x_orderx'&data_task3_adj$InitializationMethode==2&data_task3_adj$MutationMethode=='inversion'&data_task3_adj$NIND==300&data_task3_adj$MAXGEN==300&data_task3_adj$ELITIST==0.05&data_task3_adj$PR_CROSS==0.65&data_task3_adj$PR_MUT==0.3,'ShortestPath']

v=data_task3_path[data_task3_path$CROSSOVER=='x_orderx'&data_task3_path$InitializationMethode==2&data_task3_path$MutationMethode=='inversion'&data_task3_path$NIND==300&data_task3_path$MAXGEN==300&data_task3_path$ELITIST==0.1&data_task3_path$PR_CROSS==0.7&data_task3_path$PR_MUT==0.3,'Time']

t.test(x,z,paired = T)
wilcox.test(x,z,paired = T)

t.test(x,v,paired = T)
wilcox.test(x,v,paired = T)



data_task4<-read.csv("template/results_ParameterTuning_Task4.csv", header=T)

head(data_task4)

data_task4_aggregated<-data_task4%>%group_by_at(vars(-Generations,-ShortestPath,-Time,-NumberOfRuns))%>%
  summarise(mean_ShortestPath=mean(ShortestPath,na.rm=T),mean_Generations=mean(Generations))%>%
  filter(mean_ShortestPath>0)%>%arrange(mean_ShortestPath)
data_task4_aggregated[1:10,]
names(data_task4_aggregated)

w=data_task4[data_task4$CROSSOVER=='uhx'&data_task4$InitializationMethode==2&
               data_task4$MutationMethode=='reciprocal_exchange'&data_task4$NIND==300&
               data_task4$MAXGEN==300&data_task4$ELITIST==0.05&data_task4$PR_CROSS==0.7&
               data_task4$PR_MUT==0.15,'Time']

t.test(x,w,paired = T)
wilcox.test(x,w,paired = T)




data_task5_1<-read.csv("template/results_ParameterTuning_Task5_d131.csv", header=T)
data_task5_1_SGA<-read.csv("template/results_ParameterTuning_Task5_SGA_d131.csv", header=T)
t.test(data_task5_1_SGA$ShortestPath,data_task5_1$ShortestPath,paired = T)
wilcox.test(data_task5_1_SGA$ShortestPath,data_task5_1$ShortestPath,paired = T)

data_task5_2<-read.csv("template/results_ParameterTuning_Task5_d380.csv", header=T)
data_task5_2_SGA<-read.csv("template/results_ParameterTuning_Task5_SGA_d380.csv", header=T)
t.test(data_task5_2_SGA$ShortestPath,data_task5_2$ShortestPath,paired = T)
wilcox.test(data_task5_2_SGA$ShortestPath,data_task5_2$ShortestPath,paired = T)

data_task5_3<-read.csv("template/results_ParameterTuning_Task5_d662.csv", header=T)
data_task5_3_SGA<-read.csv("template/results_ParameterTuning_Task5_SGA_d662.csv", header=T)
t.test(data_task5_3_SGA$ShortestPath,data_task5_3$ShortestPath,paired = T)
wilcox.test(data_task5_3_SGA$ShortestPath,data_task5_3$ShortestPath,paired = T)

data_task5_4<-read.csv("template/results_ParameterTuning_Task5_d711.csv", header=T)
data_task5_4_SGA<-read.csv("template/results_ParameterTuning_Task5_SGA_d711.csv", header=T)
t.test(data_task5_4_SGA$ShortestPath,data_task5_4$ShortestPath,paired = T)
wilcox.test(data_task5_4_SGA$ShortestPath,data_task5_4$ShortestPath,paired = T)


data_task6<-read.csv("template/results_ParameterTuning_Task6_2.csv", header=T)

head(data_task6)

data_task6_aggregated<-data_task6%>%group_by_at(vars(-Generations,-ShortestPath,-Time,-NumberOfRuns))%>%
  summarise(mean_ShortestPath=mean(ShortestPath,na.rm=T),mean_Generations=mean(Generations))%>%
  filter(mean_ShortestPath>0)%>%arrange(mean_ShortestPath)
data_task6_aggregated[1:10,]
names(data_task6_aggregated)

u=data_task6[data_task6$CROSSOVER=='uhx'&data_task6$InitializationMethode==2&
               data_task6$MutationMethode=='inversion'&data_task6$NIND==300&
               data_task6$MAXGEN==100&data_task6$ELITIST==0.05&data_task6$PR_CROSS==0.7&
               data_task6$PR_MUT==0.3&data_task6$q==5&data_task6$SurvivalMethode==1,'ShortestPath']
u
t.test(x,u,paired = T)
wilcox.test(x,u,paired = T)
                                                                                                                                                                  