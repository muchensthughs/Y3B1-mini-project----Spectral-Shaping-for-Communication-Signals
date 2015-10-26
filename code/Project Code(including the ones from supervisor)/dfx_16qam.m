function [y1,y2] = dfx_16qam( x,D,WI1,WI2,N,t,delta,gama)
%y1 : first derivative
%y2 : second derivative (hessian)

% compute derivatives

e = eye(N);
y1 = 2 * real(D' * WI1' * WI1 * D) * x + (1/t) * (2/(N-x.'*x)) * x + 2 * real(D' * WI2' * WI2 * D) * x ;

y2 = 2 * real(D' * WI1' * WI1 * D) + 2/t *  (2*x*x.' + (N - x.'*x)*e)/(N - x.'*x)^2 + 2 * real(D' * WI2' * WI2 * D) ;

sum_y1 = zeros(N,1);
sum_y2 = 0;
for i = 1:N
    sum_y1 = sum_y1 + (1/(e(:,i).'*x-delta))*e(:,i) + (1/(e(:,i).'*x-gama))*e(:,i);
    sum_y2 = sum_y2 + e(:,i)* e(:,i).'/(e(:,i).'*x-delta)^2 + e(:,i)* e(:,i).'/(e(:,i).'*x-gama)^2;
end
y1 = y1 - 1/t * sum_y1;
y2 = y2 + 1/t * sum_y2;

end

