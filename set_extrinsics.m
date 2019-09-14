function [Rt] = set_extrinsics(handles)

 x_pos = get(handles.edit_xcam, 'String');
 x_pos = str2num(x_pos);
 if isempty(x_pos)
    x_pos = 0;
 end
 
 y_pos = get(handles.edit_ycam, 'String');
 y_pos = str2num(y_pos);
 if isempty(y_pos)
     y_pos = 0;
 end
 
 z_pos = get(handles.edit_zcam, 'String');
 z_pos = str2num(z_pos);
 if isempty(z_pos)
    z_pos = 0; 
 end


 alpha_x = get(handles.edit_xrot, 'String');
 alpha_x = str2num(alpha_x);
 if isempty(alpha_x)
 alpha_x = 0;
 end
 
 alpha_y = get(handles.edit_yrot, 'String');
 alpha_y = str2num(alpha_y);
 if isempty(alpha_y)
    alpha_y = 0; 
 end
 
 alpha_z = get(handles.edit_zrot, 'String');
 alpha_z = str2num(alpha_z);
 if isempty(alpha_z)
    alpha_z = 0; 
 end
 
 
 
        rot_matrix_z = [cosd(alpha_z) -sind(alpha_z) 0;...
                        sind(alpha_z) cosd(alpha_z) 0;...
                        0 0 1];
            % -> rotation matrix around z-axis
    
        rot_matrix_y = [cosd(alpha_y) 0 sind(alpha_y);...
                        0 1 0;...
                       -sind(alpha_y) 0 cosd(alpha_y)];
            % -> rotation matrix around y-axis   
                        
        rot_matrix_x = [1 0 0;...
                        0 cosd(alpha_x) -sind(alpha_x);...
                        0 sind(alpha_x) cosd(alpha_x)]; 
            % -> rotation matrix around x-axis
            
        R =  rot_matrix_z * rot_matrix_y * rot_matrix_x;
            % -> total rotation matrix

            tprim = [x_pos; y_pos; z_pos];
            t =  -R*tprim;
            
            Rt = [R,t; 0 0 0 1];
            
end

