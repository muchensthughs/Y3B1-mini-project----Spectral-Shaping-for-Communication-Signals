%plot the time and number of iterations with respect to
%mu,epsilon0,epsiloni,t

 m = 2;
for mu = 2:50
    epsilon0 = 0.1;
    epsiloni = 0.1;
    t = 1;
    c = cputime; 
    [d,const_sym] = get_sym(16,'qpsk');
    [s,sf,sfup,i(1,m)]= barrier_window(d,8,[9:12],mu,epsilon0,epsiloni,t);
    e(1,m) = cputime-c;
    m = m + 1;
end

x = 2:50;
figure
[hAx,hLine1 hLine2] = plotyy(x,e,x,i);
title('Change in time and number of iterations with respect to mu')
xlabel('mu')
ylabel(hAx(1),'time') % left y-axis
ylabel(hAx(2),'number of iterations') % right y-axis
grid on

