function varargout = registerFig(varargin)

% REGISTERFIG MATLAB code for registerFig.fig
%      REGISTERFIG, by itself, creates a new REGISTERFIG or raises the existing
%      singleton*.
%
%      H = REGISTERFIG returns the handle to a new REGISTERFIG or the handle to
%      the existing singleton*.
%
%      REGISTERFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTERFIG.M with the given input arguments.
%
%      REGISTERFIG('Property','Value',...) creates a new REGISTERFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before registerFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to registerFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help registerFig

% Last Modified by GUIDE v2.5 16-Jun-2017 10:57:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @registerFig_OpeningFcn, ...
    'gui_OutputFcn',  @registerFig_OutputFcn, ...
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


% --- Executes just before registerFig is made visible.
function registerFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to registerFig (see VARARGIN)

% Choose default command line output for registerFig
handles.output = hObject;
set(handles.radioBttnMale,'Value',1)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes registerFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = registerFig_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editEmail_Callback(hObject, eventdata, handles)
% hObject    handle to editEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEmail as text
%        str2double(get(hObject,'String')) returns contents of editEmail as a double


% --- Executes during object creation, after setting all properties.
function editEmail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bttnSignup.
function bttnSignup_Callback(hObject, eventdata, handles)
% hObject    handle to bttnSignup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%get username and editEmail from bttnSignup page
% waitfor(msgbox('Please wait for me...'));

global usrname;
global emailto;
global rndStr;
gender='a';


username = get(handles.editName,'String');

if isempty(username)
    errordlg('Please enter a name into the text-box. We thank you in anticipation.', 'Error Code I');
    return
elseif ~isempty(find(isstrprop(username, 'digit'), 1)) & isempty(find(isstrprop(username, 'alpha'), 1))
    errordlg('Please enter a name, not numbers. Thank you.', 'Error Code III');
    return
elseif ~isempty(find(isstrprop(username, 'digit'), 1)) & ~isempty(find(isstrprop(username, 'alpha'), 1))
    errordlg('Please enter a name without mixing numbers & characters. Thanks.', 'Error Code IV');
    return
elseif length(username) > 12
    errordlg('Please enter a name that is less than 12 characters long. Thank you.', 'Error Code II');
    return
end



email = get(handles.editEmail,'String');

mobileNumber=get(handles.editMobileNo,'String');

if isempty(mobileNumber)
    errordlg('Please enter a MobileNumber into the text-box. We thank you in anticipation.', 'Error Code I');
    return
elseif ~isempty(find(isstrprop(mobileNumber, 'alpha'), 1)) & isempty(find(isstrprop(mobileNumber, 'digit'), 1))
    errordlg('Please enter a MobileNumber, not chars. Thank you.', 'Error Code III');
    return
% elseif ~isempty(find(isstrprop(mobileNumber, 'punct'), 1)) & isempty(find(isstrprop(mobileNumber, 'digit'), 1))
%     errordlg('Please enter a MobileNumber, not punct. Thank you.', 'Error Code III');
%     return
% elseif ~isempty(find(isstrprop(mobileNumber, 'graphic'), 1)) & isempty(find(isstrprop(mobileNumber, 'digit'), 1))
%     errordlg('Please enter a MobileNumber, not graphic. Thank you.', 'Error Code III');
%     return
% elseif ~isempty(find(isstrprop(mobileNumber, 'wspace'), 1)) & isempty(find(isstrprop(mobileNumber, 'digit'), 1))
%     errordlg('Please enter a MobileNumber, not wspace. Thank you.', 'Error Code III');
%     return
elseif ~isempty(find(isstrprop(mobileNumber, 'digit'), 1)) & ~isempty(find(isstrprop(mobileNumber, 'alpha'), 1))
    errordlg('Please enter a MobileNumber without mixing chars & characters. Thanks.', 'Error Code IV');
    return
