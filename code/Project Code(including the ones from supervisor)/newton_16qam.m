function [xopt] = newton_16qam( x,epsiloni,D,WI1,WI2,N,t )

%define parameters
theta = 1;
alpha = 0.1748;
beta = 0.98;
delta = 0.6;
gama = 1.7;

%initial values of gradient and hessian at x
[y1,y2] = dfx_16qam( x,D,WI1,WI2,N,t,delta,gama );
deltx = -inv(y2) * y1;

omegasq = -y1.' * deltx;
    
% newton's method to find optimal x with specific t
while omegasq/2 >= epsiloni
    [y1,y2] = dfx_16qam( x,D,WI1,WI2,N,t,delta,gama );
    deltx = -inv(y2)*y1;
    omegasq = -y1.' * deltx;
    
    %line search to determine step size (secure convergence)
    [y_new] = fx_16qam(x+theta*deltx,D,WI1,WI2,N,t,delta,gama);
    [y_old] = fx_16qam(x,D,WI1,WI2,N,t,delta,gama);
    
    while y_new > y_old + alpha*theta*y1.'*deltx
        theta = beta*theta;
        [y_new] = fx_16qam(x+theta*deltx,D,WI1,WI2,N,t,delta,gama);
        [y_old] = fx_16qam(x,D,WI1,WI2,N,t,delta,gama);
    end
    
    %compute new x
    x = x + theta * deltx;
end

xopt = x;

end

