function [handles] =   show_camera(handles, hObject, K, Rt, cutoff_cols, camnumber)

axis_length = 0.009;

intrinsics = handles.intrinsics;
focal_length = str2num(intrinsics{1})*10^-3;
object = handles.object;

extension_factor = str2num(get(handles.edit_extensionfactor, 'String'));

if isempty(extension_factor) || extension_factor == 0
   extension_factor = 1; 
end




xcam = str2num(get(handles.edit_xcam, 'String'));
if isempty(xcam)
    xcam = 0
end

ycam = str2num(get(handles.edit_ycam, 'String'));
if isempty(ycam)
    xcam = 0
end

zcam = str2num(get(handles.edit_zcam, 'String'));
if isempty(zcam)
    xcam = 0
end

camposition = [xcam; ycam; zcam];





% create matrix to transform: CCS->WCS
Rt_inv = inv(Rt);





    % create axes vectors
    pinhole_axis = ones(4);
    X_wcs  = Rt_inv*[axis_length*extension_factor; 0; 0; 1];              % x-axis
    Y_wcs  = Rt_inv*[0; axis_length*extension_factor; 0; 1];              % y-axis
    Z_wcs  = Rt_inv*[0; 0; (axis_length+0.05)*extension_factor; 1];       % z-axis (optical axis)
    PA_wcs = Rt_inv*[0; 0; -extension_factor*focal_length; 1];            % principal axis
    
    
% GET IMG POINTS FOR WOLRD PLOT--------------------------------------------
    % GET PLOT MATRIX 
    P_plot = [-extension_factor*focal_length 0 0 0;...
             0 -extension_factor*focal_length 0 0;...
             0 0 -extension_factor*focal_length 0;...
             0 0 0 1];
        % -> create matrix zu calculate simple pinhole coordinates from
        % given object. NOTE: (-) sign nessecary to create backwards image
    
    object_ccs = Rt*object;
    img_plot = P_plot*Rt*object;
        % -> nessecary to transform object in CCS first.
    img_plot(1:3,:) = repmat(1 ./ abs(object_ccs(3,:)), 3, 1) .* img_plot(1:3,:);
    img_plot = Rt_inv * img_plot;    
        % -> calculate img points and retransform back to WCS 
        % -> NOTE: abs(object_ccs) to save sign (see P_plot)
    img_plot(:,cutoff_cols) = [];
    
     % GET SENSOR RECTANGLE + CS-------------------------------------------
    [sensor_corners sensor_axes] = sensor_shape(intrinsics, extension_factor, axis_length*extension_factor);
    sensor_corners_wcs = Rt_inv * sensor_corners;
        % -> transform into WCS
    sensor_axes = Rt_inv * sensor_axes;
        % -> transform into WCS
    
     % GET OPENING ANGLE-------------------------------------------------------
    sensor_corners_fronted = sensor_corners;
    sensor_corners_fronted(3,:) = -sensor_corners_fronted(3,:);
        % -> get fronted sensor corners 
    sensor_corners_fronted = Rt_inv*sensor_corners_fronted;
    

   
% PLOT--------------------------------------------------------------------   

camplot = handles.camplot;
axis(handles.axes1); 

