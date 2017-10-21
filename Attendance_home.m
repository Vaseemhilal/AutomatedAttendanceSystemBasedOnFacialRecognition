function varargout = Attendance_home(varargin)

% ATTENDANCE_HOME MATLAB code for Attendance_home.fig
%      ATTENDANCE_HOME, by itself, creates a new ATTENDANCE_HOME or raises the existing
%      singleton*.
%
%      H = ATTENDANCE_HOME returns the handle to a new ATTENDANCE_HOME or the handle to
%      the existing singleton*.
%
%      ATTENDANCE_HOME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATTENDANCE_HOME.M with the given input arguments.
%
%      ATTENDANCE_HOME('Property','Value',...) creates a new ATTENDANCE_HOME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Attendance_home_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Attendance_home_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Attendance_home

% Last Modified by GUIDE v2.5 13-Jun-2017 02:33:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Attendance_home_OpeningFcn, ...
    'gui_OutputFcn',  @Attendance_home_OutputFcn, ...
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


% --- Executes just before Attendance_home is made visible.
function Attendance_home_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Attendance_home (see VARARGIN)

% Choose default command line output for Attendance_home
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Attendance_home wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Attendance_home_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in face_rec_im_btn.
function face_recognition_using_image_btn_Callback(hObject, eventdata, handles)
% hObject    handle to face_rec_im_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global deppt;
global course;
global subject;
global sem;


deppt=get(handles.popupmnu_dept,'Value');
switch(deppt)
    case 1
       % msgbox('Please select Department','Department','error');
        deppt='Please select Department';
    case 2
        deppt='Department of Computer Science';
        
    case 3
        deppt='Department of Islamic Studies';
    otherwise
        warndlg('Select course','warning!');
end

course=get(handles.popupmnu_course,'Value');
switch(course)
    case 1
       % msgbox('Please select Course','Course','error');
        course='Please select Course';
    case 2
        course='mca';
    case 3
        course='msc-it';
    otherwise
        warndlg('Select course','warning!');
end

 
contents = cellstr(get(handles.popupmnu_sem,'String'));
index=get(handles.popupmnu_sem,'Value');
    if index==1
       %msgbox('Please select semester','Semester','error');
       sem='Please select semester';
    else
        
        sem=contents{index};
    end

contents = cellstr(get(handles.popupmnu_sub,'String'));
index=get(handles.popupmnu_sub,'Value');
    if index==1
       % msgbox('Please select subject','Select Subject','help');
        subject='Please select subject';
    else
        
        subject=contents{index};
    end    
cla(handles.axes2);
identified_person='';
trainingFeatures=[];

%course=get(handles.popupmnu_course,'Value');


if(strcmp(deppt,'Please select Department'))
              msgbox('Please select Department','Department','error');
    elseif(strcmp(course,'Please select Course'))
              msgbox('Please select Course','Course','error');
    elseif(strcmp(sem,'Please select semester'))
              msgbox('Please select semester','semester','error');
    elseif(strcmp(subject,'Please select subject'))
              msgbox('Please select subject','subject','error');
else


    cla(handles.axes2);
    identified_person='';
trainingFeatures=[];
try
    
    TrainDatabasePath = strcat('Face_database');
    db_list = dir(TrainDatabasePath);
    people = {'unknown'};
    for k = 3:size(db_list,1)
        people = union(people, {db_list(k).name});
        
    end
    
    %     disp(db_list(k).name)
    %     disp(people);
    trainingLabels=[];
    labels=[];
    [m,A,Eigenfaces,trainfilenames,File_Numbers] = CreateDatabase(TrainDatabasePath,people);
catch
    warndlg('Empty trainset','Warning');
end
% disp('Database Loaded successfully.....');
% disp(File_Numbers);
set(handles.edit2, 'String', 'Database Loaded successfully ...');
ProjectedImages = [];
Train_Number11 = size(Eigenfaces,2);

sprintf('%d',Train_Number11);
% disp('values of Train_Number11');
% disp(Train_Number11);

for k = 1 : Train_Number11
    temp = Eigenfaces'*A(:,k); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp];
    
    %     disp('------ Value of ProjectedImages-------');
    %     disp(ProjectedImages);
    
end
trainingFeatures=ProjectedImages';

% disp('--------training features---');
%     disp(trainingFeatures);

for j=1:size(trainingFeatures,1)
    trainingLabels(j,1)=0;
