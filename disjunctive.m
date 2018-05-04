function [d] = disjunctive(m1,m2)
%m,n: mass  mass  mass
%     value value value

m = m1;
n = m2;

d{1,1} = 'disjunctive';
d{2,1} = 'value';
%% ******************** disjunctive: union
flag = 0; % 0代表m与n的存在并集部分，且尚没有存在于最终的bpa中。
for i = 1:length(m(1,:))
    for j = 1:length(n(1,:))
        unionn = union(m{1,i},n{1,j});
        
        if strcmp(unionn,'') || length(unionn) == 0 
            flag = 1; % no union
        else
            for r = 1:length(d(1,:))
                if strcmp(unionn,d{1,r}) 
                    flag = 1; %the focal element already exist in disjuctive BPA
                    break;
                end
            end
        end
        
        if flag == 0
            d{1,length(d(1,:))+1} = unionn;
        end
        flag = 0;
    end
end
%% ******************** disjunctive value
for i = 2:length(d(1,:))
    d{2,i} = 0;
end
for i = 1:length(m(1,:))
    for j = 1:length(n(1,:))
        unionn = union(m{1,i},n{1,j});
        for r=2:length(d(1,:))
            if strcmp(d(1,r),unionn)
                d{2,r}=d{2,r} + m{2,i} * n{2,j};
            end
        end
    end
end

% d_size = size(d);
% d = d(1:d_size(1), 2:d_size(2));
% d = d';