hold on    
    % CCS AXES
     camplot{1,1, camnumber} = plot3([camposition(1), X_wcs(1)], [camposition(2), X_wcs(2)], [camposition(3),  X_wcs(3)],   'r');
     camplot{1,2, camnumber} = plot3([camposition(1), Y_wcs(1)], [camposition(2), Y_wcs(2)], [camposition(3),  Y_wcs(3)],   'g');
     camplot{1,3, camnumber} = plot3([camposition(1), Z_wcs(1)], [camposition(2), Z_wcs(2)], [camposition(3),  Z_wcs(3)],    'b');
    % PRINCIPAL AXIS
     camplot{1,4, camnumber} = plot3([camposition(1), PA_wcs(1)], [camposition(2), PA_wcs(2)], [camposition(3),  PA_wcs(3)],    '--b');
    % SENSOR IMG
     camplot{2,1, camnumber} =  plot3(img_plot(1,:), img_plot(2,:) , img_plot(3,:), '.b');
    % SENSOR SHAPE
     camplot{3,1, camnumber} =  plot3([sensor_corners_wcs(1,1) sensor_corners_wcs(1,2)], [sensor_corners_wcs(2,1) sensor_corners_wcs(2,2)], [sensor_corners_wcs(3,1) sensor_corners_wcs(3,2)], 'c'); 
     camplot{3,2, camnumber} =  plot3([sensor_corners_wcs(1,1) sensor_corners_wcs(1,3)], [sensor_corners_wcs(2,1) sensor_corners_wcs(2,3)], [sensor_corners_wcs(3,1) sensor_corners_wcs(3,3)], 'c'); 
     camplot{3,3, camnumber} =  plot3([sensor_corners_wcs(1,3) sensor_corners_wcs(1,4)], [sensor_corners_wcs(2,3) sensor_corners_wcs(2,4)], [sensor_corners_wcs(3,3) sensor_corners_wcs(3,4)], 'c'); 
     camplot{3,4, camnumber} =  plot3([sensor_corners_wcs(1,4) sensor_corners_wcs(1,2)], [sensor_corners_wcs(2,4) sensor_corners_wcs(2,2)], [sensor_corners_wcs(3,4) sensor_corners_wcs(3,2)], 'c'); 
            % -> plot sensor rectangle        
     camplot{4,1, camnumber} =  plot3([sensor_axes(1,4) sensor_axes(1,1)],[sensor_axes(2,4) sensor_axes(2,1)], [sensor_axes(3,4) sensor_axes(3,1)],'r');
     camplot{4,2, camnumber} =  plot3([sensor_axes(1,4) sensor_axes(1,2)],[sensor_axes(2,4) sensor_axes(2,2)], [sensor_axes(3,4) sensor_axes(3,2)],'g');
     camplot{4,3, camnumber} =  plot3([sensor_axes(1,4) sensor_axes(1,3)],[sensor_axes(2,4) sensor_axes(2,3)], [sensor_axes(3,4) sensor_axes(3,3)],'b');
            % -> plot sensor CS axis            
    % OPENING ANGLE
     camplot{5,1, camnumber} =   plot3([camposition(1) sensor_corners_fronted(1,1)], [camposition(2) sensor_corners_fronted(2,1)], [camposition(3) sensor_corners_fronted(3,1)], 'k');
     camplot{5,2, camnumber} =   plot3([camposition(1) sensor_corners_fronted(1,2)], [camposition(2) sensor_corners_fronted(2,2)], [camposition(3) sensor_corners_fronted(3,2)], 'k');
     camplot{5,3, camnumber} =   plot3([camposition(1) sensor_corners_fronted(1,3)], [camposition(2) sensor_corners_fronted(2,3)], [camposition(3) sensor_corners_fronted(3,3)], 'k');
     camplot{5,4, camnumber} =   plot3([camposition(1) sensor_corners_fronted(1,4)], [camposition(2) sensor_corners_fronted(2,4)], [camposition(3) sensor_corners_fronted(3,4)], 'k');
            % -> plot rays between pinhole and fronted sensor corners
     camplot{6,1, camnumber} =   plot3([sensor_corners_fronted(1,1) sensor_corners_fronted(1,2)], [sensor_corners_fronted(2,1) sensor_corners_fronted(2,2)], [sensor_corners_fronted(3,1) sensor_corners_fronted(3,2)], 'k');
     camplot{6,2, camnumber} =   plot3([sensor_corners_fronted(1,1) sensor_corners_fronted(1,3)], [sensor_corners_fronted(2,1) sensor_corners_fronted(2,3)], [sensor_corners_fronted(3,1) sensor_corners_fronted(3,3)], 'k');
     camplot{6,3, camnumber} =   plot3([sensor_corners_fronted(1,4) sensor_corners_fronted(1,2)], [sensor_corners_fronted(2,4) sensor_corners_fronted(2,2)], [sensor_corners_fronted(3,4) sensor_corners_fronted(3,2)], 'k');
     camplot{6,4, camnumber} =   plot3([sensor_corners_fronted(1,4) sensor_corners_fronted(1,3)], [sensor_corners_fronted(2,4) sensor_corners_fronted(2,3)], [sensor_corners_fronted(3,4) sensor_corners_fronted(3,3)], 'k');

    if (get(handles.cb_lines, 'Value') == 1)
        object(:,cutoff_cols) = [];
        for j = 1: size(object,2)
            camplot{7,j, camnumber} = plot3([object(1,j) img_plot(1,j)], [object(2,j) img_plot(2,j)] , [object(3,j) img_plot(3,j)], 'r--', 'LineWidth',0.5,'MarkerSize',0.5');
        end
    end
    
    camplot{8,1, camnumber} = text(camposition(1), camposition(2), camposition(3) , ['CAM', num2str(camnumber)]);
    
hold off

handles.camplot = camplot; 
guidata(hObject, handles);
    
    
    
end

