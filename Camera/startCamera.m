function [vid,src] = startCamera( vidID, format, showPreview, regionOfInterest )
%CAMERACAPTURE Summary of this function goes here
%   output :    [vid, src] Use src.? to set camera
%               properties. Hint: Hit src.TAB TAB to see what's what.
%   vidID :     1 (or the id of the camera you want)
%
%   format :    Depends a lot on the camera. A list of working formats is
%               below:
%               PointGrey Firefly: 'RGB32_1280x960'
%
%   regionOfInterest :  (Optional) A vector with the coordinates of the top-left and
%                       bottom-right pixes of a ROI

vid = videoinput('winvideo', vidID, format);
src = getselectedsource(vid);

if nargin >= 4 
   vid.ROIPosition = regionOfInterest;
end

if showPreview == true
    preview(vid);
end

%img = getsnapshot(vid);
%imshow(img)

end

