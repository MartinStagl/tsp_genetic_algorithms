[~,~,stats] = anovan(result.ShortestPath,{result.CROSSOVER ,result.NIND,result.MAXGEN,result.ELITIST,result.PR_CROSS,result.PR_MUT},'model','interaction','varnames',{'CROSSOVER','NIND','MAXGEN','ELITIST','PR_CROSS','PR_MUT'});

results = multcompare(stats,'CType','hsd');

results