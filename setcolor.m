function setcolor(HA)
DarkGreen   = [  0       0.5000       0  ];
LightGreen  = [0.4660    0.6740    0.1880];
LightBlue   = [   0        0.8        1  ];
SkyBlue     = [  0       0.4470    0.7410];
Purple      = [0.4940    0.1840    0.5560];
DarkYellow  = [0.9290    0.6940    0.1250];
Orange      = [0.8500    0.3250    0.0980];
BrickRed    = [0.6350    0.0780    0.1840];
DarkCyan    = [   0       0.6        0.6 ];

ColorOrder = [BrickRed; DarkYellow; DarkGreen; BrickRed; DarkYellow; DarkGreen;];

for index = 1:length(HA)
    set(HA(index),'color', ColorOrder(index,:));
end;