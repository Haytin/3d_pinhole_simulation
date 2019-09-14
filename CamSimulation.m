function varargout = CamSimulation(varargin)
% CAMSIMULATION MATLAB code for CamSimulation.fig
%      CAMSIMULATION, by itself, creates a new CAMSIMULATION or raises the existing
%      singleton*.
%
%      H = CAMSIMULATION returns the handle to a new CAMSIMULATION or the handle to
%      the existing singleton*.
%
%      CAMSIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMSIMULATION.M with the given input arguments.
%
%      CAMSIMULATION('Property','Value',...) creates a new CAMSIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CamSimulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CamSimulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CamSimulation

% Last Modified by GUIDE v2.5 20-Aug-2017 14:50:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CamSimulation_OpeningFcn, ...
                   'gui_OutputFcn',  @CamSimulation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CamSimulation is made visible.
function CamSimulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CamSimulation (see VARARGIN)

%--- default settings
clc
set(hObject,'toolbar','figure') %get toolbar 

%--- inital values
extension_factor = 1;
axis_length = 0.5;
handles.objectplot = [];
handles.object = [];
handles.K = [];
handles.Rt = [];
handles.pitches = [];
handles.camnumber = 0;
handles.camplot = [];
handles.images = [];
handles.matrices = [];
handles.cutoffcols = [];
handles.H_to_last = [];
handles.H_to_previous = [];


% set table sizes
set(handles.uitable_K,'Data', cell(3,3) )
set(handles.uitable_Kcalib,'Data', cell(3,3))
set(handles.uitable_Rt,'Data', cell(3,4) )
set(handles.uitable_Rtcalib,'Data', cell(3,4))

axis(handles.axes1);
xlabel('X-AXIS')
ylabel('Y-AXIS')
zlabel('Z-AXIS')
draw_wcs(extension_factor, axis_length)
grid minor
axis([-5 5 -5 5 -5 5]); 



% Choose default command line output for CamSimulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CamSimulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CamSimulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% -*-*-*-*-*-*-*-*-*-*-*-*  GENERAL PANEL *-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*_
% *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

% --- PUSHBUTTON: set axis settings
function pb_applysettings_Callback(hObject, eventdata, handles)
    [axis_x axis_y axis_z axis_xm axis_ym axis_zm] = settings(handles);
    axis(handles.axes1); 
    hold on
    axis([axis_xm axis_x axis_ym axis_y axis_zm axis_z]);
    hold off


