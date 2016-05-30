function [ ] = TestScalar(vid)
%take measurements of input with no fanciness on output
%center = [221 253];
%center = AnimateTurbulence( [1920 1080], 350, 90, 1, 1.12, 8, 1, 1, 0.2,'tests/findcenter',vid, 0);

%Calibrate:
%hologramHalfOAMTurbulence([350;200], 0, 0.1, [0 0], [1 -1],1, false, false, 0, 1, 1.12, 8)

src = vid.Source;

src.Gain = 2996;
src.Exposure = 5;

for sr = [1.0 0.95 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1]
    %AnimateTurbulence( [1920 1080], 350, 90, sr, 1.12, 8, 1, 100, 0.15,strcat('tests/B-A-SR', num2str(sr,2)),vid, 0, center);
    %AnimateTurbulence( [1920 1080], 350, 90, sr, 1.12, 8, 1, 100, 0.2,strcat('tests/A-B-SR', num2str(sr,2)),vid, pi, center);
    for i = 1:1:100
        %odd number of mirrors so L is inverted
        hologramHalfOAMTurbulence([350;200], 0, 0.1, [0 0], [1 -1],1, false, false, 0, sr, 1.12, 8)
    
        pause(0.3);
        
        img = getsnapshot(vid);
        imwrite(img, strcat('tests\B-A-SR-', num2str(sr,2), '-capture-', int2str(i), '.png'));    
            
        pause(0.1);
        
        hologramHalfOAMTurbulence([350;200], 0, 0.1, [0 0], [1 1],1, false, false, 0, sr, 1.12, 8)
    
        pause(0.3);
        
        img = getsnapshot(vid);
        imwrite(img, strcat('tests\B-C-SR-', num2str(sr,2), '-capture-', int2str(i), '.png'));    
            
        pause(0.1);
    
        
        
         hologramHalfOAMTurbulence([350;200], 0, 0.1, [0 0], [-1 -1],1, false, false, 0, sr, 1.12, 8)
    
        pause(0.3);
        
        img = getsnapshot(vid);
        imwrite(img, strcat('tests\D-A-SR-', num2str(sr,2), '-capture-', int2str(i), '.png'));    
            
        pause(0.1);
        
        hologramHalfOAMTurbulence([350;200], 0, 0.1, [0 0], [-1 1],1, false, false, 0, sr, 1.12, 8)
    
        pause(0.3);
        
        img = getsnapshot(vid);
        imwrite(img, strcat('tests\D-C-SR-', num2str(sr,2), '-capture-', int2str(i), '.png'));    
            
        pause(0.1);
        
    end
end



%AnimateTurbulence( [1920 1080], 350, 90, 0.95, 1.12, 8, 1, 100, 0.15,'tests/B-A-SR0.95',vid, 0, center);
%AnimateTurbulence( [1920 1080], 350, 90, 1, 1.12, 8, 1, 1, 0.2,'tests/A-A-SR1',vid, 0, center);
%put other q plate


end