function eigen_window(d,rho,indices)
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
%%% Your code here %%%

% Get window vector and normalise to meet constraints
%%% Your code here %%%

% Apply window
s = D*x;

% Generate spectrum
sf = 1/sqrt(N)*fft(s,N);
sfup = 1/sqrt(N)*fft(s,rho*N);

% Plot the magnitude of DFT(s) (decibels)
%%% Your code here %%%
    
% Plot real/imag parts of time-domain signal s
%%% Your code here %%%

end

