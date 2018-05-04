function [p] = RCR(m1,m2)
%clear,clc
%m1={'ab', 0.4262; 'ac', 0.0474; 'b', 0.2158; 'bc',0.2747; 'c', 0.036};
%m2={'a', 0.55 ;'b', 0.1; 'ac', 0.35};
m = m1';
n = m2';

p{1,1} = 'mass'; 
p{2,1} = 'value'; %fusion result

[c,k]=conjunctive(m,n); %交集
[d]=disjunctive(m,n);   %并集
%% ******************** alpha,beta
beta = swbeta(k);
%beta = lwbeta(k);
alpha = 1-(1-k)*beta;
%% ******************** mass   
p(1,2:length(d(1,:)))=d(1,2:length(d(1,:))); %focal elements 
for i=2:length(c(1,:))
    flag=0; % 0代表有需要添加的元素
    for j=2:length(p(1,:))
        if strcmp(c{1,i},p{1,j})
            flag=1; %无不相同的元素
        end
    end
    if flag==0
       p{1,length(p(1,:))+1}=c{1,i};
    end
end
%% ******************** value
for i = 2:length(p(1,:))
    p{2,i} = 0;
end
for i=2:length(p(1,:))
    for j=2:length(c(1,:))
        if strcmp(p{1,i},c{1,j})
            p{2,i}=p{2,i}+beta*c{2,j};
        end
    end
    for j=2:length(d(1,:))
        if strcmp(p{1,i},d{1,j})
            p{2,i}=p{2,i}+alpha*d{2,i};
        end
    end
end
p_size = size(p);
p = p(1:p_size(1), 2:p_size(2));
p = p';
