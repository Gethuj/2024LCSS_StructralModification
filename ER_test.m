home;
clear all;
close all;

q = 0.1;
pList = [0.1 0.45 0.8];
lt_p = length(pList);
n = 10;
mlist = 5:10;
lt_m = length(mlist);

maxiter = 100;
cost_greedy = zeros(lt_p,lt_m);
cost_mcmc = zeros(lt_p,lt_m);


for ip = 1:lt_p
    p = pList(ip);
    for im = 1:lt_m
        m = mlist(im);
    	for iter = 1:maxiter
        [p m iter]    
            Mat = zeros(n,n+m);
            RandomMat = rand(n,n+m);
            StarSet = find(RandomMat<p+q);
            QMarkSet = find(RandomMat<q);
            Mat(StarSet) = 1;
            Mat(QMarkSet) = -1;
            
           cost_greedy(ip,im) = cost_greedy(ip,im)+greedyalg(Mat(:,1:n),Mat(:,1:n));
           cost_mcmc(ip,im) = cost_mcmc(ip,im)+mcmcalg(Mat(:,1:n),Mat(:,1:n));
        
        end
    end    
end

cost_greedy = cost_greedy/maxiter;
cost_mcmc = cost_mcmc/maxiter;

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
PlotAlt(1) = plot(mlist,cost_greedy(1,:),'k--','DisplayName', 'Greedy');
hold on;
PlotAlt(2) = plot(mlist,cost_mcmc(1,:),'k-', 'DisplayName', 'MCMC');

for ip =lt_p:-1:1
    PlotInx(ip+lt_p) = plot(mlist,cost_greedy(ip,:),'--', 'Marker', MarkerOrder(ip), 'Color', ColorOrder(ip,:),'HandleVisibility','off');
    hold on;
    PlotInx(ip) = plot( mlist,cost_mcmc(ip,:),'-', 'Marker', MarkerOrder(ip), 'Color', ColorOrder(ip,:), 'DisplayName', ['p='  num2str(pList(ip))]);
end

xlabel('Number of columns in the input matrix m');
ylabel('Cost c');

legend(PlotInx(lt_p:-1:1), 'Location','SouthEast');
AxesHandle = axes('position',get(gca,'position'),'visible','off');
legend(AxesHandle,PlotAlt,'Location','NorthWest');

saveas(gca, 'ERTest_Varym');
saveas(gca, 'ERTest_Varym', 'epsc');


