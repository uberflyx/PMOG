function [] = animation(gratingNumber, gratingAngle, beamWidth, pvec, lvec, delay, screen)
%%%
% Animate through all the l values in lvec, 
% and also all the p values in pvec,
% displaying each hologram for delay seconds. 
% All parameters are the same as hologram.m
% Examples: 
% animation([1920 1080], 100, 45, 0.2, 0, [1 2 3 4 5], 0.5, 0)
% animation([1920 1080], 100, 45, 0.2, [1 2], [1 2 3 4 5], 0.5, 1)
%%%
n = 1;
map=gray(256);
for p = 1:size(pvec,2)
    for l=1:size(lvec,2)
        [s, se] = hologramOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) pvec(p)], [lvec(l) -lvec(l)], screen, false, false, [600 300]);
        
        
        %if n == 1;
        %    imwrite(s,map,'lol.gif', 'Loopcount',inf','DelayTime',0.1);
        %else
        %    imwrite(s,map,'lol.gif','WriteMode','append');
        %end
        n = n + 1;
        
        pause(delay);
    end
end

