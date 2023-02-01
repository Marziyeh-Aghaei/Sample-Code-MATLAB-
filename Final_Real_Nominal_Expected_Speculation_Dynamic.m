function next_h = Final_Real_Nominal_Expected_Speculation_Dynamic( ~ , c , next_k , m , i_e , p_x , next_x_q , time)

%%% The First Input Argument Is the Hour of Work of Present Period

global Params Exog


delta=Params(1);
Beta=Params(4);

next_tau=Exog(6,time+1);


next_X = @(xx)(Final_Real_Nominal_Expected_Speculation_Static(xx,next_k,next_x_q,m,time+1));


% next_r=@(xx) [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0]*next_X(xx);
% next_i_e=@(xx) [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0]*next_X(xx);
% next_c=@(xx) [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0]*next_X(xx);
% next_p_x=@(xx) [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]*next_X(xx);
% 
% 
% rsd = @(xx)(next_c(xx)-c*Beta*(1+(1-next_tau)*next_r(xx)-delta)*next_p_x(xx)/p_x*(1+i_e)/(1+next_i_e(xx)));


% next_h_min=0.05;
% next_h_max=0.25;
% Bond=[next_h_min,next_h_max];
% 
% [next_h,flag] = Ninth_Model_Binary_Solver(rsd,Bond,1e-5,1e6);
% 
% 
% switch flag
%     case 1
%     disp('Error in Dynamic Solver: Initial Guesses for next_h Are NOT Suitable')
%     case 2
%     disp('Error in Dynamic Solver: The Number of Itterations Reached Maximum Value')
% end
exflag=0;

% next_h_min=0.95*h;
% next_h_max=1.05*h;
next_h_min=0.02;
next_h_max=0.28;

maxit=1e6;
ReqErr=1e-7;

rsd=1;
iterr=1;
sign_error=zeros(1,2);
while abs(rsd)>ReqErr && iterr<maxit
        
switch iterr
    case 1
        next_h=next_h_max;
    case 2
        next_h=next_h_min;
    case 3
        if sum(sign_error)~=0
            exflag=1;
            break;
        else
%             disp('Initial Gusses for next_h ARE suitable.')            
        end
        next_h=(next_h_min+next_h_max)/2;
end

vect=next_X(next_h);
next_r=vect(6);
next_i_e=vect(4);
next_c=vect(9);
next_p_x=vect(17);

rsd = next_c-c*Beta*(1+(1-next_tau)*next_r-delta)*next_p_x/p_x*(1+i_e)/(1+next_i_e);

if iterr==1 || iterr==2
  sign_error(iterr)=sign(rsd);
else        
    if rsd*sign_error(1)>0
    next_h_max=next_h;
    else
    next_h_min=next_h;
    end
    next_h=(next_h_min+next_h_max)/2;
end
    
    iterr=iterr+1;

end




if iterr==maxit
    exflag=2;
end

switch exflag
    case 1
    disp('Error in Dynamic Solver: Initial Gusses for next_h Are NOT Suitable.')
    case 2
    disp('Error in Dynamic Solver: The Number of Itterations Reached Maximum Value')
end




end








