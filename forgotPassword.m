function varargout = forgotPassword(varargin)
% FORGOTPASSWORD MATLAB code for forgotPassword.fig
%      FORGOTPASSWORD, by itself, creates a new FORGOTPASSWORD or raises the existing
%      singleton*.
%
%      H = FORGOTPASSWORD returns the handle to a new FORGOTPASSWORD or the handle to
%      the existing singleton*.
%
%      FORGOTPASSWORD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORGOTPASSWORD.M with the given input arguments.
%
%      FORGOTPASSWORD('Property','Value',...) creates a new FORGOTPASSWORD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before forgotPassword_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to forgotPassword_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help forgotPassword

% Last Modified by GUIDE v2.5 29-May-2017 14:41:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @forgotPassword_OpeningFcn, ...
    'gui_OutputFcn',  @forgotPassword_OutputFcn, ...
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


% --- Executes just before forgotPassword is made visible.
function forgotPassword_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to forgotPassword (see VARARGIN)

% Choose default command line output for forgotPassword
% global rnd;
handles.output = hObject;
% SET = char(['a':'z' 'A':'Z' '0':'9']) ;
% NSET = length(SET) ;
%
% N = 6 ; % pick N numbers
% i = ceil(NSET*rand(1,N)) ; % with repeat
% rnd = SET(i) ;
% disp(rnd);
% set(handles.txtCaptcha,'String',rnd)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes forgotPassword wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = forgotPassword_OutputFcn(hObject, eventdata, handles)
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


% --- Executes on button press in bttnSubmit.
function bttnSubmit_Callback(hObject, eventdata, handles)
% hObject    handle to bttnSubmit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global rnd
% getRnd=(get(handles.editCaptcha,'String'));
emailto=get(handles.editEmail,'String')



% if isempty(emailto)
%     warndlg('Email required','!! Warning !!');
% elseif isempty(getRnd)
%     warndlg('Captcha required','!! Warning !!');
% else
% if(rnd==getRnd)
%
%     disp(emailto)
if isempty(emailto)
    msgbox('Please enter email id','enter email id','error');
else
    emailexp = '[a-z_0-9]+@[a-z]+\.(com|net)';
    ansr=regexp(emailto, emailexp, 'match');
    ansr2=strjoin(ansr)
    
    if(ansr2~=emailto)
        
        
        errordlg('Wrong email','Error');
        return;
        
    else
        conn=dbconnConfig();
    end
    if isconnection(conn)
        
        %             result = get(fetch(exec(conn,  ['select count(*) from signin where email_id = ' '''' emailto ''''])), 'Data')
        %             setdbprefs('DataReturnFormat','Numeric');
        %             a=cell2mat(result);
        password=get(fetch(exec(conn,  ['select password from signin where email_id = ' '''' emailto ''''])), 'Data');
        setdbprefs('DataReturnFormat','cellarray');
        password=strjoin(password);
        disp(password)
        
        %             if(a==1)
        
        try
            mail = 'iattendancesystem@yahoo.com';
            psswd = '7006077173';
            host = 'smtp.mail.yahoo.com';
            port  = '465';
            
            mailStr={'This is an automatically generated email, please do not reply.';'Please use this password to login an account: Thank you';password}
            setpref( 'Internet','E_mail', mail );
            setpref( 'Internet', 'SMTP_Server', host );
            setpref( 'Internet', 'SMTP_Username', mail );
            setpref( 'Internet', 'SMTP_Password', psswd );
            props = java.lang.System.getProperties;
            props.setProperty( 'mail.smtp.user', mail );
            props.setProperty( 'mail.smtp.host', host );
            props.setProperty( 'mail.smtp.port', port );
            props.setProperty( 'mail.smtp.starttls.enable', 'true' );
            props.setProperty( 'mail.smtp.debug', 'true' );
            props.setProperty( 'mail.smtp.auth', 'true' );
            props.setProperty( 'mail.smtp.socketFactory.port', port );
            props.setProperty( 'mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory' );
            props.setProperty( 'mail.smtp.socketFactory.fallback', 'false' );
            sendmail( emailto , 'no reply', mailStr );
            msgbox('Password has been sent in your email address','Message','help');
            
        catch
            warndlg('Error in mail system(wrong email address)','!! Warning !!');
        end
        close(forgotPassword);
        loginFig;
        
        %             else
        %                 msgbox('Invalid credentials: (Email address or Mobile Number)','Invalid email or mobile number','error');
        %             end
        
        
    else
        warndlg('Connection error(Server problem)','!! Warning !!');
    end
    
end



function editCaptcha_Callback(hObject, eventdata, handles)
% hObject    handle to editCaptcha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCaptcha as text
%        str2double(get(hObject,'String')) returns contents of editCaptcha as a double


% --- Executes during object creation, after setting all properties.
function editCaptcha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCaptcha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(forgotPassword);
loginFig;
