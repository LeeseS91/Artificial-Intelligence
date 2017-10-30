function [initial prob1 prob2 prob3 prob4]=part4
patterns=nchoosek(0:9,5);

for i=1:10
       initial(i)=sum(patterns(:,1)==(i-1))./length(patterns);
end

for i=1:10
    for j=1:10
        prob1(i,j)=sum((patterns(:,2)==j-1).*(patterns(:,1)==i-1))./sum(patterns(:,1)==i-1);       
    end
end
for i=1:10
    for j=1:10
        prob2(i,j)=sum((patterns(:,3)==j-1).*(patterns(:,2)==i-1))./sum(patterns(:,2)==i-1);       
    end
end
for i=1:10
    for j=1:10
        prob3(i,j)=sum((patterns(:,4)==j-1).*(patterns(:,3)==i-1))./sum(patterns(:,3)==i-1);       
    end
end
for i=1:10
    for j=1:10
        prob4(i,j)=sum((patterns(:,5)==j-1).*(patterns(:,4)==i-1))./sum(patterns(:,4)==i-1);       
    end
end
prob1(isnan(prob1))=0;
prob2(isnan(prob2))=0;
prob3(isnan(prob3))=0;
prob4(isnan(prob4))=0;
