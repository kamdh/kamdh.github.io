function dy =  toggle2_odefun_with_constant_input(t,y,p)

    %parameters -- "unpack" the parameter vector p
    a=p(1);
    b=p(2);
    Ibar=p(3);
        
    dy = zeros(2,1);
    
    dy(1) = - y(1) + a./(1+y(2).^b)+Ibar;    
    dy(2) = - y(2) + a./(1+y(1).^b);
 
