function Output = Final_Real_Nominal_Expected_Speculation_Static( h , k , x_q , m_1 , time)

global Params Exog

% disp([h,k,x_d,m_1,time])

% delta=Params(1);
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


tau_fy=Exog(1,time);
tau_fx=Exog(2,time);
tau_fc=Exog(3,time);
% tau_o=Exog(4,time);
tau_x=Exog(5,time);
tau=Exog(6,time);
A=Exog(7,time);
A_p=Exog(8,time);
gov_size=Exog(9,time);
i=Exog(10,time);
v_ratio=Exog(11,time);
% o=Exog(12,time);
f=Exog(13,time);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




p_d_min(1)=(1/a_3)^(1/(1-Theta_3));
p_d_min(2)=(1/(a_3+(1-a_3)/(1-a_1)^((1-Theta_3)/(1-Theta_1))))^(1/(1-Theta_3));
p_d_min=max(p_d_min);
p_d_max=100;

% x_d./((1-tau_o)*o)
%-----
maxiterrrr=100;
rsd=1;
iterrrr=1;
sign_error=zeros(1,2);


while abs(rsd)>1e-10 && iterrrr<maxiterrrr
    
%  p_d=(p_d_min+p_d_max)/2;
    
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
    
%------------------------------------------
e=((1-a_3*p_d^(1-Theta_3))/(1-a_3))^(1/(1-Theta_3))/(1+tau_fc);
p_s=((p_d^(1-Theta_1)-(1-a_1)*((1+tau_fy)*e)^(1-Theta_1))/a_1)^(1/(1-Theta_1));
p_x=(a_2*p_d^(1-Theta_2)+(1-a_2)*((1+tau_fx)*e)^(1-Theta_2))^(1/(1-Theta_2));
y_s=A*k^(1-Alpha)*h^Alpha;
y_d=1/a_1*(p_s/p_d)^(Theta_1)*y_s;
y_f=y_d*(1-a_1)*(e*(1+tau_fy)/p_d)^(-Theta_1);
y=p_s*y_s+e*f;
w=Alpha*p_s*y_s/h;
m=w*(1-tau)*Beta/Psi*(1-h);

% gamma = 2;
% AA = m-gov_size*y-s+v_ratio*gov_size*y+e*f+tau*p_s*y_s + gamma*(1-.2);
% BB = gamma/Psi*(1-tau)*w*(1-h);
% c = 1/2*(AA+sqrt(AA^2-4*BB));
c = m/(Beta*(1+i));
s = m-c -gov_size*y+v_ratio*gov_size*y+e*f+tau*p_s*y_s;
%c=m-gov_size*y-s+v_ratio*gov_size*y+e*f+tau*p_s*y_s;

x=(y-c)/p_x;
x_f=x*(1-a_2)*(e*(1+tau_fx)/p_x)^(-Theta_2);
c_f=c*(1-a_3)*(e*(1+tau_fc))^(-Theta_3);
y_d_x=A_p*(p_d/e*(1+tau_x))^(-Theta_4);

rsd=(f+p_d*y_d_x/e-x_q-(1+tau_fc)*c_f-(1+tau_fy)*y_f-(1+tau_fx)*x_f)/(f+p_d/e*y_d_x);

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
    disp('Error: Static Computation Failed, Increase Maximum Iteration in the Static Code')
end

i_e=m/c/Beta-1;
pai=m_1/c-1;
r=(1-Alpha)*p_s*y_s/k/p_x;


Output=[m;x;pai;i_e;p_d;r;e;w;c;y;y_d;y_f;c_f;x_f;p_s;y_s;p_x;y_d_x];



end
