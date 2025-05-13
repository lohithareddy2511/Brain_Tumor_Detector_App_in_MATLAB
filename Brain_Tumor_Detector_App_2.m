function Brain_Tumor_Detector_App_2()
    % Create the UI figure
    % This line creates a window for the app where the user can interact with the tools.
    % The window size is set to 1000x600 pixels, and the background color is a light shade of blue.
    fig = uifigure('Name','Brain Tumor Detector','Position',[100 100 1000 600], 'Color', [0.95 0.95 1]);

    % Title
    % This section displays the title of the app in a bold, dark blue font.
    % The title is placed at the top of the window, centered horizontally.
    uilabel(fig, ...
    'Text', 'Brain Tumor Detection using MRI', ... % The text that will be shown as the title
    'Position', [200 550 600 40], ... % The position (x,y) and size (width, height) of the title area
    'FontSize', 20, ... % The font size is set to 20
    'FontWeight', 'bold', ... % The text is bold
    'FontColor', '#003366', ... % Dark blue color for the text
    'HorizontalAlignment', 'center'); % The title is horizontally centered

    % Create axes for displaying images
    % These are four regions in the window where images will be shown: Original MRI, Filtered, Edge Detected, and Tumor Segmented
    % Each region corresponds to an image that will be shown at various steps of the processing.

    % Axes for original MRI image
    ax1 = uiaxes(fig,'Position',[50 330 300 200],'Box','on');
    title(ax1, 'Original MRI','FontSize',14,'Color','#880088'); % Title for the original image section

    % Axes for median filtered image
    ax2 = uiaxes(fig,'Position',[50 80 300 200],'Box','on');
    title(ax2, 'Median Filtered','FontSize',14,'Color','#880088'); % Title for the filtered image section

    % Axes for edge detected image
    ax3 = uiaxes(fig,'Position',[380 330 300 200],'Box','on');
    title(ax3, 'Edge Detected','FontSize',14,'Color','#880088'); % Title for the edge-detected image section

    % Axes for tumor segmented image
    ax4 = uiaxes(fig,'Position',[380 80 300 200],'Box','on');
    title(ax4, 'Tumor Segmented','FontSize',14,'Color','#880088'); % Title for the tumor-detected image section

    % Store data
    % We store images at different stages (original, filtered, edges, tumor) here for processing
    imgData = struct('original',[], 'filtered', [], 'edges', [], 'tumor', []);

    % Create buttons for user interaction
    % Each button allows the user to perform a specific function like loading an MRI image, applying a filter, detecting edges, etc.
    
    % Select MRI button
    uibutton(fig,'Text','Select MRI','Position',[720 480 140 30], ...
        'ButtonPushedFcn',@(btn,event) loadImage(), 'BackgroundColor', '#6C63FF', 'FontColor','w'); % Button to load an MRI image
    
    % Apply Median Filter button
    uibutton(fig,'Text','Median Filter','Position',[720 420 140 30], ...
        'ButtonPushedFcn',@(btn,event) applyMedian(), 'BackgroundColor', '#3F51B5', 'FontColor','w'); % Button to apply median filter
    
    % Edge Detection button
    uibutton(fig,'Text','Edge Detect','Position',[720 360 140 30], ...
        'ButtonPushedFcn',@(btn,event) detectEdges(), 'BackgroundColor', '#0097A7', 'FontColor','w'); % Button to apply edge detection
    
    % Tumor Detection button
    uibutton(fig,'Text','Detect Tumor','Position',[720 300 140 30], ...
        'ButtonPushedFcn',@(btn,event) detectTumor(), 'BackgroundColor', '#4CAF50', 'FontColor','w'); % Button to detect the tumor
    
    % Reset button
    uibutton(fig,'Text','Reset','Position',[720 240 140 30], ...
        'ButtonPushedFcn',@(btn,event) resetGUI(), 'BackgroundColor', '#E53935', 'FontColor','w'); % Button to reset the GUI and clear images

    % Load MRI Image
    % This function allows the user to select and load an MRI image.
    function loadImage()
        % Open file dialog to select an image file
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'}); % Allows user to pick an image file
        if isequal(file,0)
            uialert(fig,'No file selected.','Warning'); % Show a warning if no file is selected
            return;
        end
        % Read and convert the image to double precision for further processing
        img = im2double(imread(fullfile(path,file))); 
        % If the image is in color (3 channels), convert it to grayscale (single channel)
        if size(img,3) == 3
            img = rgb2gray(img); % Convert RGB to grayscale
        end
        % Store the original MRI image
        imgData.original = img; 
        % Display the original MRI image in the first axes
        imshow(img,'Parent',ax1); 
    end

    % Apply Median Filter
    % This function applies a median filter to remove noise from the MRI image.
    % It replaces each pixel with the median of its neighboring pixels.
    function applyMedian()
        % Check if the image is loaded
        if isempty(imgData.original)
            uialert(fig,'Load an image first!','Error'); % Show an error if no image is loaded
            return;
        end
        % Apply the median filter to remove noise from the original MRI image
        filtered = medfilt2(imgData.original); 
        % Store the filtered image
        imgData.filtered = filtered; 
        % Display the filtered image in the second axes
        imshow(filtered,'Parent',ax2); 
    end

    % Edge Detection using Sobel operator
    % This function detects the edges (boundaries) in the MRI image.
    % It helps highlight abrupt changes in the image, showing where objects or features are located.
    function detectEdges()
        % Check if the median filter has been applied
        if isempty(imgData.filtered)
            uialert(fig,'Apply median filter first!','Error'); % Show an error if the filter isn't applied
            return;
        end
        % Convert the filtered image to a double precision format
        img = double(imgData.filtered); 
        % Get the size of the image (rows and columns)
        [rows, cols] = size(img); 
        % Create an empty matrix to store the edges of the image
        edges = zeros(rows-2, cols-2); 
        % Apply Sobel operator for edge detection
        for i = 1:rows-2
            for j = 1:cols-2
                % Sobel operator for detecting edges in the x and y directions
                Gx = (2*img(i+2,j+1)+img(i+2,j)+img(i+2,j+2)) - (2*img(i,j+1)+img(i,j)+img(i,j+2));
                Gy = (2*img(i+1,j+2)+img(i,j+2)+img(i+2,j+2)) - (2*img(i+1,j)+img(i,j)+img(i+2,j));
                % Combine the gradients to calculate edge strength
                edges(i,j) = sqrt(Gx^2 + Gy^2); 
            end
        end
        % Store the detected edges
        imgData.edges = edges; 
        % Display the edges in the third axes
        imshow(edges,[],'Parent',ax3); 
    end

    % Tumor Detection
    % This function detects the tumor by identifying regions that are likely to be the tumor.
    % It looks for areas that are more solid and larger than others.
    function detectTumor()
        % Check if the median filter has been applied
        if isempty(imgData.filtered)
            uialert(fig,'Apply median filter first!','Error'); % Show an error if the filter isn't applied
            return;
        end
        % Convert the filtered image to a binary (black and white) image
        bw = imbinarize(imgData.filtered, 0.7); 
        % Label connected components in the binary image
        label = bwlabel(bw); 
        % Measure the properties (size, solidity) of the labeled regions
        stats = regionprops(label, 'Solidity','Area'); 
        % Extract the solidity (how solid the shape is) and area (size of the region)
        densities = [stats.Solidity]; 
        areas = [stats.Area]; 
        % Identify regions that are solid
        high_dense = densities > 0.5; 
        % Find the region with the largest area (most likely to be the tumor)
        max_area = max(areas(high_dense)); 
        tumor_label = find(areas == max_area); 
        % Create a binary image showing the detected tumor region
        tumor = ismember(label, tumor_label); 
        % Dilate the tumor region to make it more visible
        tumor = imdilate(tumor, strel('square',5)); 

        % Display the filtered MRI image
        imshow(imgData.filtered,[],'Parent',ax4); 
        hold(ax4,'on'); % Hold the current image to overlay the tumor boundary
        % Find and plot the boundary of the tumor
        boundaries = bwboundaries(tumor,'noholes'); 
        for k = 1:length(boundaries)
            boundary = boundaries{k};
            % Plot the boundary in yellow on the image
            plot(ax4, boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2); 
        end
        hold(ax4,'off'); % Release the hold
        % Store the detected tumor in the data structure
        imgData.tumor = tumor; 
    end

    % Reset GUI
    % This function clears all the images and resets the app to its initial state
    function resetGUI()
        % Clear all displayed images
        cla(ax1); cla(ax2); cla(ax3); cla(ax4); 
        % Reset the image data to empty
        imgData = struct('original',[], 'filtered', [], 'edges', [], 'tumor', []); 
    end
end
