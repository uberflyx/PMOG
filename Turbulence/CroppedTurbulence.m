function [ turbCropped ] = CroppedTurbulence( turb, outputSize, backgroundColour )

if nargin < 3
    backgroundColour = 0;
end

turb = turb(:, 1:outputSize(1)/2);

s = size(turb);

paddingRight = ones(s(1), outputSize(1) - s(2));
paddingRight = paddingRight .* backgroundColour;

turbCropped = [turb paddingRight];

end