end
k=0;
for i=1:length(people)
    
    
    
    
    trainingLabels(k+1:k+File_Numbers(1,i),1)=i;
    %   labels(1:size(features,1))=i;
    k=k+File_Numbers(1,i);
    
    %    trainingLabels=[trainingLabels;labels];
end

% SVMModel = svmtrain(trainingFeatures,trainingLabels);

[fname,pname] = uigetfile('*.*','Select the input image file');
filename = sprintf('%s%s',pname,fname);
%              face_image(filename);
try
    inp_image=imread(filename);
catch
    msgbox('No file selected');
    return;
end
imshow(inp_image,'Parent',handles.axes11);
faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
faceDetector.MinSize = [60 60];
faceDetector.MergeThreshold = 10;
facebox = step(faceDetector,inp_image);
Nface=size(facebox,1);
% disp('size of Nfaces');
% disp(Nface);
if (Nface>0)
    longest = (facebox(1,3) * facebox(1,4));
    facebox_max = facebox(1,:);
    for n=1:Nface
        %       disp('-------------------value of n-----------------------')
        %       disp(n)
        %       disp(facebox(n,:))
        rectangle('Parent',handles.axes11,'position',facebox(n,:),'LineWidth',3,'LineStyle','-','EdgeColor','r');
        if ((facebox(n,3) * facebox(n,4) > longest))
            longest = facebox(n,3) * facebox(n,4);
            facebox_max = facebox(n,:);
            
        end
        %         end
        I = imcrop(inp_image,facebox_max);
        imshow(I,'Parent',handles.axes2);
        I = imresize(I,[300 300]);
        
        temp =rgb2gray(I);
        [irow icol] = size(temp);
        InImage = reshape(temp',irow*icol,1);
        Difference = double(InImage)-m; % Centered test image
        
        ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
        test_vector=ProjectedTestImage';
        %                 disp(test_vector);
        pred = multisvm( trainingFeatures,trainingLabels,test_vector )
        %         disp('....pred values....');
        %         disp(pred);
        %         disp('peoples');
        %         disp(people{pred});
        identified_person{n}=people{pred}
        %                  disp(identified_person{n});
        if (strcmp(identified_person{n},'unknown'))
            filename11=[TrainDatabasePath,'/','unknown/','unknown.jpg'];
            %imwrite(Face_im_org,filename11);
            set(handles.edit2, 'String', 'Face Recognition Done...');
            set(handles.edit1, 'String', identified_person{n});
            if(n<Nface)
                set(handles.edit2, 'String', 'wait fir 5 seconds to recognise next person');
                pause(5);
            end
            
        else
            
            
            set(handles.edit2, 'String', 'Face Recognition Done...');
            set(handles.edit1, 'String', identified_person{n});
            conn=dbconnConfig();
            rollno=get(handles.edit1,'String');
            if(isconnection(conn))
                
                
                %                          result = get(fetch(exec(conn,  ['select rollno from tblstudent'])), 'Data');
                %                           disp(result);
                %                           no=size(result);
                %                           disp(no);
                % %                           str='';
                %                           for i=1 : no
                %
                %
                %                                       if(strcmp(identified_person{n},result{i}))
                %                                           disp(i);
                %                                           strcat(str,result{i});
                %
                %                                       end
                %
                %
                %                           end
                %                           disp(str)
                %
                colnames={'dept','course','semester','subject','rollno','status'};
                coldata={deppt,course,sem,subject,rollno,'present'};
                insert(conn,'tblattendance',colnames,coldata);
                
                
                
                
                
            end
            
            
            if(n<Nface)
                set(handles.edit2, 'String', 'wait for 5 seconds to recognise next person');
                pause(5);
            end
            
            
        end  %END if statement strcmp() end.
    end %END FOR LOOP here
else
    disp('No Face Detected!! Try again!!');
    set(handles.edit1, 'String','none');
    set(handles.edit2, 'String', 'No Face Detected!! Try again!!');
    msgbox('No Face Detected!! Try again!!');
    
    
end
end

guidata(hObject, handles);

% --- Executes on button press in face_rec_cam_btn.
function face_recognition_using_camera_btn_Callback(hObject, eventdata, handles)
% hObject    handle to face_rec_cam_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global deppt;
global course;
global subject;
global sem;

trainingFeatures=[];
TrainDatabasePath = strcat('Face_database');
db_list = dir(TrainDatabasePath);

people = {'unknown'};
for k = 3:size(db_list)
    people = union(people, {db_list(k).name});
    disp(people);
end
TrainDatabasePath = strcat('Face_database');
trainingLabels=[];
labels=[];
[m,A,Eigenfaces,trainfilenames,File_Numbers] = CreateDatabase(TrainDatabasePath,people);
disp('Database Loaded successfully.....');
disp(File_Numbers);
set(handles.edit2, 'String', 'Database Loaded successfully.....');


ProjectedImages = [];
Train_Number11 = size(Eigenfaces,2);
for k = 1 : Train_Number11
    temp = Eigenfaces'*A(:,k); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp];
end
trainingFeatures=ProjectedImages';


for j=1:size(trainingFeatures,1)
    trainingLabels(j,1)=0;
end
k=0;
for i=1:length(people)
    
    
    
    
    trainingLabels(k+1:k+File_Numbers(1,i),1)=i;
    %   labels(1:size(features,1))=i;
    k=k+File_Numbers(1,i);
    
    %    trainingLabels=[trainingLabels;labels];
end

% SVMModel = svmtrain(trainingFeatures,trainingLabels);


% [fname,pname] = uigetfile('*.*','Select the input face image file');
%   filename = sprintf('%s%s',pname,fname);
%   I=imread(filename);
% I=detect_face_from_cam();



I= getcam();

imshow(I,'Parent',handles.axes11);
faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
faceDetector.MinSize = [60 60];
faceDetector.MergeThreshold = 10;
facebox = step(faceDetector, I);
Nface=size(facebox,1);
disp(Nface);
if (Nface>0)
    for n=1:Nface
        
        %                 figure,imshow(I); hold on
        %                 rectangle('position',facebox(1,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');
        %                     title('Face Detection')
        %                     hold off;
        Face_im=imcrop(I,facebox(n,:));
        %                 imresize(Face_im,s);
        
        %                 figure,imshow(Face_im);
        
        rectangle('Parent',handles.axes11,'position',facebox(n,:),'LineWidth',3,'LineStyle','-','EdgeColor','y');
        %                 figure,imshow(Face_im);
        imshow(Face_im,'Parent',handles.axes2);
        
        %                 I=Face_im;
        Face_im_org=Face_im;
        Face_im = imresize(Face_im,[300 300]);
        
        temp =rgb2gray(Face_im);
        [irow icol] = size(temp);
        InImage = reshape(temp',irow*icol,1);
        Difference = double(InImage)-m; % Centered test image
        
        ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
        test_vector=ProjectedTestImage';
        
        % pred = svmclassify(SVMModel,test_vector, 'Showplot',false)
        pred = multisvm( trainingFeatures,trainingLabels,test_vector )
        disp('value of pred in camera section======');
        disp(pred);
        identified_person{n}=people{pred}
        disp('peoples in camera section.........');
        disp(people{pred});
        
        disp('people after camera button...');
        
        disp(identified_person{n});
        
        if (strcmp(identified_person{n},'unknown'))
            filename11=[TrainDatabasePath,'/','unknown/','unknown.jpg'];
            imwrite(Face_im_org,filename11);
            disp('ERROR__________________');
            set(handles.edit1, 'String', identified_person{n});
            set(handles.edit2, 'String', 'Face Recognition Done...');
            
        else
            set(handles.edit1, 'String', identified_person{n});
            set(handles.edit2, 'String', 'Face Recognition Done...');
            
            % DATABASE CONNECTION....................
            
            conn=dbconnConfig();
            rollno=get(handles.edit1,'String');
            if isconnection(conn)
                %                     msgbox('Connection created successfully','DB Connection','help');
                
                colnames={'dept','course','semester','subject','rollno','status'};
                coldata={deppt,course,sem,subject,rollno,'present'};
                insert(conn,'tblattendance',colnames,coldata);
                %                   qry = sprintf(['INSERT INTO tblattendance(dept,course,semester,subject,rollno,status) VALUES(' deppt ' , ' course ',' sem ',' sub ',2,'' " present" '')']);
                %                      display(qry);
                %                    fetch(exec(conn, qry));
                
                
                %     update(conn,'user',{'username'},{'irfan'},'where user_id= ''2''');
                
            else
                % If the connection failed, print the error message
                disp(sprintf('Connection failed:&nbsp;%s', conn.Message));
            end
            % message1 = sprintf('\tFace Recognition System');
            % message2=sprintf('\n Welcome: %s',identified_person);
            if(n<Nface)
                set(handles.edit2, 'String', 'Press any key to recognise next person');
                pause();
            end
            
            
            
        end
        
    end
    
else
    disp('No Face Detected!! Try again!!');
    set(handles.edit1, 'String', 'try again...');
    set(handles.edit2, 'String', 'No Face Detected!! Try again!!');
    
    warndlg('sorry! No face Detected','warning');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmnu_dept.
function popupmnu_dept_Callback(hObject, eventdata, handles)
% hObject    handle to popupmnu_dept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmnu_dept contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmnu_dept
% global deppt;
% deppt=get(handles.popupmnu_dept,'Value');
% switch(deppt)
%     case 1
%         msgbox('Please select Department','Department','error');
%     case 2
%         deppt='Department of Computer Science';
%         
%     case 3
%         deppt='Department of Islamic Studies';
%     otherwise
%         warndlg('Select course','warning!');
% end
% dept=get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function popupmnu_dept_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmnu_dept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmnu_course.
function popupmnu_course_Callback(hObject, eventdata, handles)
% hObject    handle to popupmnu_course (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmnu_course contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmnu_course
% global course;
% course=get(handles.popupmnu_course,'Value');
% switch(course)
%     case 1
%         msgbox('Please select Course','Course','error');
%     case 2
%         course='mca';
%     case 3
%         course='msc-it';
%     otherwise
%         warndlg('Select course','warning!');
% end
% contents = cellstr(get(hObject,'String'));
% disp(contents);

% --- Executes during object creation, after setting all properties.
function popupmnu_course_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmnu_course (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmnu_sem.
function popupmnu_sem_Callback(hObject, eventdata, handles)
% hObject    handle to popupmnu_sem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmnu_sem contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmnu_sem
% global sem;
% sem=get(handles.popupmnu_sem,'Value');
% switch(sem)
%     case 1
%         msgbox('Please select semester','Semester','error');
%     case 2
%         sem='1';
%     case 3
%         sem='2';
%     case 4
%         sem='3';
%     case 5
%         sem='4';
%     case 6
%         sem='6';
%     case 7
%         sem='7';
%     case 8
%         sem='8';
%         
%     otherwise
%         warndlg('Select Semester','warning!');
% end

% --- Executes during object creation, after setting all properties.
function popupmnu_sem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmnu_sem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmnu_sub.
function popupmnu_sub_Callback(hObject, eventdata, handles)
% hObject    handle to popupmnu_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmnu_sub contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmnu_sub
% 
% global subject;
% sub=get(handles.popupmnu_sub,'Value');
% switch(sub)
%     case 1
%         msgbox('Please select subject','Select Subject','help');
%         
%     case 2
%         subject='Java';
%     case 3
%         subject='PHP';
%     case 4
%         subject='C';
%     case 5
%         subject='C++';
%     case 6
%         subject='DBMS';
%     otherwise
%         warndlg('Select subject','warning!');
% end

% --- Executes during object creation, after setting all properties.
function popupmnu_sub_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmnu_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in trainfaces.
function trainfaces_Callback(hObject, eventdata, handles)
% hObject    handle to trainfaces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_menu1;


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Attendance_home);


% --------------------------------------------------------------------
function aboutSoft_Callback(hObject, eventdata, handles)
% hObject    handle to aboutSoft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function conmenu_Callback(hObject, eventdata, handles)
% hObject    handle to conmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function viewTrain_Callback(hObject, eventdata, handles)
% hObject    handle to viewTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function viewAttend_Callback(hObject, eventdata, handles)
% hObject    handle to viewAttend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://localhost/user_section/admin/index.php','-browser');


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function trainFaces_Callback(hObject, eventdata, handles)
% hObject    handle to trainFaces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_menu1;


% --------------------------------------------------------------------
function soft_Callback(hObject, eventdata, handles)
% hObject    handle to soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d = dialog('Position',[300 300 250 150],'Name','About Dialog');

    txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[20 80 210 40],...
               'String','Built by: Waseem hilal, Adnan Ayoub and Hilal Naik');
    btn = uicontrol('Parent',d,...
               'Position',[85 20 70 25],...
               'String','Close',...
               'Callback','delete(gcf)');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Attendance_home);
loginFig;


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function helpme_Callback(hObject, eventdata, handles)
% hObject    handle to helpme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d = dialog('Position',[300 300 250 150],'Name','Help Dialog');

    txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[20 80 210 40],...
               'String','Contact administrator: waseemhilal10@gmail.com ganieadnan10@gmail.com');
    btn = uicontrol('Parent',d,...
               'Position',[85 20 70 25],...
               'String','Close',...
               'Callback','delete(gcf)');
