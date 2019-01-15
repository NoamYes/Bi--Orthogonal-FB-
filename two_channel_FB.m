function [y, v1, v2] = two_channel_FB(x, h0, h1, f0, f1)

v1 = downsample(filter(h0,1,x),2);
v2 = downsample(filter(h1,1,x),2);

u1 = upsample(v1,2);
u2 = upsample(v2,2);

y1 = filter(f0,1,u1);
y2 = filter(f1,1,u2);

y = y1 + y2;

end

