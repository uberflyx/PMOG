function [] = hologramOAM(gratingNumber, gratingAngle, beamWidth, pMatrix, lMatrix, screen, saveImages)
%HOLOGRAMOAM Generates an OAM hologram.
%   Calls the hologram function with some sane defaults.
%   By default, phase only holograms are generated, however, if pMatrix is
%   not 0 then phase-amplitude holograms are used.
%
%   If you would like to get the raw matrix data out then you need to call
%   the hologram function directly.
%
%   Superposition of OAM Modes:
%   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   You can place multiple holograms in a row. Each row of the p or l
%   matrices is superimposed on each other. If you would like multiple rows
%   of holograms, use the hologram function directly. When you are doing
%   this, multiple rows of the gratingNumber and gratingAngle are also
%   used so that you can separate the holograms... nice.
%
%   Example: hologramOAM(300, [0; 45], 10, 0, [5;10], 0, false)

    SLMResolution = [1920 1080];
    
    if (length(lMatrix) == 1) % single hologram
        hologram(SLMResolution, gratingNumber, gratingAngle, pMatrix, lMatrix, beamWidth, screen, 0, saveImages);
    else % superimposed holograms, by row
        % make the pMatrix and others into a matrix the same size as the lMatrix
        grid=size(lMatrix);
        pMatrix(1:grid(1), 1:grid(2))=pMatrix; 
        gratingNumber(1:grid(1), 1:grid(2))=gratingNumber; 
        gratingAngle(1:grid(1), 1:grid(2))=gratingAngle; 
        
        superp = zeros(fliplr(SLMResolution));
        
        for row = 1:length(lMatrix)
            [temp] = hologram(SLMResolution, gratingNumber(row,:), gratingAngle(row,:), pMatrix(row,:), lMatrix(row,:), beamWidth, -1, 0, false);
            superp = superp + double(temp);
            %figure(2); imagesc(temp);
        end
        
        superp = uint8(mod(superp, 255)); % rescale hologram back to 0 - 2pi (0 - 255)
        
        % display, save, etc. since it is not done by hologram
        map=gray(256);
        if saveImages == true || saveImages == 1
            params = strcat('-l',mat2str(lMatrix),'p',mat2str(pMatrix(1,1)),'w',mat2str(beamWidth(1,1)),'k',mat2str(gratingNumber),'theta',mat2str(gratingAngle));
            params = strrep(params, '[', '');
            params = strrep(params, ']', '');
            params = strrep(params, ';', 'x');
            params = strrep(params, '[', '');
            params = strrep(params, ' ', '_');
            imwrite(superp, map, strcat('holograms\superhologram', params, '.png'));
            %imwrite(abs(E), strcat('holograms\mag', params, '.png'));
            %figure(2); imagesc(abs(E));
            %imwrite(phase(E), map, strcat('holograms\phase', params, '.png'));
        end
        
        if screen == 0
            figure(1); imshow(superp,'Border','tight','InitialMagnification','fit'); truesize(1);
            colormap(map);
        elseif screen > 0
            fullscreen(superp,screen);
        end
    end
end

