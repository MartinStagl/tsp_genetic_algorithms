function [path] = nearestneighbour(NVAR,Dist)
%NEARESTNEIGHBOUR(N) returns a vector containing a path of nearest cities starting with a
% random city of the integers 1:N.  For example, NEARESTNEIGHBOUR(6) might be [2 4 5 6 1 3].
start=randi(NVAR);
path = [start];

a=Dist(start,:); %Distances from initial city to all others
path(size(path)+1)=find(a==min(setdiff(a,min(a))),1); % find closest city with is not the start city

while size(path)<NVAR
    x=path(end);
    a=sort(Dist(x,:)); %Distance from chosen city to all the others
    %sizeOfPath=size(path,2);
    
    for i=2:size(a,2)
        newCitys=find(Dist(x,:)==a(i));
        for newCity=newCitys
            if(~ismember(newCity,path))
                path(size(path,2)+1)=newCity;
                break;
            end
        end
    end
    
    
    %while size(path,2)<=sizeOfPath %find closes city to the last chosen city with is not in the path
    %    minimum=min(nonzero(a));
    %    newCity=find(a==min(setdiff(a,minimum)),1);
    %    if(~ismember(newCity,path))
    %            path(size(path,2)+1)=newCity;
    %    else
    %        a(newCity)=[];
    %        %remove the city
    %    end
    %end
end
end

