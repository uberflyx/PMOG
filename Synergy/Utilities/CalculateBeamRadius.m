function [ beamRadiusPercent ] = CalculateBeamRadius( dimensionPixels, pixelSize_um, beamRadius_mm )
%CALCULATEBEAMRADIUS Converts beamRadius in mm to a percentage of the
%specified dimensionPixels and the pixel size

beamRadiusPercent = 1/((dimensionPixels * pixelSize_um * 1e-6)/(beamRadius_mm*1e-3));

end

