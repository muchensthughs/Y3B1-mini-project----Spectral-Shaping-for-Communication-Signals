function [ sf,sfup,const_sym ] = upsample( N,const_str,rho,indices )

%run naive notching function
[s,sf,const_sym] = notch_data_v1(N,const_str,indices);
%upsampled DFT, prefactor is still 1/sqrt(N)
sfup = 1/sqrt(N)*fft(s,rho*N);

%transform back into time domain
%sup = sqrt(r*N)*ifft(sfup,r*N);
%plot the magnitude of DFT (dB)
figure

plot(1:N,20*log10(abs(sf)),'ko',...
1:1/rho:(N+1)-1/rho,20*log10(abs(sfup)),'k-')
xlabel('Sample number')
ylabel('Power of DFT(s)(dB)')
title('DFT of notched signal (dB)')  % Title
a = axis;
axis([1 N -20 20])
grid on

%figure
%plot(real(sup),imag(sup),'ko')                  % Plot
%xlabel('Real part')                         % x-axis label
%ylabel('Imaginary part')                    % y-axis label
%title('Transformed upsampled signal constellation')   % Title
%grid on 


end

