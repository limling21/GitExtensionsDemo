% �������� ����Է���������������ĵ��Ȩ����
% �������ڻ�Ӱ���������ڵĽ��

% X:2880 * ndays
% R:���ϵ����ÿһ���ϵĵ�������ĳ��ʱ����������������
% width�����ڳ���
function [R] = slipwindetect(X,width)

[time,ndays] = size(X);

%ǰ��0
X = [zeros((width-1)/2,ndays);X;zeros((width-1)/2,ndays);];

%��ĳһ�е�ƽ�����ϵ����Ϊ�õ�����ϵ������۳������ 1
for i = 1:time
    temp = X(i:i+width-1,:);
    %������Ԫ�ز���һ�봰�ڳ��ȣ��������
    zeronum = length(find(temp(:,1)==0));
    if zeronum > (width-1)/2
        R(i,:) = zeros(1,ndays);
        continue;
    end
    
    rc = corrcoef(temp);
    R(i,:) = (sum(rc,2)'-1)/(ndays - 1);
end
               