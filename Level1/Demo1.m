clear
close all

O = csvread('Dataset.csv', 1, 0);
O_size = size(O);
X = zeros(O_size(1),5);
U = 100;
for I = 1:O_size(1)
    Xi = O(I,2:1025);
    X(I,:) = [O(I,1), mean(Xi), std(Xi), skewness(Xi), kurtosis(Xi)];
end

for I = 1:O_size(1)
    Xi = O(I,2:1025);
    X(I,:) = [O(I,1), mean(Xi), std(Xi), skewness(Xi), kurtosis(Xi)];
end

Caos = randperm(length(X));
Ri = Caos(1:U);
Si = Caos(U+1:length(X));

R = X(Ri,:);
S = X(Si,:);

M = [R(:,1), zeros(U,3)];

for Rj = 1:length(R)
    Min = 1000;
    for Sj = 1:length(S)
        D = sqrt(sum((R(Rj,2:5) - S(Sj,2:5)) .^ 2));
        if(Min > D)
            Min = D;
            M(Rj,2) = S(Sj, 1);
        end
    end
    if(M(Rj,2) ~= M(Rj,1))
        M(Rj,3) = 1;
    end
    if(M(Rj,1) > 0 && M(Rj,2) == 0)
        M(Rj,4) = 1;
    end        
end

sum(M(:,3))
sum(M(:,4))