function [next_h,next_x_q] = Final_Real_Nominal_Expected_Speculation_Dynamic_Bind( X_0 , ~ , time)

h=X_0(1);
x_q=0;

Func = @(xx) Final_Real_Nominal_Expected_Speculation_Dynamic_Bind_Func(xx,X_0,time);

Options=optimset('Display','off','TolFun',1e-4);
[answ,~,exitflag] = fsolve(Func,[h;x_q],Options);

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

