home;
clear all;
close all;
N=12;
cost_greedy = zeros(1,N);
cost_mcmc = zeros(1,N);
optcost = zeros(1,N);
for indx = 1:N
    n = indx+3
    A = diag(-1*ones(1,n)) + diag(ones(1,n-1),1) + diag(ones(1,n-1),-1);
    Asub = diag(-1*ones(1,3)) + diag(ones(1,2),1) + diag(ones(1,2),-1);
    A = [A ones(n,3); ones(3,n) Asub];
    B =[1 zeros(1,3); zeros(n-1,4); zeros(3,1) eye(3)];
    optcost(indx) = length(find(B~=0))+(n^2+1)*length(coloring([A B]));
    
    B = zeros(n+3,n+3);
    [c_greedy B_greedy] =  greedyalg(A,B);
    cost_greedy(indx) = c_greedy;
	cost_mcmc(indx) = mcmcalg(A,B,B_greedy);
    
end

DarkGreen   = [  0       0.5000       0  ];
LightGreen  = [0.4660    0.6740    0.1880];
LightBlue   = [   0        0.8        1  ];
SkyBlue     = [  0       0.4470    0.7410];
Purple      = [0.4940    0.1840    0.5560];
DarkYellow  = [0.9290    0.6940    0.1250];
Orange      = [0.8500    0.3250    0.0980];
BrickRed    = [0.6350    0.0780    0.1840];
DarkCyan    = [   0       0.6        0.6 ];

ColorOrder = [BrickRed; DarkYellow; DarkGreen;];
MarkerOrder = ['*', 'o', 's'];
figprop;
close all;
plot(7:N+6,cost_greedy,'|--','DisplayName', 'Greedy');
hold on;
plot(7:N+6,cost_mcmc,'d-', 'DisplayName', 'MCMC');
plot(7:N+6,optcost,'x:','DisplayName', 'Optimal Cost', 'Color', LightGreen);


xlabel('State dimension n');
ylabel('Cost c');

legend('Location','SouthEast');

save CornerCaseTest.mat
saveas(gca, 'CornerCaseTest');
saveas(gca, 'CornerCaseTest', 'epsc');
