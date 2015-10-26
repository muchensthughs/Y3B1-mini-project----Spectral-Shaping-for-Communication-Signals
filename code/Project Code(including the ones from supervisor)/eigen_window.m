function [s,sf,sfup]= eigen_window(d,rho,indices)
%EIGEN_WINDOW Eigen-window generation function
%
%  inputs:
%
%  d        input vector (column)
%  rho      sampling factor
%  indices  symbol-spaced notch indices

% Get parameters
N = length(d);
i1 = min(indices);
i2 = max(indices);

% Find upsampled indices
Q=(i1-1)*rho+1:(i2-1)*rho+1;

% Construct matrices WI, D, etc
for a=1:rho*N
    for b=1:N
        W(a,b) = 1/sqrt(N)*exp((-1i)*2*pi*a*b/(rho*N));
    end
end
WI = W(Q,:);
D = diag(d);


% Get window vector and normalise to meet constraints
A = inv(D'*D)* real(D'* WI'* WI * D);
[V,~] = eigs(A,N);
x = V(:,N);
r = norm(D*x)/N^(0.5);
x = x/r;

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
ylabel('Power of DFT(s) (dB)')
title('frequency response after window')  % Title
a = axis;
axis([1 N a(3) a(4)])
grid on  

% Plot real/imag parts of time-domain signal s
figure
plot(2*real(s),2*imag(s),'ko')
xlabel('Real part')
ylabel('Imaginary part')
title('Transformed signal constellation')
grid on

end