elseif length(mobileNumber) > 10
    errordlg('Please enter a MobileNumber that is less than 11 characters long. Thank you.', 'Error Code II');
    return

end


password=get(handles.editPassword,'String');
confirmPw=get(handles.editConfirmPw,'String');
male=get(handles.radioBttnMale,'Value');
female=get(handles.radioBttnFemale,'Value');

if(male==1)
    gender='male';
elseif female==1
    gender='female';
end
disp(gender);
if isempty(username)
    warndlg('Please enter username','!! Warning !!');
elseif regexp(username,'[0-9]')
    warndlg('Please enter proper name','!! Warning !!');
elseif male==0 && female==0
    warndlg('Please select gender type','!! Warning !!');
elseif isempty(password)
    warndlg('Please enter password','!! Warning !!');
elseif length(password)<6
    warndlg('Password should not be less than six characters','!! Warning !!');
elseif ~strcmp(password,confirmPw)
    warndlg('Password does not match','!! Warning !!');
elseif isempty(mobileNumber)
    warndlg('Please enter Mobile Number','!! Warning !!');
elseif length(mobileNumber)<10
    warndlg('Invalid mobile numner','!! Warning !!');
    
elseif isempty(email)
    warndlg('Please enter email id','!! Warning !!');
elseif ~regexp(email,'[A-za-z]')
    warndlg('Please enter valid email id','!! Warning !!');
    
    
    
else
        emailexp = '[a-zA-Z0-9_]+@[a-z]+\.(com|net)';
        ansr=regexp(email, emailexp, 'match');
        ansr2=strjoin(ansr);
        try
        if(ansr2~=email)
        end
        catch
            errordlg('Wrong email','Error');
            return;
        end
    conn=dbconnConfig();
    if isconnection(conn)
        colnames={'username','gender','password','mobile_no','email_id'};
        coldata={username,gender,password,mobileNumber,email};
        insert(conn,'signin',colnames,coldata);
        %insert(com,'signin',{'username','email','mailStr'},{usrname,emailto,rndStr});
        h = waitbar(0,'Please wait...');
        steps = 1000;
        for step = 100:steps
            % computations take place here
            waitbar(step / steps)
        end
        close(h)
        close(registerFig);
        loginFig();
        
    else
        warndlg('Connection error(Server problem)','!! Warning !!');
    end
    
    
end

function editName_Callback(hObject, eventdata, handles)
% hObject    handle to editName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editName as text
%        str2double(get(hObject,'String')) returns contents of editName as a double


% --- Executes during object creation, after setting all properties.
function editName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editConfirmPw_Callback(hObject, eventdata, handles)
% hObject    handle to editConfirmPw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editConfirmPw as text
%        str2double(get(hObject,'String')) returns contents of editConfirmPw as a double


% --- Executes during object creation, after setting all properties.
function editConfirmPw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editConfirmPw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPassword_Callback(hObject, eventdata, handles)
% hObject    handle to editConfirmPw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editConfirmPw as text
%        str2double(get(hObject,'String')) returns contents of editConfirmPw as a double


% --- Executes during object creation, after setting all properties.
function editPassword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editConfirmPw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radioBttnMale.
function radioBttnMale_Callback(hObject, eventdata, handles)
% hObject    handle to radioBttnMale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioBttnMale
set(handles.radioBttnMale,'Value',1)
set(handles.radioBttnFemale,'Value',0)

% --- Executes on button press in radioBttnFemale.
function radioBttnFemale_Callback(hObject, eventdata, handles)
% hObject    handle to radioBttnFemale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioBttnFemale
set(handles.radioBttnFemale,'Value',1)
set(handles.radioBttnMale,'Value',0)



function editMobileNo_Callback(hObject, eventdata, handles)
% hObject    handle to editMobileNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMobileNo as text
%        str2double(get(hObject,'String')) returns contents of editMobileNo as a double


% --- Executes during object creation, after setting all properties.
function editMobileNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMobileNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(registerFig);
dashboard;
