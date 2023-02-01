function FF = Final_Real_Nominal_Expected_Speculation_Dynamic_Bind_Func( xx , X_0 , time )

global Params Exog


delta=Params(1);
Beta=Params(4);

next_tau=Exog(6,time+1);


c=X_0(11);
p_x=X_0(19);
i_e=X_0(6);
e=X_0(9);
m=X_0(3);
next_k=X_0(4)+(1-delta)*X_0(2);


next_X = Final_Real_Nominal_Expected_Speculation_Static(xx(1),next_k,xx(2),m,time+1);

next_r=next_X(6);
next_i_e=next_X(4);
next_c=next_X(9);
next_p_x=next_X(17);
next_e=next_X(7);
next_pai=next_X(3);

FF(1)=next_c-c*Beta*(1+(1-next_tau)*next_r-delta)*next_p_x/p_x*(1+i_e)/(1+next_i_e);
FF(2)=next_e/e-(1+next_i_e)/(1+next_pai);


end

