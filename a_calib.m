

clc
close all
clear all

%%%%%%%%%%%%%%%%%%%%%%%% Step 1:  Steady State Ratios %%%%%%%%%%%%%%%%%%
%%%%%%%% Step 1.1:  Short Run (status quo)
%%%% Mehran's file values
% S_cf=4/100;
% S_xf=8/100;
% S_yf_ov_psys=0.12/(1-0.12);
% S_x_ov_m=25/100;
% 
% Tax_ov_Outp=7/100;
% G_ov_Inc=20/100;
% V_ov_G=10/100;

 

%%%%%%%% a) End of 1396 (Unofficial exchange Rate) 

S_cf=0.043; %Consumption import to total consumption ratio (3rd row of calibration sheet in  calibration excel file) 
S_cf=0.022;
S_xf=0.112; %Investment goods import to total investment ratio (5th row of calibration sheet in  calibration excel file) 
S_xf=0.064;
S_yf_ov_psys=0.10/(1-0.10); % Intermediate goods import to domestic Intermediate goods ratio (7th row of calibration sheet in  calibration excel file) 
S_yf_ov_psys=0.096/(1-0.096);
S_x_ov_m=0.261; % Non-oil export to total export ratio (9th row of calibration sheet in  calibration excel file) 
S_x_ov_m=0.146;

Tax_ov_Outp=0.076; % Tax income to GDP ratio (11th row of calibration sheet in  calibration excel file)
Tax_ov_Outp=0.056;
G_ov_Inc=0.187; % Governemnt size (including debt payments) (13th row of calibration sheet in  calibration excel file) 
G_ov_Inc=0.173;
V_ov_G=0.18; % Lump sum tax  income to Government expenditure ratio (14th row of calibration sheet in  calibration excel file) 
V_ov_G=0.116;

%%%%%%%% Step 1.2)  Long Run (long run trend of Iran's economy, needed to calibrate deep parameters)
Hours=0.16;
Inflation_q=0.05;
Labor_Share=1/3;
Delta_a=9/100;
%%%   X= w(1-h)/c
x=2.4;
Inv_ov_Outp=1/2.6;
Tax_ov_Outp_Long_Run=7.1/100;

Theta_1=0.5;
Theta_2=0.5;
Theta_3=2.5;
Theta_4=2.5;

% V_ov_Gov_Long_Run=10/100;
% G_ov_Inc_Long_Run=20/100;


%%%%%%%%% normalization
A=1;  


%%%%%%%%%%%%%%%%%%%%%%   Calibration
%%%%%%%  Long Run Parameters
Alpha=Labor_Share;
disp(['Alpha = ',num2str(Alpha)])
r_a=1/Inv_ov_Outp*Delta_a*(1-Alpha);
Delta=1-(1-Delta_a)^0.25;
disp(['Delta = ',num2str(Delta)])
tau=Tax_ov_Outp_Long_Run;
Beta_a=1/(1+(1-tau)*r_a-Delta_a);
Beta=Beta_a^0.25;
disp(['Beta = ',num2str(Beta)])
r=(1/Beta+Delta-1)/(1-tau);
pai=Inflation_q;
i_e=(1+pai)/Beta-1;
h=Hours;
Psi=(1-tau)/(1+i_e)*x;
disp(['Psi = ',num2str(Psi)])


%%%%%%%  Short Run Parameters and Exogenous Variables

disp(['theta_1 (estimated in 1392) =',num2str(Theta_1)])
disp(['theta_2 (estimated in 1392) =',num2str(Theta_2)])
disp(['theta_3 (estimated in 1392) =',num2str(Theta_3)])
disp(['theta_4 (estimated in 1392) =',num2str(Theta_4)])

o_ov_psys=(1-S_x_ov_m).*(S_yf_ov_psys+S_cf+Delta_a*(1-Alpha)/r_a*(S_xf-S_cf))./(1-S_cf);
% o_ov_psys_data
tau=Tax_ov_Outp;
g_ov_psys=G_ov_Inc*(1+o_ov_psys);
s_ov_psys=pai*(1+o_ov_psys-Delta*(1-Alpha)/r)+o_ov_psys+tau-g_ov_psys*(1-V_ov_G);
y_s=A^(1/Alpha)*((1-Alpha)/r)^((1-Alpha)/Alpha)*h;
s=s_ov_psys*y_s;
o=o_ov_psys*y_s;
a_3=1-S_cf;
a_2=1-S_xf;
a_1=1-S_yf_ov_psys/(1+S_yf_ov_psys);
A_p=S_x_ov_m/(1-S_x_ov_m)*o;

disp(['a_1 =',num2str(a_1)])
disp(['a_2 =',num2str(a_2)])
disp(['a_3 =',num2str(a_3)])

disp(['gov_size =',num2str(G_ov_Inc)])
disp(['v_ratio =',num2str(V_ov_G)])
disp(['tau =',num2str(tau)])
disp(['s =',num2str(s)])
disp(['o =',num2str(o)])

disp(['A =',num2str(A)])
disp(['A_p =',num2str(A_p)])
disp(['Result : Note: Check: Oil over Income should be = ',num2str(o_ov_psys/(1+o_ov_psys))])





