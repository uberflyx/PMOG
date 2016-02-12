function [] = ModalDecomposition(gratingNumber, gratingAngle, beamWidth, pvec, lvec, delay, screen, vid, filePrefix)
%MODALDECOMPOSITION Perform modal decomposition with two halves of an SLM
%   Saves hologram images in the holograms folder
%   Script initially sets LG l=1 and -2 for finding the center. 
%   Displays a find center dialog for user selection.
%   Script then runs the measurements and asks whether they should be run
%   again, in case multiple turbulence areas are used.

go = true;

measurementN = 1;
n = 1;

%Set up
hologramOAM(gratingNumber, gratingAngle, beamWidth, 0, [1 -2], screen, false, false, [600 300]);
pause(delay);

%display the selection dialog
[center] = findOAMCenter(vid, 1);
fprintf('Center selected at: %s\n', mat2str(center));

fprintf('Running modal decomposition %s...\nMode: LG [l, p]\n', int2str(measurementN));

while (go)
for p = 1:size(pvec,2)
    for l=1:size(lvec,2)
        [s, se] = hologramOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) pvec(p)], [lvec(l) -lvec(l)], screen, false, true, [600 300]);
       
        fprintf('[%s, %s] ',int2str(lvec(l)), int2str(pvec(p)));
        
        %Print details nicely (10 per line)
        if mod(n,10) == 0
            n = 0;
            fprintf('\n');
        end
        n = n + 1;
        
        pause(delay); %make sure the SLM has settled
        
        %take the picture
        img = getsnapshot(vid);
        imwrite(img, strcat(filePrefix, '-MD-l=', int2str(lvec(l)), '-p=', int2str(pvec(p)), '-C=', mat2str(center), '.png'));
        
        pause(delay);
    end
end

a = input('\nRepeat measurements (change the turbulence now...) (y/n)? ','s');

if strcmpi(a,'y')
    measurementN = measurementN + 1;
    fprintf('Running measurement %s...\n',int2str(measurementN));
else
    go = false;
end

end

end

