

tic


clc
clear all
close all
global Params Exog

% Save Data Name:
Scenario='Oil_0_Trade_0_i_20';
% Options:
Periods=300;
addpath('required_functions\')
Tol=1e-4;



%%%%%%%%%%%%%%%%%%%%%%% Parameters Setting
Alpha=1/3;
delta=0.0233;
Beta=0.987;
Psi=2.095;
Theta_1=0.5;
Theta_2=0.5;
Theta_3=2.5;
Theta_4=2.5;
a_1=0.9;
a_2=0.888;
a_3=0.957;

% Alpha = 0.33333;
% Delta = 0.023302;
% Beta = 0.98672;
% Psi = 2.0952;
% theta_1 = 0.5;
% theta_2 = 0.5;
% theta_3 = 2.5;
% theta_4 = 2.5;
% a_1 =0.904;
% a_2 =0.936;
% a_3 =0.978;


% Theta_4=0;

Params=[delta;Alpha;Psi;Beta;a_1;a_2;a_3;Theta_1;Theta_2;Theta_3;Theta_4];


%%%%%%%%%%%%%%%%%%%%% Exogenous Variables

%Initial setting
%----
% gov_size=0.187;
% v_ratio=0.182;
% tau=0.076;
% %s=3.55;
% i = .2;
% o=6.336;
% A=1;
% A_p=2.238;

gov_size =0.173;
v_ratio =0.116;
tau =0.056;
% s =2.1125;
i = .2;
o =5.725;
A =1;
A_p =0.97875;

tau_fy=0;
tau_fx=0;
tau_fc=0;
tau_o=0;
tau_x=0;

f=(1-tau_o).*o;

Exog_i=[tau_fy;tau_fx;tau_fc;tau_o;tau_x;tau;A;A_p;gov_size;i;v_ratio;o;f];

% Final Setting
%----
gov_size=0.187;
v_ratio=0.18;
tau=0.076;
%s=1.*3.55;
i=.1;
o=6.336;

A=1;
A_p=2.238;
% 
tau_fy=0.3;
tau_fx=0.3;
tau_fc=0.3;
tau_o=0.6;
tau_x=0.3;

% tau_fy=0;
% tau_fx=0;
% tau_fc=0;
% tau_o=0;
% tau_x=0;

f=(1-tau_o).*o;

Exog_f=[tau_fy;tau_fx;tau_fc;tau_o;tau_x;tau;A;A_p;gov_size;i;v_ratio;o;f];

%%%%%%%%%%%%  Shock expected to happen at time T_0 (for unexpected shock set T_0 = 0)
T_0=1;

%%%%%%%%%%  Shock Persistence
rho=1;


%%%%%%%% assign exogenous variables: 
Exog=[repmat(Exog_i,1,T_0+1),repmat(Exog_i,1,Periods-T_0)+(Exog_f-Exog_i)*rho.^(0:Periods-T_0-1)];
% % % Exog(10,2)=1.955;
% % % Exog(10,3)=1.765;
% % % Exog(10,4)=1.575;
% % % Exog(9,2:3)=1.1*Exog(9,2:3);
% % % Exog=[repmat(Exog_i,1,T_0+1),repmat(Exog_f,1,Periods-T_0)];
% % % Exog(13,2:3)=2*Exog(13,2:3);

%%%%%%%%  IF you have another future Unexpected Shocks happenin at T_unexpc > T_0, uncomment below:
% T_unexpc = 16;
% load(['required_functions\',Scenario,'.mat']);
% Init_X=X_0(:,1:T_unexpc+1);
% X=[Init_X,X(:,2:end)];
% Exog_0 = Exog;
% Exog_unexpc = .....
% Exog=[Exog_0(:,1:T_unexpc+1),Exog_unexpc(:,2:end-1)];



%%%%%%%%  Solving :  

X = Final_Real_Nominal_Expected_Speculation_Solve( Tol , Periods) ;

%%%%%%%%%%%%%%    Extracting Results
h=X(1,:);
k=X(2,:);
m=X(3,:);
x=X(4,:);
pai=X(5,:);
i_e=X(6,:);
p_d=X(7,:);
r=X(8,:);
e=X(9,:);
w=X(10,:);
c=X(11,:);
y=X(12,:);
y_d=X(13,:);
y_f=X(14,:);
c_f=X(15,:);
x_f=X(16,:);
p_s=X(17,:);
y_s=X(18,:);
p_x=X(19,:);
y_d_x=X(20,:);
x_q=X(21,:);
Q=X(22,:);
g=gov_size*y;
imp=y_f+x_f+c_f;
exp=y_d_x.*p_d./e;
Oil_Rev=(1-Exog(4,1:end-1)).*Exog(12,1:end-1);
Tax=tau.*y_s.*p_s;
govIncome=Tax+v_ratio.*g;
Q_n=Q./Oil_Rev;
x_q_n=x_q./Oil_Rev;
s = m-c -gov_size.*y+v_ratio.*gov_size.*y+e.*f+tau.*p_s.*y_s;

save(['simulation_data\',Scenario,'.mat'])


% clear all

toc
