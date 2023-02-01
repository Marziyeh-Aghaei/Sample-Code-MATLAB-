function [next_h,next_x_q] = Final_Real_Nominal_Expected_Speculation_Dynamic_Bind( X_0 , ~ , time)

% % % Secend Input Argument May Be Next D_s

global Params Exog


delta=Params(1);
Beta=Params(4);

next_tau=Exog(6,time+1);

h=X_0(1);
m=X_0(3);
next_k=X_0(4)+(1-delta)*X_0(2);
c=X_0(11);
p_x=X_0(19);
i_e=X_0(6);
e=X_0(9);


next_X = @(xx)(Final_Real_Nominal_Expected_Speculation_Static(xx(1),next_k,xx(2),m,time+1));

next_r=@(xx) [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]*next_X(xx);
next_i_e=@(xx) [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]*next_X(xx);
next_c=@(xx) [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0]*next_X(xx);
next_p_x=@(xx) [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]*next_X(xx);
next_pai=@(xx) [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]*next_X(xx);
next_e=@(xx) [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0]*next_X(xx);


Func = @(xx)([next_c(xx)-c*Beta*(1+(1-next_tau)*next_r(xx)-delta)*next_p_x(xx)/p_x*(1+i_e)/(1+next_i_e(xx));next_e(xx)/e-(1+next_i_e(xx))/(1+next_pai(xx))]);
Options=optimset('Display','off','TolFun',1e-4);
[answ,~,exitflag] = fsolve(Func,[h;0],Options);

if exitflag<=0
    disp('Error: Dynamic Solver in Binding Condition Failed To Converge')
end
% if exitflag ==3
%     disp('Error: Dynamic Solver in Binding Condition Failed To Reach Desirable Accuracy')
%     disp(fval)
% end    
if exitflag ==1
%     disp('Dynamic Solver in Binding Condition Succesfully Converged')
end

% next_c(answ)-c*Beta*(1+(1-tau)*next_r(answ)-delta)*next_p_x(answ)/p_x*(1+i_e)/(1+next_i_e(answ))
% next_e(answ)/e-(1+next_i_e(answ))/(1+next_pai(answ))

next_h=answ(1);
next_x_q=answ(2);
end

