function [ ] = show_results(K_calib, Rt_calib, K, Rt, handles)

set(handles.uitable_K, 'Data', K(1:3,1:3))
set(handles.uitable_Kcalib, 'Data', K_calib(1:3,1:3))
set(handles.uitable_Rt, 'Data', Rt(1:3,1:4))
set(handles.uitable_Rtcalib, 'Data', Rt_calib(1:3,1:4))
end

