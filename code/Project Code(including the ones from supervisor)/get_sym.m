function [d,const_sym] = get_sym(N,const_str)
%GET_SYM
%
%Usage: [d,const_sym] = get_sym(N,const_str)
%
%Summary: The get_sym function generates a length N
%         row vector of constellation symbols.
%
% inputs:
%   N           Number of constellation symbols
%   const_str	A string indicating the constellation
%
% outputs:
%   d           N-tuple of random constellation symbols
%   const_sym   set of possible constellation symbols
%
% (c) jpc 13.06.14

% Check to see if the requested constellation is QPSK
switch const_str
    case 'qpsk'
        const_sym = [1+1i 1-1i -1+1i -1-1i];
        % QPSK constellation
    case '16qam'
        %16-QAM constellation
        const_sym = [1+1i 1-1i 1+3i 1-3i -1+1i -1-1i -1+3i -1-3i 3+1i 3-1i 3+3i 3-3i -3+1i -3-1i -3+3i -3-3i];
    otherwise
        error('Only qpsk or 16qam is supported.');
end
        
M = length(const_sym);  % Get the number of constellation points
% Randomly assign constellation symbols to vector
sym_indices = randi(M,[1 N]);  % Note the additional argument
d = const_sym(sym_indices);    % Directly construct the N-tuple
d = d.';

end

