function [ p ] = DempsterRule2(m1,m2)

% example:
% 
% m1 = {'a', 0.5; 'abc',0.5}; 
% m2 = {'a', 0.6; 'ab',0.4}; 
% 
% [p] = DempsterRule(m1,m2)




m = m1';
n = m2';


p{1,1} = 'mass';
p{2,1} = 'value';

flag = 0; % 0代表m与n的交集部分没有存在于最终的bpa中。


for i = 1:length(m(1,:))
    for j = 1:length(n(1,:))
        intersection = intersect(m{1,i},n{1,j});
        
        if strcmp(intersection,'') || length(intersection) == 0
            flag = 1;
        else
            for r = 1:length(p(1,:))
                if strcmp(intersection,p{1,r}) %该焦元已经存在
                    flag = 1;
                    break;
                end
            end
        end
        
        if flag == 0
            p{1,length(p(1,:))+1} = intersection;
        end
        flag = 0;
    end
end


for i = 2:length(p(1,:))
    p{2,i} = 0;
end

% p为运用Dempster组合规则融合m1、m2后的最终结果，其中列出了最终结果中会包含的子集。


k = 0;

for i = 1:length(m(1,:))
    for j = 1:length(n(1,:))
        intersection = intersect(m{1,i},n{1,j});
        if length(intersection) == 0
            k = k + m{2,i} * n{2,j};
        else
            for r = 2:length(p(1,:))
                if length(setxor(intersection,p{1,r})) == 0
                    p{2,r} = p{2,r} + m{2,i} * n{2,j};
                end
            end
        end
    end
end

   
for i = 2:length(p(1,:))
    if k == 1
        p{2,i} = 0;
    else
        p{2,i} = p{2,i} / (1-k);
    end
end

if k == 1
    p{1,length(p(1,:))+1} = 'FrameOfDiscerment';
    p{2,length(p(1,:))} = 1;
end


p_size = size(p);
p = p(1:p_size(1), 2:p_size(2));
p = p';