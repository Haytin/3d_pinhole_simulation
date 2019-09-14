function[sensor_corners sensor_axes] = sensor_shape(intrinsics, extension_factor, axis_length)
    
    focal_length = str2num(intrinsics{1})*10^-3;
    sensor_height = str2num(intrinsics{2})*10^-3;
    sensor_width = str2num(intrinsics{3})*10^-3;
    
    sensor_corners = ones(4);
    sensor_corners(1:3,1) = [-(extension_factor*sensor_width/2); -(extension_factor*sensor_height/2); -extension_factor*focal_length];
    sensor_corners(1:3,2) = [(extension_factor*sensor_width/2); - (extension_factor*sensor_height/2); -extension_factor*focal_length];
    sensor_corners(1:3,3) = [-(extension_factor*sensor_width/2); (extension_factor*sensor_height/2); -extension_factor*focal_length];
    sensor_corners(1:3,4) = [(extension_factor*sensor_width/2); (extension_factor*sensor_height/2); -extension_factor*focal_length];
        % -> corner coordinates in CCS      

    sensor_axes = ones(4);
    sensor_axes(1:3,1) = [(-extension_factor*sensor_width/2) + axis_length; (extension_factor*sensor_height/2); (-extension_factor*focal_length)]; % x-axis
    sensor_axes(1:3,2) = [(extension_factor*sensor_width/2); (-extension_factor*sensor_height/2)+axis_length; (-extension_factor*focal_length)];   % y-axis
    sensor_axes(1:3,3) = [(extension_factor*sensor_width/2); (extension_factor*sensor_height/2); (-extension_factor*focal_length) + axis_length/2]; % z-axis
    sensor_axes(1:3,4) = [(extension_factor*sensor_width/2); (extension_factor*sensor_height/2); (-extension_factor*focal_length)];               % cs-origin
        % -> senor axes points       
