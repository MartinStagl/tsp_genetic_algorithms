% Unnamed Heuristic Crossover:
% https://www.hindawi.com/journals/cin/2017/7430125/
%
% UHX starts with random current city and copies it
% to child. It puts four pointers to right and left neighbors of
% current city in both parents and then compares which pointed
% city is nearest to current city and has not been copied to child
% yet. Such a node is selected as current city, copied to child and
% its pointer goes forward in its direction.

% ONLY for Path Prepresentation not Adjacency Presentation

function [child1, child2] = uhx(Parents,Dist)

n = size(Parents, 2);
parent1 = Parents(1, :);
parent2 = Parents(2, :);

% choose random city
randCity = randperm(n,1);
child1(1)=randCity;
i=2;
randCityIndexOld=0;
pointers=[];
while size(child1,2)<n
    if(randCityIndexOld==randCity)
        randCity = randperm(n,1);
    end
    %select Pointersfrom Parents1
    pointers=[];
    m=1;
    for parentI=1:2
        parent=Parents(parentI, :);
        sizeOfPointerLeft=size(pointers,2);
        sizeOfPointerRight=size(pointers,2);
        l=1;k=0;
        randCityIndex=find(parent==randCity,1);
        while (size(pointers,2)==sizeOfPointerLeft )
           if (randCityIndex-l>0)
            if (~ismember(parent(randCityIndex-l),child1))%&&~ismember(parent(randCityIndex-l),pointers)
                pointers(m)=parent(randCityIndex-l);
                m=m+1;
            end
            l=l+1;
           else
              if (~ismember(parent(n-k),child1))%&&~ismember(parent(n-k),pointers)
                pointers(m)=parent(n-k);
                m=m+1;
              end
              k=k+1;
           end
           
        end
        l=1;k=1;
        sizeOfPointerRight=size(pointers,2);
        while (size(pointers,2)==sizeOfPointerRight)
           if (randCityIndex+l<=n)
            if (~ismember(parent(randCityIndex+l),child1))%&&~ismember(parent(randCityIndex+l),pointers)
                pointers(m)=parent(randCityIndex+l);
                m=m+1;
            end
            l=l+1;
           else
              if (~ismember(parent(k),child1))%&&~ismember(parent(k),pointers)
                pointers(m)=parent(k);
                m=m+1;
              end
              k=k+1;
           end
        end
    end
    %sort citys by distance
    citys=[pointers;Dist(randCity,pointers)];
    citys=citys.';
    citys=sortrows(citys,2);
    for newCity=1:size(citys,2)
        if (~ismember(citys(newCity,1),child1))
            child1(i)=citys(newCity,1);
            randCityIndexOld=randCity;
            randCity=citys(newCity,1);
            i=i+1;
            break;
        elseif (newCity==4)
            randCityIndexOld=randCity;
        end
    end
end

% choose random city
randCity = randperm(n,1);
child2(1)=randCity;
i=2;
randCityIndexOld=0;
pointers=[];
while size(child2,2)<n
    if(randCityIndexOld==randCity)
        randCity = randperm(n,1);
    end
    %select Pointersfrom Parents1
    pointers=[];
    m=1;
    for parentI=1:2
        parent=Parents(parentI, :);
        sizeOfPointerLeft=size(pointers,2);
        sizeOfPointerRight=size(pointers,2);
        l=1;k=0;
        randCityIndex=find(parent==randCity,1);
        while (size(pointers,2)==sizeOfPointerLeft )
           if (randCityIndex-l>0)
            if (~ismember(parent(randCityIndex-l),child2))%&&~ismember(parent(randCityIndex-l),pointers)
                pointers(m)=parent(randCityIndex-l);
                m=m+1;
            end
            l=l+1;
           else
              if (~ismember(parent(n-k),child2))%&&~ismember(parent(n-k),pointers)
                pointers(m)=parent(n-k);
                m=m+1;
              end
              k=k+1;
           end
           
        end
        l=1;k=1;
        sizeOfPointerRight=size(pointers,2);
        while (size(pointers,2)==sizeOfPointerRight)
           if (randCityIndex+l<=n)
            if (~ismember(parent(randCityIndex+l),child2))%&&~ismember(parent(randCityIndex+l),pointers)
                pointers(m)=parent(randCityIndex+l);
                m=m+1;
            end
            l=l+1;
           else
              if (~ismember(parent(k),child2))%&&~ismember(parent(k),pointers)
                pointers(m)=parent(k);
                m=m+1;
              end
              k=k+1;
           end
        end
    end
    %sort citys by distance
    citys=[pointers;Dist(randCity,pointers)];
    citys=citys.';
    citys=sortrows(citys,2);
    for newCity=1:size(citys,2)
        if (~ismember(citys(newCity,1),child2))
            child2(i)=citys(newCity,1);
            randCityIndexOld=randCity;
            randCity=citys(newCity,1);
            i=i+1;
            break;
        elseif (newCity==4)
            randCityIndexOld=randCity;
        end
    end
end
end