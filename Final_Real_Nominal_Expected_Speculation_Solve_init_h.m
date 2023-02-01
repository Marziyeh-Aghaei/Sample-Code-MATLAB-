function X = Final_Real_Nominal_Expected_Speculation_Solve_init_h( X_i , X_f , guess_h , Bind , Tol , Periods)


global Params 


delta=Params(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% X=zeros(length(X_i),Periods+1);
X(:,1)=X_i;

upper_h=1.05*guess_h;
lower_h=0.95*guess_h;

req_error(1)=Tol*abs((X_i(1)-X_f(1))/(X_i(1)));
req_error(2)=Tol*0.05*X_i(1);
req_error=max(req_error);
error=1;
count=1;
prev_time=0;
sign_error=zeros(1,2);
while error>req_error
    
    
switch count
    case 1
        init_h=upper_h;
    case 2
        init_h=lower_h;
    case 3
        if sum(sign_error)~=0
            disp('Error: Initial Gusses for h are not suitable.')
            count=1;
            upper_h=1.05*upper_h;
            lower_h=0.95*lower_h;
            continue;
        else
            disp('Initial Gusses for Initial "h" ARE suitable.')            
        end
       init_h=(upper_h+lower_h)/2;
end

    
X(1,2)=init_h;
X(2,2)=X(2,1);
X(22,2)=X(22,1);

for time=2:Periods

%     disp(time)
    if Bind(time)==0
        
        X(21,time)=-X(22,time);      

        X(3:20,time) = Final_Real_Nominal_Expected_Speculation_Static(X(1,time),X(2,time),X(21,time),X(3,time-1),time);
        
        X(2,time+1)=X(4,time)+(1-delta)*X(2,time);
        X(22,time+1)=0;    
        
        if Bind(time+1)==0
            next_x_q=0;
        else
            next_X=Final_Real_Nominal_Expected_Speculation_Solve_Next_X_Bind(X(1,time),X(11,time),X(2,time+1),X(3,time),X(6,time),X(19,time),Bind,time);
            next_x_q=next_X(21,1);
        end
        
        X(1,time+1)=Final_Real_Nominal_Expected_Speculation_Dynamic(X(1,time),X(11,time),X(2,time+1),X(3,time),X(6,time),X(19,time),next_x_q,time);
        index=1;        
        
    else
        
        if time==2
            next_X=Final_Real_Nominal_Expected_Speculation_Solve_Next_X_Bind_Init(X(1,time),X(2,time),X(22,time),X(3,time-1),Bind,time);
            index=2;
            X(:,time)=next_X(:,index-1);
            X(1,time+1)=next_X(1,index);
            X(22,time+1)=next_X(22,index);
            X(2,time+1)=next_X(2,index);
        else
            X(:,time)=next_X(:,index);
            X(1,time+1)=next_X(1,index+1);
            X(22,time+1)=next_X(22,index+1);
            X(2,time+1)=next_X(2,index+1);
            index=index+1;
        end
        
    end
       
    

if X(1,time+1)<0.07 || X(1,time+1) > 0.23
    break;
end

end


if count==1 || count==2
  sign_error(count)=sign(X(1,end)-X_f(1));
%   X(1,end)-X_f(1)
  clear X
  X(:,1)=X_i;
%   break;
else        
  if(time>=prev_time)
    if (X(1,end)-X_f(1))*sign_error(1)>0
    upper_h=init_h;
    dir=1;
    else
    lower_h=init_h;
    dir=-1;
    end
    init_h=(upper_h+lower_h)/2;
    prev_time=time;
%     disp(prev_time)
    error=(upper_h-lower_h)/init_h;
    progress_percent=(log2((req_error/error))+24)*4;
    disp('Progress Percent in this Run = ')
    disp(progress_percent)
  else
    disp('Failed to Adjust')
    if dir>0
    init_h=(init_h+upper_h)/2;
    else
    init_h=(init_h+lower_h)/2;
    end
  end
end


count=count+1;


end



X=X(:,1:end-1);


end

