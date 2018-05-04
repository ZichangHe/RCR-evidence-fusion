function [c,k]=conjunctive(m1,m2)

m = m1;
n = m2;

c{1,1} = 'conjunctive';
c{2,1} = 'value';
%% ******************** conjunctive: inter
flag = 0; % 0代表m与n的存在交集部分，且尚没有存在于最终的bpa中。
for i = 1:length(m(1,:))
    for j = 1:length(n(1,:))
        intersection = intersect(m{1,i},n{1,j});
        
        if strcmp(intersection,'') || length(intersection) == 0 
            flag = 1; %compare: no intersect
        else
            for r = 1:length(c(1,:))
                if strcmp(intersection,c{1,r}) 
                    flag = 1; %the focal element already exist in conjunctive BPA
                    break;
                end
            end
        end
        
        if flag == 0
            c{1,length(c(1,:))+1} = intersection;
        end
        flag = 0;
    end
end
%% ******************** Global conflict and conjunctive value
for i = 2:length(c(1,:))
    c{2,i} = 0;
end
k = 0;
for i = 1:length(m(1,:))
    for j = 1:length(n(1,:))
        intersection = intersect(m{1,i},n{1,j});
        if length(intersection) == 0
            k = k + m{2,i} * n{2,j};
        else
            for r = 2:length(c(1,:))
                if length(setxor(intersection,c{1,r})) == 0
                    c{2,r} = c{2,r} + m{2,i} * n{2,j};
                end
            end
        end
    end
end

% c_size = size(c);
% c = c(1:c_size(1), 2:c_size(2));
% c = c';