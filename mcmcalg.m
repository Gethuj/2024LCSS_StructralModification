function [BestCost BestMatB] = mcmcalg(MatA, MatB, MatBInit)

[n m] = size(MatB);
R0 = 50000;
T = 1;
TStop = 10^-10;
Alpha = 10^-1;

MatBMod = MatBInit;%greedyalg(MatA, MatB);
MatQA = MatA;
MatQA = MatQA - diag(diag(MatQA)) + diag(1-2*abs(diag(MatA)));
CurrCost = length(find(MatB-MatBMod ~=0)) + (1+n*m)*length([coloring([MatA MatBMod]) coloring([MatQA MatBMod])]);

QSet = find(MatB==-1);
Q = length(QSet);

BestMatB = MatB;
BestCost = CurrCost;
while TStop <= T
    for r = 1:R0
        MatBTemp = MatBMod;
        sample = randsample(n*m+Q,1);
        if sample > n*m
            sample = QSet(sample - n*m);
        end
        bSet = unique([0 1 MatB(sample)]);
        bSet = bSet(bSet~=MatBMod(sample));
        b = bSet(randsample(length(bSet),1));
        MatBTemp(sample) = b;

        dist = length(find(MatB-MatBTemp ~=0));
        NextCost = dist + (1+n*m)*length([coloring([MatA MatBTemp]) coloring([MatQA MatBTemp])]);
        prob = min(1,exp((CurrCost-NextCost)/T));
        if rand(1)<= prob
            MatBMod = MatBTemp;
            CurrCost = NextCost;
        end
        if CurrCost < BestCost
            BestMatB = MatBMod;
            BestCost = CurrCost;
        end
    end
   T = T*Alpha;
end