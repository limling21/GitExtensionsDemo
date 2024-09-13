% 滑动窗口 相关性分析，方差（距离中心点加权？）
% 滑动窗口会影响整个窗口的结果

% X:2880 * ndays
% R:相关系数，每一列上的点代表该天某个时刻与其余天的相关性
% width：窗口长度
function [R] = slipwindetect(X,width)

[time,ndays] = size(X);

%前后补0
X = [zeros((width-1)/2,ndays);X;zeros((width-1)/2,ndays);];

%将某一列的平均相关系数作为该点的相关系数，需扣除自相关 1
for i = 1:time
    temp = X(i:i+width-1,:);
    %若非零元素不足一半窗口长度，不予计算
    zeronum = length(find(temp(:,1)==0));
    if zeronum > (width-1)/2
        R(i,:) = zeros(1,ndays);
        continue;
    end
    
    rc = corrcoef(temp);
    R(i,:) = (sum(rc,2)'-1)/(ndays - 1);
end
               