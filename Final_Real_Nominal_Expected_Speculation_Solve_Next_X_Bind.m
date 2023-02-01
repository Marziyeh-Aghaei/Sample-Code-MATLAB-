function next_X = Final_Real_Nominal_Expected_Speculation_Solve_Next_X_Bind( h , c , next_k , m , i_e , p_x , Bind , time )


global Params Exog


delta=Params(1);

f=Exog(13,time+1);
% tau_o=Exog(2,time+1);
% o=Exog(7,time+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,max_time_prime]=min(Bind(time+1:end));
next_X=zeros(22,max_time_prime);

upper_x_q=0.5*f;
lower_x_q=-0.01*f;

req_error=1e-3;
error=1;
count=1;
sign_error=zeros(1,2);
while error>req_error || abs(next_X(21,end)+next_X(22,end))>req_error

    
    switch count
    case 1
        init_x_q=upper_x_q;
    case 2
        init_x_q=lower_x_q;
    case 3
        if sum(sign_error)~=0
            disp('Error in Finding Initial x_q: Initial Gusses are NOT Suitable.')
            upper_x_q=1.2*upper_x_q;
            count=1;
            continue;
        else
            disp('Initial Gusses for Initial x_q ARE suitable.')
        end
       init_x_q=(upper_x_q+lower_x_q)/2;
    end    
    
            next_X(1,1)=Final_Real_Nominal_Expected_Speculation_Dynamic(h , c , next_k , m , i_e , p_x ,init_x_q,time);
            next_X(2,1)=next_k;
            next_X(21,1)=init_x_q;
            next_X(22,1)=0;
            prev_m=m;
  
    for time_prime=1:max_time_prime-1
        
             next_X(3:20,time_prime) = Final_Real_Nominal_Expected_Speculation_Static(next_X(1,time_prime),next_X(2,time_prime),next_X(21,time_prime),prev_m,time+time_prime);
             
             next_X(2,time_prime+1)=next_X(2,time_prime)*(1-delta)+next_X(4,time_prime);
             next_X(22,time_prime+1)=next_X(21,time_prime)+next_X(22,time_prime);
             
             [next_X(1,time_prime+1),next_X(21,time_prime+1)]=Final_Real_Nominal_Expected_Speculation_Dynamic_Bind(next_X(:,time_prime),next_X(22,time_prime+1),time+time_prime);    
    
        prev_m=next_X(3,time_prime);
        
    end
           
 
    
if count==1 || count==2
  sign_error(count)=sign(next_X(21,end)+next_X(22,end));
%   next_X(20,end)+next_X(21,end)
  if isreal(next_X(21,end)+next_X(22,end))==0
      disp('Error in Finding Initial X_q')
  end
  next_X=zeros(22,max_time_prime);
else        
    if (next_X(21,end)+next_X(22,end))*sign_error(1)>0
    upper_x_q=init_x_q;
    else
    lower_x_q=init_x_q;
    end
    init_x_q=(upper_x_q+lower_x_q)/2;
    error=(upper_x_q-lower_x_q)/init_x_q;
end
                     
            count=count+1;
                    
end







end

