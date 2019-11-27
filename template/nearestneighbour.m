function [path] = nearestneighbour(NVAR,Dist)
%NEARESTNEIGHBOUR(N) returns a vector containing a path of nearest cities starting with a
% random city of the integers 1:N.  For example, NEARESTNEIGHBOUR(6) might be [2 4 5 6 1 3].
start=randi(NVAR);
path = [start];

a=Dist(start,:)
path(size(path)+1)=find(a==min(setdiff(a,min(a))))

while size(path)<NVAR
    paths=size(path,2)
    x=path(paths)
    a=sort(nonzeros(Dist(x,:)));
    i=2
    while size(path,2)<=paths
        newCity=find(Dist(x,:)==a(i))
        if(~ismember(newCity,path))
                path(size(path,2)+1)=newCity
        else
            i=i+1
        end
    end
end
end

