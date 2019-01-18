function [X,X_one_sided] = dstft(x,win_len, noverlap, nfft)

window = hann(win_len);
if (isreal(x))
    X_one_sided = spectrogram(x,window,noverlap,nfft);
    X = [conj(fliplr(X_one_sided));X_one_sided(end-1:-1:2,:)];
else
    X = spectrogram(x,window,noverlap,nfft);
    if(mod(nfft, 2) == 0)
        X_one_sided = X(nfft/2:end);
    else
        X_one_sided = X((nfft+1)/2:end);
    end

end

