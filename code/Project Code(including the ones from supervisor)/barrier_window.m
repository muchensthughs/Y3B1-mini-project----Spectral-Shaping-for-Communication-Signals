function [s,sf,sfup,l]= barrier_window(d,rho,indices1,indices2,mu,epsilon0,epsiloni,t)

%BARRIER_WINDOW Eigen-window generation function
%
%  inputs:
%
%  d        input vector (column)
%  rho      sampling factor
%  indices  symbol-spaced notch indices

% Get parameters
N = length(d);
i1 = min(indices1);
i2 = max(indices1);
i3 = min(indices2);
i4 = max(indices2);
% Find upsampled indices
Q1=(i1-1)*rho+1:(i2-1)*rho+1;
Q2=(i3-1)*rho+1:(i4-1)*rho+1;
% Construct matrices WI, D, etc
for a=1:rho*N
    for b=1:N
        W(a,b) = 1/sqrt(N)*exp((-1i)*2*pi*a*b/(rho*N));
    end
end

WI1 = W(Q1,:);
WI2 = W(Q2,:);
D = diag(d);



% Get window vector
p = N + 1;

x = 0.9 * ones([N,1]);
l = 0;
while p/t >= epsilon0
    l = l + 1;
    [xopt] = newton(x,epsiloni,D,WI1,WI2,N,t);
    t = mu * t;
    x = xopt;  % start from new x to search the next x with new t
end


% Apply window
s = D*x;
% Generate spectrum
sf = 1/sqrt(N)*fft(s,N);
sfup = 1/sqrt(N)*fft(s,rho*N);


% Plot the magnitude of DFT(s) (decibels)
figure
plot(1:N,20*log10(abs(sf)),'ko',...
    1:1/rho:(N+1)-1/rho,20*log10(abs(sfup)),'k-')
xlabel('Sample number')
ylabel('DFT(dB)')
title('frequency response after window')  % Title
a = axis;
axis([1 N a(3) a(4)])
grid on  

% Plot real/imag parts of time-domain signal s
figure
plot(real(s),imag(s),'ko')
xlabel('Real part')
ylabel('Imaginary part')
title('Transformed signal constellation')
grid on





end

