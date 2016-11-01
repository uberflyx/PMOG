function [ ] = Test(vid)
%take measurements of input with no fanciness on output
%center = [221 253];
%center = AnimateTurbulence( [1920 1080], 350, 90, 1, 1.12, 8, 1, 1, 0.2,'tests/findcenter',vid, 0);
center = [168 140];
%aligmnemt:
%hologramHalfOAMTurbulence([350;0], 0, 0.1, [0 0], [0 0],1, false, false, 0, 1, 1.12, 8)
src = vid.Source;

src.Gain = 1247;
src.Exposure = 0;

for sr = 1.0 : -0.1 : 0.1
    AnimateTurbulence( [1920 1080], 350, 90, sr, 1.12, 8, 1, 100, 0.15,strcat('tests/None-None-SR', num2str(sr,2)),vid, 0, center);
    %AnimateTurbulence( [1920 1080], 350, 90, sr, 1.12, 8, 1, 100, 0.2,strcat('tests/A-B-SR', num2str(sr,2)),vid, pi, center);
end


AnimateTurbulence( [1920 1080], 350, 90, 0.95, 1.12, 8, 1, 100, 0.15,'tests/None-None-SR0.95',vid, 0, center);
%AnimateTurbulence( [1920 1080], 350, 90, 1, 1.12, 8, 1, 1, 0.2,'tests/A-A-SR1',vid, 0, center);
%put other q plate


end