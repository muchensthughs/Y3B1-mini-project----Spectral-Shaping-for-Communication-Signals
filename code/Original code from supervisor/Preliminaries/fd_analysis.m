function [df,const_sym] = fd_analysis(N,const_str)
%FD_ANALYSIS
%
%Usage: [df,const_sym] = fd_analysis(N,const_str)
%
%Summary: The fd_analysis function generates a length N
%         vector of constellation symbols, then computes
%         the normalised DFT of this vector and plots
%         the magnitude.
%
% inputs:
%   N           Number of constellation symbols
%   const_str	A string indicating the constellation
%
% outputs:
%   df          N-tuple corresponding to the DFT of a
%                 sequence of random constellation symbols
%   const_sym   set of possible constellation symbols
%
% (c) jpc 17.06.14

% Generate test signal
[d,const_sym] = get_sym(N,const_str);

% Take the normalised DFT
df = 1/sqrt(N)*fft(d);

% Plot the freuqency-domain envelope (sample-spaced)
figure                            % New fig
plot(1:N,abs(df),'k')             % Plot interpolated points
xlabel('Sample number')           % x-axis label
ylabel('Magnitude of DFT(d)')     % y-axis label
title('Magnitude of DFT(d)')      % Title
a = axis;                         % Get axis limits
axis([1 N a(3) a(4)])             % Set axis limits
grid on                           % Turn grid lines on

end

