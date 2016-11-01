function varargout = MatrixPlot( mat, xlabels, ylabels, plotTitle, colourmap, normalPrint, rawPrint, colormapScale)
%UNTITLED Plots a greyscale matrix plot of the supplid matrix
%   mat : The matrix
%   xlabels : (optional) an array of labels for the x axis
%   ylabels : (optional) and array of labels for the y axis
%   colourmap : (optional) the colourmap to apply. Default is gray.
%
%   Example: MatrixPlot([1 2 3, 4 5 6], {'one', 'two', 'three'}, {'x', 'y'})
%   Example: MatrixPlot([1 2 3, 4 5 6])

%show a graph
fig = figure;
imagesc(mat);

if (nargin >= 5)
    colormap(colourmap);
else
    colormap(gray);
end

if (nargin >= 2)
      set(gca,'XTick',1:size(mat,2),...                         %# Change the axes tick marks
        'XTickLabel',xlabels,...  %#   and tick labels
        'YTick',1:size(mat,1),...
        'YTickLabel',ylabels,...
        'TickLength',[0 0]); 
else
   set(gca,'XTick',1:size(mat,2),...                         %# Change the axes tick marks
        'XTickLabel',1:size(mat,2),...  %#   and tick labels
        'YTick',1:size(mat,1),...
        'YTickLabel',1:size(mat,1),...
        'TickLength',[0 0]); 
end

if (nargin >= 4)
   title(plotTitle) 
end

if (nargin >= 8)
    set(gca, 'CLim', colormapScale); 
end

if (nargin >= 6)
    if (normalPrint == true)
        print(fig,'-r300', '-dpng', strcat(plotTitle, '.png')); 
    end
end

if (nargin >= 7)
    if (rawPrint == true)
        
    title(''); 
    set(gca,'XTick','',...                         %# Change the axes tick marks
        'XTickLabel','',...  %#   and tick labels
        'YTick','',...
        'YTickLabel','',...
        'TickLength',[0 0]); 
    
    set(gca, 'DataAspectRatio', [1, 1, 1]);
    colorbar off;
    axpos = get(gca, 'position');
    %expand axes to fill figure window
    outerpos = get(gca, 'outerposition');
    insetpos = get(gca, 'tightinset');
    set(gca, 'position', [insetpos(1) insetpos(2) ...
        outerpos(3)-insetpos(3) outerpos(4)-insetpos(4)]);
    
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 10]); %100dpi x these numbers
    print(fig,'-r100', '-dpng', strcat('Raw ', plotTitle, '.png')); 
    end
else
    colorbar;
end



if nargout >= 1
    varargout{1} = fig;

end

