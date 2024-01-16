function [WhiteNode] = coloring(PatternMat)

[p q] = size(PatternMat);

WhiteNode = 1:p;
PatternMatMod = PatternMat;
RowIdx = WhiteNode;
ColIdx = 1:q;
while ~isempty(RowIdx)
    RowIdx = [];
    ColIdx = [];
    for j = 1:size(PatternMatMod,2)
        if (nnz(PatternMatMod(:,j))==1) & (sum(PatternMatMod(:,j))==1)
            RowIdx = [RowIdx find(PatternMatMod(:,j)==1)];
            ColIdx = [ColIdx j];
        end
        if (nnz(PatternMatMod(:,j))==0)
            ColIdx = [ColIdx j];
        end
    end
    WhiteNode(RowIdx) = [];
    PatternMatMod(RowIdx,:) = [];
    if ~isempty(PatternMatMod)
        PatternMatMod(:,ColIdx) = [];
    end
end