function edit_extensionfactor_CreateFcn(hObject, eventdata, handles)
function edit_extensionfactor_Callback(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_z_Callback(hObject, eventdata, handles)
function edit_z_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_y_Callback(hObject, eventdata, handles)
function edit_y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_Callback(hObject, eventdata, handles)
function edit_x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xm_Callback(hObject, eventdata, handles)
function edit_xm_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ym_Callback(hObject, eventdata, handles)
function edit_ym_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_zm_Callback(hObject, eventdata, handles)
function edit_zm_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% -*-*-*-*-*-*-*-*-*-*-*-*  OBJECT PANEL *-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*_*_
% *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

% --- PUSHBUTTON: set chosen object
function pb_applyobject_Callback(hObject, eventdata, handles)
    %check if object was chosen
    object_num = get(handles.popup_object, 'Value');
    if object_num ==1
        choice = errordlg('Please choose object!','OBJECT ERROR');
    else 
        %generate object
        [object] = get_object(object_num, handles);
        handles.object = object;
        %make sure no other object exists
        if isempty(handles.objectplot)
            axis(handles.axes1);
            hold on
            objectplot = plot3(object(1,:), object(2,:) , object(3,:), '.b');
            hold off
            handles.objectplot = objectplot;
        end
    end
guidata(hObject, handles);


%  --- PUSHBUTTON: clear generated object
function pb_clearobject_Callback(hObject, eventdata, handles)
    objectplot = handles.objectplot;
    handles.object = [];
    delete(objectplot)
    objectplot = [];
    handles.objectplot = objectplot;
guidata(hObject, handles);


% --- PUSHBUTTON: load own created 4 x n object
function pb_loadown_Callback(hObject, eventdata, handles)
    % get object path
    [pathname,dirname] = uigetfile();
    load(fullfile(dirname, pathname));
    % add object position
    [object] = set_objectposition(object, handles);
    handles.object = object;
    % plot
    axis(handles.axes1);
    hold on
    oplot = plot3(object(1,:), object(2,:) , object(3,:), '.b');
    hold off
    handles.objectplot = oplot;
guidata(hObject, handles);


function popup_object_Callback(hObject, eventdata, handles)
function popup_object_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% -*-*-*-*-*-*-*-*-*-*-*-*  PINHOLE PANEL *-*-*-*-*-*-*-*-*-*-*-*-*-*-*_*_*
% *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

% --- PUSHBUTTON: set camera intrinsics
function pb_setintrinsics_Callback(hObject, eventdata, handles)
    % set default values
    default_intr = {'16', '11.264', '11.264', '5.5', '5.5', '0'}; 
    % user input
    intrinsics = inputdlg({'focal length[mm]', 'sensor height [mm]', 'sensor width [mm]'...
    , 'X-Pitch [um] ', 'Y-Pitch [um]', 'skew'}, 'Intrinsics', [1 20; 1 20; 1 20; 1 20; 1 20; 1 20], default_intr);
    % create internal matrix
    K = set_internal(intrinsics, handles );
    handles.K = K;
    handles.intrinsics = intrinsics; 

guidata(hObject, handles);

 
% --- PUSHBUTTON: create pinhole camera
function pb_create_Callback(hObject, eventdata, handles)
    
    %check if intrinsics were set
    K = handles.K ;
    if isempty(K)
        errordlg('Please set intrinsic first', 'ERROR')
    else 
        %create external matrix
        Rt = set_external(handles);
        object = handles.object;
        % check if object was set    
        if isempty(object)
        errordlg('Please set object first', 'ERROR')
        else    
            camnumber = handles.camnumber;
            camnumber = camnumber +1;      
            intrinsics = handles.intrinsics;
            pitches = handles.pitches;
            pitches{1,camnumber} = intrinsics{4};
            pitches{2,camnumber} = intrinsics{5};
            pitches
            handles.pitches = pitches;
            % get images
            [img, img_dist, cutoff_cols] = get_images(K, Rt, object, handles);
            % plot camera in word plot
            handles = show_camera(handles, hObject,  K, Rt, cutoff_cols, camnumber);
            % plot camera sensor in own figure
            show_sensor(K, img_dist, camnumber)
       
            images = handles.images;
             images{1,camnumber} = img;
            images{2,camnumber} = img_dist;
            handles.images = images;
       
            matrices = handles.matrices;
            matrices{1,camnumber} = K;
            matrices{2,camnumber} = Rt;
            handles.matrices = matrices;
       
            cutoffcols{1,camnumber} = cutoff_cols;
            handles.cutoffcols = cutoffcols;
            handles.camnumber = camnumber;             
        end 
    end

guidata(hObject, handles);


% --- Executes on button press in pb_calibrate.
function pb_calibrate_Callback(hObject, eventdata, handles)
    % check if at least one camera was set
    camnumber = handles.camnumber;
    if camnumber == 0;
        errordlg('Please create camera first','ERROR')    
    else 
        %delete object points with no correspondig img point on sensor
        cutoffcols = handles.cutoffcols;
        cutoff_cols = cutoffcols{1,camnumber};
        object = handles.object;
        object(:,cutoff_cols) = [];
    % (sparse) check if object is 3-dimensional     
    if sum( diff(object(3,:),1,2) ) == 0
        errordlg('Please set 3-dimensional object for calibration','ERROR')
    else
        images = handles.images;
        img = images{2, camnumber}; 
        %calibrate with distorted img
        [K_dlt, Rt_dlt] = dlt(object, img);
        [K_calib, Rt_calib, k, p] = optimize(K_dlt, Rt_dlt, object, img)
        
        matrices = handles.matrices;
        K = matrices{1, camnumber};
        Rt = matrices{2, camnumber};
        % put results in tables
        show_results(K_calib, Rt_calib, K, Rt, handles)
    end
end
    

% --- PUSHBUTTON: calculate homography between last two cameras
function pb_gethomography_Callback(hObject, eventdata, handles)
    
    camnumber = handles.camnumber;
    pitches = handles.pitches
    images = handles.images;
    % check if two cameras exist
    if (size(images,2)<2)
        errordlg('Please create at least 2 cameras','ERROR')
    else
        % get (distorted) images from last two cameras
        img_previous = images{2,camnumber-1};      
        img_last = images{2,camnumber};  
        %choose previous camera pixel system to calculate in, therefore
        %transform last camera pixel system into previous system
        img_last(1,:) = img_last(1,:).* (str2num(pitches{1,camnumber})*10^-6); %convert 
        img_last(1,:) = img_last(1,:)./ (str2num(pitches{1,camnumber-1})*10^-6);          
        img_last(2,:) = img_last(2,:).* (str2num(pitches{2,camnumber})*10^-6);  %convert 
        img_last(2,:) = img_last(2,:)./ (str2num(pitches{2,camnumber-1})*10^-6);             
        %calculate homography to calculate last camera's img points, based on
        % previous camera's img points
        H_to_last = homography(img_previous, img_last);
        H_to_last = optimize_homography(H_to_last, img_previous, img_last);
        %calculate homography to calculate previous camera's img points, based on
        % last camera's img points
        H_to_previous = homography(img_last, img_previous);
        H_to_previous = optimize_homography(H_to_previous, img_last, img_previous);
        % send message box
        msgbox('Please make sure that both cameras get all object-points', 'ATTENTION')
        matrices = handles.matrices;
        show_homography(H_to_last, H_to_previous, img_previous, img_last, camnumber, matrices, pitches)
        handles.H_to_previous = H_to_previous;
        handles.H_to_last = H_to_last;
    end
 guidata(hObject, handles);

% --- PUSHBUTTON: calculate common camera pixels
    function pb_getcommonpixel_Callback(hObject, eventdata, handles)
    % check if two cameras exist    
    images = handles.images;
    if (size(images,2)<2)
        errordlg('Please create at least 2 cameras','ERROR')
    else
        commonpixel(handles)
    end


% --- PUSHBUTTON: clear last camera
function pb_clearlastcam_Callback(hObject, eventdata, handles)
    axis(handles.axes1);
    camplot = handles.camplot;
    camnumber = handles.camnumber;
    if (camnumber > 0)
        for j = 1:size(camplot,1) 
            for k = 1: size(camplot,2)
                cp = camplot{j,k,camnumber};
                delete(cp);
            end
        end
    
        camplot(:,:,camnumber) = [];
        handles.camplot = camplot;

        images = handles.images;
        images(:,camnumber) = [];
        handles.images = images;
 


        cutoffcols = handles.cutoffcols;
        cutoffcols{1,camnumber} = [];
        handles.cutoffcols = cutoffcols;

        pitches = handles.pitches;
        pitches(:,camnumber) = [];
        handles.pitches = pitches;

        handles.camnumber = camnumber -1;
    end
guidata(hObject, handles);    




%--- SLIDER
function slider_x_Callback(hObject, eventdata, handles)

    xrot = get(handles.slider_x, 'Value');
    set(handles.edit_xrot,'String',num2str(xrot));
    
function slider_y_Callback(hObject, eventdata, handles)

    yrot = get(handles.slider_y, 'Value');
    set(handles.edit_yrot,'String',num2str(yrot));
    
function slider_z_Callback(hObject, eventdata, handles)

    zrot = get(handles.slider_z, 'Value');
    set(handles.edit_zrot,'String',num2str(zrot));


function edit_xrot_Callback(hObject, eventdata, handles)

    xrot = get(handles.edit_xrot, 'String');
    xrot = str2num(xrot);
    if isempty(xrot) || xrot <0 || xrot >360
        errordlg('Please give a value between [0-360] degree!','ERROR')
    else
        set(handles.slider_x,'Value', xrot)
    end    
    
function edit_yrot_Callback(hObject, eventdata, handles)

    yrot = get(handles.edit_yrot, 'String');
    yrot = str2num(yrot);
    if isempty(yrot) || yrot <0 || yrot >360
        errordlg('Please give a value between [0-360] degree!','ERROR')
    else
        set(handles.slider_y,'Value', yrot)
    end    
        
function edit_zrot_Callback(hObject, eventdata, handles)
    zrot = get(handles.edit_zrot, 'String');
    zrot = str2num(zrot);
    if isempty(zrot) || zrot <0 || zrot >360
        errordlg('Please give a value between [0-360] degree!','ERROR')
    else
        set(handles.slider_z,'Value', zrot)
    end
    
    
% *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*    
% *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function edit_xobject_Callback(hObject, eventdata, handles)
function edit_xobject_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_yobject_Callback(hObject, eventdata, handles)
function edit_yobject_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_zobject_Callback(hObject, eventdata, handles)
function edit_zobject_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_xcam_Callback(hObject, eventdata, handles)
function edit_xcam_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_ycam_Callback(hObject, eventdata, handles)
function edit_ycam_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_zcam_Callback(hObject, eventdata, handles)
function edit_zcam_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function slider_x_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_y_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_z_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_xrot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_yrot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_zrot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_k1_Callback(hObject, eventdata, handles)
function edit_k1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_k2_Callback(hObject, eventdata, handles)
function edit_k2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_p1_Callback(hObject, eventdata, handles)
function edit_p1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_p2_Callback(hObject, eventdata, handles)
function edit_p2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cb_lines_Callback(hObject, eventdata, handles)

function uipanel3_CreateFcn(hObject, eventdata, handles)
function pb_gethomography_CreateFcn(hObject, eventdata, handles)

