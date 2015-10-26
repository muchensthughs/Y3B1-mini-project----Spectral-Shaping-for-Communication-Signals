function [y] = fx_16qam(xi,D,WI1,WI2,N,t,delta,gama)

e = eye(N);
%cost function value

if N - xi.'*xi < 0
    y = Inf;
else
    y = xi.'*D'*WI1'*WI1*D*xi - 1/t * log(N - xi.'*xi) + xi.'*D'*WI2'*WI2*D*xi;
    for i=1:N
        if e(:,i).'*xi - delta < 0 || gama - e(:,i).'* xi < 0
           y = Inf;
           break
        else
            y = y - 1/t * log(e(:,i).'*xi - delta) - 1/t * log(gama - e(:,i).'*xi);
        end
    end
end
end