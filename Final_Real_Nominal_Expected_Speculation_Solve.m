function X = Final_Real_Nominal_Expected_Speculation_Solve(Tol , Periods)



%%%%%%%%%%%%%%%%%%  Setting Initial Values
X_i=Final_Real_Nominal_Expected_Speculation_Steady(1);

%%%%%%%%%%% For Future Unexpected Shocks
% load('Initial_Data.mat');
% X_i=X_0(:,18);
% clear X_0 Exog_0



X_f=Final_Real_Nominal_Expected_Speculation_Steady(Periods+1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Bind=zeros(1,Periods+1);
% Bind(2:4)=1;
% Bind(1:10)=ones(1,10);

prev_Bind=ones(1,Periods+1);
Run_Number=1;
guess_h=X_i(1);
% guess_h=0.141;
while any(Bind~=prev_Bind)
    
    disp('Run Number =')
    disp(Run_Number)

    prev_Bind=Bind;
    
    
X=Final_Real_Nominal_Expected_Speculation_Solve_init_h( X_i , X_f , guess_h , Bind , Tol , Periods);


e=X(9,:);
i_e=X(6,:);
pai=X(5,:);

% spec=e(3:end)./e(2:end-1)>=(1+i_e(3:end))./(1+pai(3:end))-2e-4;
spec=e(3:100)./e(2:99)>=(1+i_e(3:100))./(1+pai(3:100))-2e-4;


Bind=[0,spec,zeros(1,length(Bind)-length(spec)-1)];

Run_Number=Run_Number+1;

disp('Speculation in Periods :')
disp(Bind(1:15))
% disp(nonzeros(Bind))

guess_h=X(1,2);

end

% error=X(:,end)-X_f;


end

