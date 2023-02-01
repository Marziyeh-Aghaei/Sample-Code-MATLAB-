

function Output = Final_Real_Nominal_Expected_Speculation_Steady(time)

global Params Exog


%%%------------- Paramseters
delta=Params(1);
Alpha=Params(2);
Psi=Params(3);
Beta=Params(4);
a_1=Params(5);
a_2=Params(6);
a_3=Params(7);
Theta_1=Params(8);
Theta_2=Params(9);
Theta_3=Params(10);
Theta_4=Params(11);


%%% ---------- Exogenous Variables
tau_fy=Exog(1,time);
tau_fx=Exog(2,time);
tau_fc=Exog(3,time);
tau_o=Exog(4,time);
tau_x=Exog(5,time);
tau=Exog(6,time);
A=Exog(7,time);
A_p=Exog(8,time);
gov_size=Exog(9,time);
i=Exog(10,time);
v_ratio=Exog(11,time);
o=Exog(12,time);
% f=Exog(13,time);


%%% ----------- Solving For Steady States

%----- Initial guess
p_d_min(1)=(1/a_3)^(1/(1-Theta_3));
p_d_min(2)=(1/(a_3+(1-a_3)*((1+tau_fc)/(1+tau_fy))^(1-Theta_3)/(1-a_1)^((1-Theta_3)/(1-Theta_1))))^(1/(1-Theta_3));
p_d_min=max(p_d_min);
p_d_max=100;
%-----
maxiterrrr=100;
rsd=1;
iterrrr=1;
sign_error=zeros(1,2);

while abs(rsd)>1e-12 && iterrrr<maxiterrrr
   
    
switch iterrrr
    case 1
        p_d=p_d_max;
    case 2
        p_d=p_d_min;
    case 3
        if sum(sign_error)~=0
            disp('Error: Initial Gusses for p_d are not suitable.')
            break;
        else
%             disp('Initial Gusses for p_d ARE suitable.')            
        end
        p_d=(p_d_min+p_d_max)/2;
end
    
%     p_d=(p_d_min+p_d_max)/2;
%------------------------------------------
r=(1/Beta+delta-1)/(1-tau);
e=((1-a_3*p_d^(1-Theta_3))/(1-a_3))^(1/(1-Theta_3))/(1+tau_fc);
p_s=((p_d^(1-Theta_1)-(1-a_1)*((1+tau_fy)*e)^(1-Theta_1))/a_1)^(1/(1-Theta_1));
p_x=(a_2*p_d^(1-Theta_2)+(1-a_2)*((1+tau_fx)*e)^(1-Theta_2))^(1/(1-Theta_2));
k_over_y_s=1/r/p_x*(1-Alpha)*p_s;
x_over_y_s=delta*k_over_y_s;
y_s_over_h=A^(1/Alpha)*k_over_y_s^((1-Alpha)/Alpha);
w=Alpha*p_s*y_s_over_h;

h = (1-(Psi*(1+i))/((1-tau)*w)*(1-tau_o)*e*o) /(1+(Psi*(1+i))/((1-tau)*w)*(-p_x*(x_over_y_s)+p_s)*(y_s_over_h));
y_s=y_s_over_h*h;
c = (-p_x*(x_over_y_s)+p_s)*y_s + (1-tau_o)*e*o;
m = Beta * (1+i) * c;
y = p_s * y_s + (1-tau_o)*e*o;
s = m-c-gov_size*(1-v_ratio)*y-(1-tau_o)*e*o-tau* p_s*y_s;

%--------
%h=(Beta*(1-tau)*w/Psi-s-gov_size*(1-v_ratio)*e*o*(1-tau_o))/(Beta*(1-tau)*w/Psi+(1-tau)*p_s*y_s_over_h-p_x*x_over_y_s*y_s_over_h+gov_size*p_s*y_s_over_h*(1-v_ratio));
%c=(1-tau_o)*e*o+h*(p_s*y_s_over_h-p_x*x_over_y_s*y_s_over_h);
%--------


x=x_over_y_s*y_s;
y_d=1/a_1*(p_s/p_d)^(Theta_1)*y_s;
y_f=y_d*(1-a_1)*(e*(1+tau_fy)/p_d)^(-Theta_1);
x_f=x*(1-a_2)*(e*(1+tau_fx)/p_x)^(-Theta_2);
c_f=c*(1-a_3)*(e*(1+tau_fc))^(-Theta_3);
y_d_x=A_p*(p_d/e*(1+tau_x))^(-Theta_4);
x_q=0;

%------------------------------------------

rsd=((1-tau_o)*o+p_d/e*y_d_x-x_q-(1+tau_fc)*c_f-(1+tau_fy)*y_f-(1+tau_fx)*x_f)/((1-tau_o)*o+p_d/e*y_d_x);


if iterrrr==1 || iterrrr==2
  sign_error(iterrrr)=sign(rsd);
else        
    if rsd*sign_error(1)>0
    p_d_max=p_d;
    else
    p_d_min=p_d;
    end
    p_d=(p_d_min+p_d_max)/2;
end

%   if rsd>0
%       p_d_min=p_d;
%   else
%       p_d_max=p_d;
%   end
  
      iterrrr=iterrrr+1;
    
end

if iterrrr<maxiterrrr
%     'Solved for Real Vaiables'
else
    disp('Can not Find The Steady Values, Please Change Initial Gusses of P_d')
end

%-----------------------------------------------    
y=p_x*x+c;
k=k_over_y_s*y_s;
pai=(gov_size*y+s-v_ratio*gov_size*y-e*(1-tau_o)*o-tau*p_s*y_s)/c;
m=c*(1+pai);
i_e=(1+(1-tau)*r-delta)*(1+pai)-1;
Q=0;


Output=[h;k;m;x;pai;i_e;p_d;r;e;w;c;y;y_d;y_f;c_f;x_f;p_s;y_s;p_x;y_d_x;x_q;Q];



