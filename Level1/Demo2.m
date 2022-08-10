clear
close all

O = csvread('Dataset.csv', 1, 0);
X = zeros(length(O),5);
Weight = [8 4 1 1];

for I = 1:length(O)
    Xi = O(I,2:1025);
    X(I,:) = [O(I,1), mean(Xi), std(Xi), skewness(Xi), kurtosis(Xi)];
end

U = 200;
Caos = randperm(length(O));

Y = X(Caos,:);

R = Y(1:U,:);
S = Y(U+1:length(O),:);
N = zeros(length(R), 5);

for Rj = 1:length(R)
    K = (R(Rj,2:5)-(S(:,2:5)));
    K = abs(K);
    K = K.*Weight;
    K = sum(K,2);
    K = [S(:,1), K(:)];
    K = sortrows(K,2);
    K = K(1:3,:);
    s = mode(K(:,1));
    N(Rj,:) = [R(Rj,1), s, s~=R(Rj,1), R(Rj,1)~=0&s==0, R(Rj,1)==0&s~=0];
end

G1 = 100-(100*sum(N(:,3))/U)
G2 = 100-(100*sum(N(:,4))/U)
G3 = 100-(100*sum(N(:,5))/U)