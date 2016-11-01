<<<<<<< HEAD
<<<<<<< HEAD
function [mdNorm] = ModalDecomposition(gratingNumber, gratingAngle, beamWidth, pvec, lvec, prange, lrange, delay, screen, vid, filePrefix,repeat,offset,manualCenter)
=======
function [mdNorm] = ModalDecomposition(gratingNumber, gratingAngle, beamWidth, pvec, lvec, prange, lrange, delay, screen, vid, filePrefix,repeat,offset)
>>>>>>> 8b9fc8a90af0c14d6340e9ecf2ba55e3e5f75177
=======
function [mdNorm] = ModalDecomposition(gratingNumber, gratingAngle, beamWidth, pvec, lvec, prange, lrange, delay, screen, vid, filePrefix,repeat)
>>>>>>> parent of 0d114ae... Dramatic changes and improvements. Turbulence generation, etc.
%MODALDECOMPOSITION Perform modal decomposition with two halves of an SLM
%   Saves hologram images in the holograms folder
%   Script initially sets LG l=1 and -2 for finding the center. 
%   Displays a find center dialog for user selection.
%   Script then runs the measurements and asks whether they should be run
%   again, in case multiple turbulence areas are used.
%   Tests all p and lvecs agains all p and lranges.
%   Example: ModalDecomposition(400, 0, 0.15, [0], [1 2 3 4 5],[0],[-5 -4 -3 -2 -1 0 1 2 3 4 5] ,0.2,1,vid,'decom\test',2)

go = true;

measurementN = 1;
n = 1;
total = 0;

%Set up
<<<<<<< HEAD
<<<<<<< HEAD
hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [0 0], [10 9], screen, false, false, offset);
=======
hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [0 0], [-3 4], screen, true, false, offset);
>>>>>>> 8b9fc8a90af0c14d6340e9ecf2ba55e3e5f75177
pause(delay*4);
autoGain(vid.Source,vid,255,[0 5], [-11000 23990]);
=======
hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [0 0], [-2 1], screen, false, false);
pause(delay*2);
>>>>>>> parent of 0d114ae... Dramatic changes and improvements. Turbulence generation, etc.

%display the selection dialog
[center] = findOAMCenter(vid, 1);
fprintf('Center selected at: %s\n', mat2str(center));

fprintf('Running modal decomposition %s...\nMode: LG [l, p]\n', int2str(measurementN));

md = zeros(size(lvec,2), size(lrange,2));

while (go)
    for p = 1:size(pvec,2)
    for l=1:size(lvec,2)
        %[s, se] = hologramOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) pvec(p)], [lvec(l) -lvec(l)], screen, false, false);
        %we set the desired l and p onto the left SLM, and cycle through a
        %range on the right SLM.
        fprintf('Generated [%s, %s]:\nTesting: ',int2str(lvec(l)), int2str(pvec(p)));
        
<<<<<<< HEAD
<<<<<<< HEAD
        hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) pvec(p)], [lvec(:,l) lvec(:,l)], screen, false, false, offset);
=======
        hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) pvec(p)], [lvec(:,l) -lvec(:,l)], screen, true, false, offset);
>>>>>>> 8b9fc8a90af0c14d6340e9ecf2ba55e3e5f75177
        pause(delay);
        autoGain(vid.Source,vid,255,[0 5], [-11000 23990]);
        
        for ptest = 1:size(prange,2)
            for ltest = 1:size(lrange,2)
<<<<<<< HEAD
                
                hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) pvec(p)], [lvec(:,l) lrange(:,ltest)], screen, false, false, offset);
=======
                hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) prange(ptest)], [lvec(:,l) lrange(:,ltest)], screen, true, false, offset);
>>>>>>> 8b9fc8a90af0c14d6340e9ecf2ba55e3e5f75177
=======
        for ptest = 1:size(prange,2)
            for ltest = 1:size(lrange,2)
                hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [pvec(p) prange(ptest)], [lvec(:,l) lrange(:,ltest)], screen, false, false);
>>>>>>> parent of 0d114ae... Dramatic changes and improvements. Turbulence generation, etc.
                
                pause(delay); %make sure the SLM has settled
        
                %take the picture
                img = getsnapshot(vid);
                imwrite(img, strcat(filePrefix, '-MD-slp[', int2str(lvec(l)), '_', int2str(pvec(p)), ']-tlp[',int2str(lrange(ltest)), '_', int2str(prange(ptest)),']-C', mat2str(center), '.png'));
                
                %add the center point to the results matrix, for averaging
                %later...
                md(l, ltest) = md(l, ltest) + double(img(center(2), center(1)));
                total = total + 1;
                
                pause(delay);
                
                fprintf('[%s, %s] ',int2str(lrange(ltest)), int2str(prange(ptest)));
            end
        end
        fprintf('\n');
        
        %Print details nicely (10 per line)
        if mod(n,10) == 0
            n = 0;
            fprintf('\n');
        end
        n = n + 1;
        
    end
    end
    
    if mod(measurementN, repeat) == 0
        a = input('\nRepeat measurements (change the turbulence now...) (y/n)? ','s');

        if strcmpi(a,'y')
            measurementN = measurementN + 1;
            fprintf('Running measurement %s...\n',int2str(measurementN));
        else
            go = false;
        end
    else
        measurementN = measurementN + 1;
        fprintf('Running measurement %s...\n',int2str(measurementN));
    end
end

%normalise the results matrix
%we normalise each row (mode) in terms of a PDF
mdNorm = md;
sums = sum(md,2); 
for l = 1:size(md,1)
    mdNorm(l,:) = mdNorm(l,:) / sums(l);
end

fprintf('Total repeats: %s\n', int2str(measurementN));
fprintf('Probability Distribution of the Modal Decomposition: %s\n',mat2str(mdNorm));

%show a graph
figure(1);
imagesc(mdNorm);
colormap(gray);
set(gca,'XTick',1:size(lrange,2),...                         %# Change the axes tick marks
        'XTickLabel',{lrange},...  %#   and tick labels
        'YTick',1:size(lvec,2),...
        'YTickLabel',{lvec},...
        'TickLength',[0 0]);

end



