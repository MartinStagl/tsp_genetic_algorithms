% choose random city
randCityIndex = randperm(n,1);
child2(1)=randCityIndex;
i=2;
randCityIndexOld=0;
pointers1=[];
pointers=[];
while size(child2,2)<n
    if(randCityIndexOld==randCityIndex)
        randCityIndex = randperm(n,1);
    end
    %select Pointersfrom Parents1
    pointers=[];
    for parentI=1:2
        l=1;m=1;
        if parentI==2
           pointers1= pointers(1:2);
        end
        pointers=[];
        parent=Parents(parentI, :);
        while size(pointers,2)<2
        if randCityIndex==1 
            if (~ismember(parent(n+1-m),child2))
                pointers(l)=parent(n+1-m);
                l=l+1;
            end
            if (~ismember(parent(randCityIndex+m),child2))
                pointers(l)=parent(randCityIndex+m);
                l=l+1;
            end
        elseif randCityIndex==n
            if (~ismember(parent(n-m),child2))
                pointers(l)=parent(n-m);
                l=l+1;
            end
            if (~ismember(parent(m),child2))
                pointers(l)=parent(m);
                l=l+1;
            end
        elseif(randCityIndex+m>n&randCityIndex-m>0)
            if (~ismember(parent(randCityIndex-m),child2))
                pointers(l)=parent(randCityIndex-m);
                l=l+1;
            end
            if (~ismember(parent(mod(randCityIndex+m,n)+1),child2))
                pointers(l)=parent(mod(randCityIndex+m,n)+1);
                l=l+1;
            end
        elseif(randCityIndex-m==0)
            if (~ismember(parent(1),child2))
                pointers(l)=parent(1);
                l=l+1;
            end
            if (~ismember(parent(mod(randCityIndex+m,n)+1),child2))
                pointers(l)=parent(mod(randCityIndex+m,n)+1);
                l=l+1;
            end
        else
            if (~ismember(parent(randCityIndex-m),child2))
                pointers(l)=parent(randCityIndex-m);
                l=l+1;
            end
            if (~ismember(parent(randCityIndex+1),child2))
                pointers(l)=parent(randCityIndex+m);
                l=l+1;
            end
        end
        m=m+1;
        end
    end
    pointers1(3:4)=pointers(1:2);
    pointers=pointers1;
    %sort citys by distance
    citys=[pointers;Dist(randCityIndex,pointers)];
    citys=sortrows(citys.',1);
    for newCity=1:size(citys,1)
        if (~ismember(citys(newCity,1),child2))
            child2(i)=citys(newCity,1);
            randCityIndexOld=randCityIndex;
            randCityIndex=citys(newCity,1);
            i=i+1;
            break;
        elseif (newCity==4)
            randCityIndexOld=randCityIndex;
        end
    end
end




% choose random city
randCityIndex = randperm(n,1);
child2(1)=randCityIndex;
i=2;
randCityIndexOld=0;
pointers=[];
while size(child2,2)<n
    if(randCityIndexOld==randCityIndex)
        randCityIndex = randperm(n,1);
    end
    %select Pointersfrom Parents1
    pointers=[];
    m=1;
    for parentI=1:2
        parent=Parents(parentI, :);
        sizeOfPointerLeft=size(pointers,2);
        sizeOfPointerRight=size(pointers,2);
        l=1;k=1;
        while (size(pointers,2)==sizeOfPointerLeft )
           if (randCityIndex-l>0)
            if (~ismember(parent(randCityIndex-l),child2)&&~ismember(parent(randCityIndex-l),pointers))
                pointers(m)=parent(randCityIndex-l);
                m=m+1;
            end
            l=l+1;
           else
              if (~ismember(parent(n-k),child2)&&~ismember(parent(n-k),pointers))
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
            if (~ismember(parent(randCityIndex+l),child2)&&~ismember(parent(randCityIndex+l),pointers))
                pointers(m)=parent(randCityIndex+l);
                m=m+1;
            end
            l=l+1;
           else
              if (~ismember(parent(k),child2)&&~ismember(parent(k),pointers))
                pointers(m)=parent(k);
                m=m+1;
              end
              k=k+1;
           end
        end
    end
    %sort citys by distance
    citys=[pointers;Dist(randCityIndex,pointers)];
    citys=sortrows(citys.',1);
    for newCity=1:size(citys,1)
        if (~ismember(citys(newCity,1),child2))
            child2(i)=citys(newCity,1);
            randCityIndexOld=randCityIndex;
            randCityIndex=citys(newCity,1);
            i=i+1;
            break;
        elseif (newCity==4)
            randCityIndexOld=randCityIndex;
        end
    end
end