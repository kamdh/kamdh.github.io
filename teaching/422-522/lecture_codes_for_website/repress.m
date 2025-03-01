function dy = repress(t,y,p)
    % repressilator model right hand side
    % parameters: p = [alpha,alpha0,beta,n]
    dy = zeros(6,1);
    dy(1) = -y(1) + p(1)/(1.+y(6)^p(4))+ p(2);
    dy(2) = -y(2) + p(1)/(1.+y(4)^p(4))+ p(2);
    dy(3) = -y(3) + p(1)/(1.+y(5)^p(4))+ p(2);
    dy(4) = -p(3)*(y(4)-y(1));
    dy(5) = -p(3)*(y(5)-y(2));
    dy(6) = -p(3)*(y(6)-y(3));



