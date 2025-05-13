function Brain_Tumor_Detector_App()
    % Create the UI figure
    fig = uifigure('Name','Brain Tumor Detector','Position',[100 100 1000 600], 'Color', [0.95 0.95 1]);
% Title
uilabel(fig, ...
    'Text', 'Brain Tumor Detection using MRI', ...
    'Position', [200 550 600 40], ...
    'FontSize', 20, ...
    'FontWeight', 'bold', ...
    'FontColor', '#003366', ... % Dark blue color for text
    'HorizontalAlignment', 'center');


    % Create axes for displaying images
    ax1 = uiaxes(fig,'Position',[50 330 300 200],'Box','on');
    title(ax1, 'Original MRI','FontSize',14,'Color','#880088');

    ax2 = uiaxes(fig,'Position',[50 80 300 200],'Box','on');
    title(ax2, 'Median Filtered','FontSize',14,'Color','#880088');

    ax3 = uiaxes(fig,'Position',[380 330 300 200],'Box','on');
    title(ax3, 'Edge Detected','FontSize',14,'Color','#880088');

    ax4 = uiaxes(fig,'Position',[380 80 300 200],'Box','on');
    title(ax4, 'Tumor Segmented','FontSize',14,'Color','#880088');

    % Store data
    imgData = struct('original',[], 'filtered', [], 'edges', [], 'tumor', []);

    % Create buttons
    uibutton(fig,'Text','Select MRI','Position',[720 480 140 30], ...
        'ButtonPushedFcn',@(btn,event) loadImage(), 'BackgroundColor', '#6C63FF', 'FontColor','w');

    uibutton(fig,'Text','Median Filter','Position',[720 420 140 30], ...
        'ButtonPushedFcn',@(btn,event) applyMedian(), 'BackgroundColor', '#3F51B5', 'FontColor','w');

    uibutton(fig,'Text','Edge Detect','Position',[720 360 140 30], ...
        'ButtonPushedFcn',@(btn,event) detectEdges(), 'BackgroundColor', '#0097A7', 'FontColor','w');

    uibutton(fig,'Text','Detect Tumor','Position',[720 300 140 30], ...
        'ButtonPushedFcn',@(btn,event) detectTumor(), 'BackgroundColor', '#4CAF50', 'FontColor','w');

    uibutton(fig,'Text','Reset','Position',[720 240 140 30], ...
        'ButtonPushedFcn',@(btn,event) resetGUI(), 'BackgroundColor', '#E53935', 'FontColor','w');

    % Load MRI Image
    function loadImage()
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'});
        if isequal(file,0)
            uialert(fig,'No file selected.','Warning');
            return;
        end
        img = im2double(imread(fullfile(path,file)));
        if size(img,3) == 3
            img = rgb2gray(img);
        end
        imgData.original = img;
        imshow(img,'Parent',ax1);
    end

    % Apply Median Filter
    function applyMedian()
        if isempty(imgData.original)
            uialert(fig,'Load an image first!','Error');
            return;
        end
        filtered = medfilt2(imgData.original);
        imgData.filtered = filtered;
        imshow(filtered,'Parent',ax2);
    end

    % Edge Detection using Sobel
    function detectEdges()
        if isempty(imgData.filtered)
            uialert(fig,'Apply median filter first!','Error');
            return;
        end
        img = double(imgData.filtered);
        [rows, cols] = size(img);
        edges = zeros(rows-2, cols-2);
        for i = 1:rows-2
            for j = 1:cols-2
                Gx = (2*img(i+2,j+1)+img(i+2,j)+img(i+2,j+2)) - (2*img(i,j+1)+img(i,j)+img(i,j+2));
                Gy = (2*img(i+1,j+2)+img(i,j+2)+img(i+2,j+2)) - (2*img(i+1,j)+img(i,j)+img(i+2,j));
                edges(i,j) = sqrt(Gx^2 + Gy^2);
            end
        end
        imgData.edges = edges;
        imshow(edges,[],'Parent',ax3);
    end

    % Detect Tumor
    function detectTumor()
        if isempty(imgData.filtered)
            uialert(fig,'Apply median filter first!','Error');
            return;
        end
        bw = imbinarize(imgData.filtered, 0.7);
        label = bwlabel(bw);
        stats = regionprops(label, 'Solidity','Area');
        densities = [stats.Solidity];
        areas = [stats.Area];
        high_dense = densities > 0.5;
        max_area = max(areas(high_dense));
        tumor_label = find(areas == max_area);
        tumor = ismember(label, tumor_label);
        tumor = imdilate(tumor, strel('square',5));

        imshow(imgData.filtered,[],'Parent',ax4);
        hold(ax4,'on');
        boundaries = bwboundaries(tumor,'noholes');
        for k = 1:length(boundaries)
            boundary = boundaries{k};
            plot(ax4, boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2);
        end
        hold(ax4,'off');
        imgData.tumor = tumor;
    end

    % Reset GUI
    function resetGUI()
        cla(ax1); cla(ax2); cla(ax3); cla(ax4);
        imgData = struct('original',[], 'filtered', [], 'edges', [], 'tumor', []);
    end
end
