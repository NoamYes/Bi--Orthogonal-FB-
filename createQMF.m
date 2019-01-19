function [h1,f0,f1] = createQMF(h0)

N= length(h0);
h1 = h0.*(-ones(1,N)).^(1:N);
[f0 , f1] = createSynthNoAlias(h0, h1);

end