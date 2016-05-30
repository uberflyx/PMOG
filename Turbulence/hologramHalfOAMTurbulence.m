function [] = hologramHalfOAMTurbulence(gratingNumber, gratingAngle, beamWidth, pMatrix, lMatrix, screen, useAmplitude, saveImages, phaseShift, SR, beamWidthmm, pixelSizeMicron )
%HOLOGRAMHALFOAM Generates an OAM hologram.
%   Calls hologramOAM with the specified parameters except that the
%   resolution is split down the middle so that two holograms can be placed
%   next to eachother. The l and pMatrix variables should have 2 columns
%   otherwise the same hologram will be shown on both sides. Turbulence is
%   generated using GenerateTurbulence function and added to the left
%   hologram.
%
%   Parameters: (see hologram or hologramOAM for those not mentioned)
%   hologramOffset: (optional) A matrix specifying the offsets for the left and right
%                   holograms according the calibration data. 
%                   [leftXOffset rightXOffset; leftYOffset rightYOffset]
%   phaseShift:     Adds pi (or pi/2 or whatever) to the generated
%                   holograms. For example: [0 pi] would shift the second hologram by pi.
%
%   Example: hologramHalfOAMTurbulence([350;0], 0, 0.1, [0 0], [0 1],1, false, false, 0, 0.5, 1.12, 8)

   HalfResolution = [960 1080];
   
   [turb, noGrating] = GenerateTurbulence(HalfResolution(2), 0, gratingAngle + 90, SR, beamWidthmm, pixelSizeMicron);
   
   [A1,E1] = hologramOAM(gratingNumber(1), gratingAngle,beamWidth, pMatrix(:,1), lMatrix(:,1), -1, useAmplitude, saveImages, HalfResolution);
   [A2,E2] = hologramOAM(gratingNumber(2), gratingAngle,beamWidth, pMatrix(:,2), lMatrix(:,2), -1, useAmplitude, saveImages, HalfResolution);

    %Apply a phase shift 
    phaseShift = (255/(2*pi)) .* phaseShift;
    A1 = mod(A1 + phaseShift, 255);
    A2 = mod(A2 + phaseShift, 255);
    
    oam = angle(E1);
    
    A1 = double(noGrating(:,1:960)) + oam;
    
    a=min(A1(:)); 
    b=max(A1(:));
    
    %%Put a grating:
    x=linspace(-1, 1, 1080);
    y=linspace(-1, 1, 960);
    [yy,xx]=meshgrid(y,x);


    gratingAngle = pi/180 * (gratingAngle + 90);
    plane = sin(gratingAngle)*yy + cos(gratingAngle)*xx;
    A1 = mod(A1 + gratingNumber(1)*plane+pi, 2*pi)-pi;
    
    A1=uint8(255*(A1-a)/(b-a));
    
    A = [A1 A2];
    
    if screen == 0
        map=gray(256);
        figure(1); imshow(A,'Border','tight','InitialMagnification','fit'); truesize(1);
        colormap(map);
    elseif screen > 0
        fullscreen(A, screen);
    end
end

