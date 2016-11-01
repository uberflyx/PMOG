function [ ] = autoGain( src, vid, maximumValue, exposureRange, gainRange )
%AUTOGAIN Automatically set the gain to not saturate
%   Assumes a suitable image is already present on the camera
%   Example:
%   autoGain(src,vid,255,[0 5], [-11000 23990]); %Chameleon3

lastExposure = 0;
lastGain = 0;

gainSkip = (gainRange(1,2) - gainRange(1,1)) / 20;

n = 0;

for e = exposureRange(1,2):-1:exposureRange(1,1)
    if lastGain ~= 0
        continue
    end
    
    %try see if we can find a gain value that doesnt saturate
    %early out if minimum gain saturates
    src.Exposure = e;
    src.Gain = 1;
    pause(0.1);
    img = double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img + double(getsnapshot(vid));
    img = img ./ 8;
    
    maxi = max(max(img)) + 5;
    if maxi < maximumValue
        lastExposure = e;
    else
        continue
    end
    
    for g = gainRange(1,1):gainSkip:gainRange(1,2)
        src.Gain = g;
        pause(0.1);
        img = double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img + double(getsnapshot(vid));
        img = img ./ 8;
        
        maxi = max(max(img)) + 5; %rounding / measurement error
        if maxi < maximumValue 
            lastGain = g;
        else
            break
        end
    end
end

src.Exposure = lastExposure;
src.Gain = lastGain;

img = double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img + double(getsnapshot(vid));
img = img ./ 8;

fprintf('Camera settings set. Exposure: %s, Gain: %s, Maximum: %s\n', int2str(lastExposure), int2str(lastGain), int2str(max(max(img))));

end

