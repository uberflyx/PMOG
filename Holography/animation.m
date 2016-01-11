function [] = animation(N, k, theta, w, pvec, lvec, delay, fs)
%%%
% Animate through all the l values in lvec, 
% and also all the p values in pvec,
% displaying each hologram for delay seconds. 
% All parameters are the same as hologram.m
% Examples: 
% animation([1920 1080], 100, 45, 0.2, 0, [1 2 3 4 5], 0.5, 0)
% animation([1920 1080], 100, 45, 0.2, [1 2], [1 2 3 4 5], 0.5, 1)
%%%
for j = 1:size(pvec,2)
    for i=1:size(lvec,2)
        hologram(N, k, theta, pvec(j), lvec(i), w, fs);
        pause(delay);
    end
end

