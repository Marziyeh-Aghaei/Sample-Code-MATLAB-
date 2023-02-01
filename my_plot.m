
close all
clc
clear all


Data0=load(['simulation_data\Oil_0_Trade_0_i_20.mat']);
Data=load(['simulation_data\Oil_60_Trade_30_i_20.mat']);
%%
Data.X(23,:) = Data.s(:);
Data0.X(23,:) = Data0.s(:);
Data.X(24,:) = Data.imp(:);
Data0.X(24,:) = Data0.imp(:);
Data.X(25,:) = Data.exp(:);
Data0.X(25,:) = Data0.exp(:);
Data.X(26,:) = Data.g(:);
Data0.X(26,:) = Data0.g(:);
Data.X(27,:) = Data.Tax(:);
Data0.X(27,:) = Data0.Tax(:);

X = (Data.X(:,:)-Data.X(:,1))./Data.X(:,1) *100;
X0 = (Data0.X(:,:)-Data0.X(:,1))./Data0.X(:,1) *100;
%%

hold on; box on; grid on;
plot(X(11,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(12,1:25), 'marker', 'diamond', 'linewidth',1.5, 'markersize',5);
plot(X(18,1:25), 'marker', '^', 'linewidth',1.5, 'markersize',5);
legend('N-Oil Output', 'Total Output', 'Total Consumption')
xlabel('Time'); ylabel('% of Dev'); title('Sanction')

hold on; box on; grid on;
plot(X0(11,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(12,1:25), 'marker', 'diamond', 'linewidth',1.5, 'markersize',5);
plot(X0(18,1:25), 'marker', '^', 'linewidth',1.5, 'markersize',5);
legend('N-Oil Output', 'Total Output', 'Total Consumption')
xlabel('Time'); ylabel('% of Dev'); title('No Sanction')
%%

hold on; box on; grid on;
plot(X(23,1:25), 'marker', '^', 'linewidth',1.5, 'markersize',5);
plot(X(5,1:25), 'marker', 'diamond', 'linewidth',1.5, 'markersize',5);
plot(X(9,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Seigniorage', 'Inflation', 'Exchange Rate')
xlabel('Time'); ylabel('% of Dev'); title('Sanction')

hold on; box on; grid on;
plot(X0(23,1:25), 'marker', '^', 'linewidth',1.5, 'markersize',5);
plot(X0(5,1:25), 'marker', 'diamond', 'linewidth',1.5, 'markersize',5);
plot(X0(9,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Seigniorage', 'Inflation', 'Exchange Rate')
xlabel('Time'); ylabel('% of Dev'); title('No Sanction')
%%

hold on; box on; grid on;
plot(X(9,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(24,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(25,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Exchange Rate', 'Import', 'Export')
xlabel('Time'); ylabel('% of Dev'); title('Sanction')

hold on; box on; grid on;
plot(X0(9,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(24,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(25,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Exchange Rate', 'Import', 'Export')
xlabel('Time'); ylabel('% of Dev'); title('No Sanction')

%%


hold on; box on; grid on;
plot(X(4,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(16,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(2,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Final Investment', 'Foreign Investment', 'Capital Stock')
xlabel('Time'); ylabel('% of Dev'); title('Sanction')

hold on; box on; grid on;
plot(X0(4,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(16,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(2,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Final Investment', 'Foreign Investment', 'Capital Stock')
xlabel('Time'); ylabel('% of Dev'); title('No Sanction')

%%

hold on; box on; grid on;
plot(X(1,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(10,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Employment', 'Wage')
xlabel('Time'); ylabel('% of Dev'); title('Sanction')

hold on; box on; grid on;
plot(X0(1,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(10,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Employment', 'Wage')
xlabel('Time'); ylabel('% of Dev'); title('No Sanction')

%%

hold on; box on; grid on;
plot(X(26,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X(27,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Gov. Exp.', 'Tax')
xlabel('Time'); ylabel('% of Dev'); title('Sanction')

hold on; box on; grid on;
plot(X0(26,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
plot(X0(27,1:25), 'marker', 'o', 'linewidth',1.5, 'markersize',5);
legend('Gov. Exp.', 'Tax')
xlabel('Time'); ylabel('% of Dev'); title('No Sanction')




