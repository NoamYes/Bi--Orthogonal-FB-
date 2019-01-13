function x_hat = idsftf(X, win_len, noverlap, nfft)


X_inv = real(ifft(X)); % contains each window(column) idft
M = size(X,2); % number of windows
% ndft = size(X,1); %order of dft
ndft = nfft;
x_hat_len = M*ndft-(M-1)*noverlap+ndft; %total len subtracting overlaps
x_hat = zeros(x_hat_len, 1);

idx = (1:ndft).';
    for l = 1:M


    x_hat((l-1)*(win_len-noverlap)+idx) = x_hat((l-...
    1)*(win_len-noverlap)+idx) + X_inv(:,l);

    end
x_hat = 2*(1-noverlap/window_length)*x_hat;


end

