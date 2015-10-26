function [s,sf,const_sym] = notch_data_v1(N,const_str,indices)
%NOTCH_DATA_V1
%
%Usage: [s,sf,const_sym] = notch_data_v1(N,const_str,indices)
%
%Summary: The notch_data_v1 function generates a length N
%         vector of constellation symbols, then sets the 
%         frequency components with locations defined by
%         the input 'indices' to zero.  The magnitude of
%         the frequency representation of the resulting
%         signal is plotted, and a scatter plot of the
%         resulting time-domain data points is generated.
%
% inputs:
%   N           Number of constellation symbols
%   const_str	A string indicating the constellation
%   indices     A vector of positive integers that defines
%                 the locations of nulls in the frequency
%                 domain
%
% outputs:
%   s           N-tuple of time-domain data points output
%                 from the notching function
%   sf          N-tuple corresponding to the DFT of s
%   const_sym   set of nominal constellation symbols
%
% (c) jpc 17.06.14

% Error checking - make sure indices are within range
if min(indices) < 1 || max(indices) > N
    error('Indices are outside of range.')
end

% Generate test signal
[d,const_sym] = get_sym(N,const_str);

% Take the normalised DFT
df = 1/sqrt(N)*fft(d);

% Apply a notch at the appropriate indices (frequencies)
% Assign to output variable sf
df(indices) = 0;
sf = df;

% Transform back into the time domain
s = sqrt(N)*ifft(sf);

% Plot the magnitude of DFT(s) (linear)
figure                                      % New fig
plot(1:N,abs(sf),'k')                       % Plot
xlabel('Sample number')                     % x-axis label
ylabel('Magnitude of DFT(s)')               % y-axis label
title('Notched signal frequency response')  % Title
a = axis;                                   % Get axis limits
axis([1 N a(3) a(4)])                       % Set axis limits
grid on                                     % Turn grid lines on

% Plot real/imag parts of time-domain signal s
figure                                      % New fig
plot(real(s),imag(s),'ko')                  % Plot
xlabel('Real part')                         % x-axis label
ylabel('Imaginary part')                    % y-axis label
title('Transformed signal constellation')   % Title
grid on                                     % Turn grid lines on

end

