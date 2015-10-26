function [y] = fx(xi,D,WI1,WI2,N,t,delta)

e = eye(N);
%cost function value
if N - xi.'*xi < 0
    y = Inf;
else
    y = xi.'*D'*WI1'*WI1*D*xi + xi.'*D'*WI2'*WI2*D*xi - 1/t * log(N - xi.'*xi);
    for i=1:N
        if e(:,i).'*xi - delta < 0
           y = Inf;
           break
        else
            y = y - 1/t * log(e(:,i).'*xi - delta);
        end
    end
end
end