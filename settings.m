function [axis_x axis_y axis_z axis_xm axis_ym axis_zm] = settings(handles)
%SETTINGS Summary of this function goes here
%   Detailed explanation goes here


 
 axis_x = get(handles.edit_x, 'String');
 axis_x = str2num(axis_x);
 if isempty(axis_x)
     axis_x = 5;
 else 
      axis_x =  axis_x(1);
 end
 
 axis_y = get(handles.edit_y, 'String');
 axis_y = str2num(axis_y);
  if isempty(axis_y)
     axis_y = 5;
  else 
      axis_y = axis_y(1);
  end
 
 axis_z = get(handles.edit_z, 'String');
 axis_z = str2num(axis_z);
  if isempty(axis_z)
     axis_z = 5;
  else
     axis_z = axis_z(1);
  end
  
 axis_xm = get(handles.edit_xm, 'String');
 axis_xm = str2num(axis_xm);
 if isempty(axis_xm)
     axis_xm = -5;
 else
     axis_xm = axis_xm(1);
 end
 
 axis_ym = get(handles.edit_ym, 'String');
 axis_ym = str2num(axis_ym);
  if isempty(axis_y)
      axis_ym  = -5;
  else 
      axis_ym = axis_ym(1);
  end
  
 axis_zm = get(handles.edit_zm, 'String');
 axis_zm = str2num(axis_zm);
  if isempty(axis_zm)
     axis_zm = 5;
  else
      axis_zm = axis_zm(1);
  end
 
end

