function [CurrCost MatBMod] = greedyalg(MatA, MatB)

[n m] = size(MatB);
MatBMod = MatB;
MatQA = MatA;
MatQA = MatQA - diag(diag(MatQA)) + diag(1-2*abs(diag(MatA)));
CurrCost =  (1+n*m)*length([coloring([MatA MatB]) coloring([MatQA MatB])]);

WhiteNodes = union(coloring([MatA MatB]), coloring([MatQA MatB]));
ColumnsAvail = 1:m;
while ~isempty(WhiteNodes)
    for i = WhiteNodes
        for j = ColumnsAvail
            MatBTemp = MatBMod;
            MatBTemp(WhiteNodes,j) = 0;
            MatBTemp(i,j) = 1;
            dist = length(find(MatB-MatBTemp ~=0));
            c = dist + (1+n*m)*length([coloring([MatA MatBTemp]) coloring([MatQA MatBTemp])]);
            if c<CurrCost
            	SolMat = MatBTemp;
                SolIndx = j;
                CurrCost = c;
            end
        end
    end
    MatBMod = SolMat;
    WhiteNodes = union(coloring([MatA MatBMod]), coloring([MatQA MatBMod]));
    ColumnsAvail = setdiff(ColumnsAvail,SolIndx);
end