function varargout = Face_recognition_SVM(varargin)
% FACE_RECOGNITION_SVM MATLAB code for Face_recognition_SVM.fig
%    

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Face_recognition_SVM_OpeningFcn, ...
                   'gui_OutputFcn',  @Face_recognition_SVM_OutputFcn, ...
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


% --- Executes just before Face_recognition_SVM is made visible.
function Face_recognition_SVM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Face_recognition_SVM (see VARARGIN)
clc;
% Choose default command line output for Face_recognition_SVM
handles.output = hObject;

img=imread('3.jpg');
imshow(img,'Parent',handles.axes1); 
img=imread('Capture.jpg');
imshow(img,'Parent',handles.axes2); 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Face_recognition_SVM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Face_recognition_SVM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% % --- Executes on button press in database_btn.
% function database_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to database_btn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% main_menu1();
% guidata(hObject, handles);
% 
% % --- Executes on button press in face_rec_im_btn.
% function face_rec_im_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to face_rec_im_btn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% cla(handles.axes2)
% identified_person='';
% trainingFeatures=[];
% 
% TrainDatabasePath = strcat('Face_database');
% db_list = dir(TrainDatabasePath);
% people = {'unknown'};
% for k = 3:size(db_list,1)
%     people = union(people, {db_list(k).name});
%     
% end
% disp(people);
% trainingLabels=[]; 
% labels=[];
% [m,A,Eigenfaces,trainfilenames,File_Numbers] = CreateDatabase(TrainDatabasePath,people);
% disp('Database Loaded successfully.....');
% disp(File_Numbers);
% set(handles.edit2, 'String', 'Database Loaded successfully ...');
% ProjectedImages = []; 
% Train_Number11 = size(Eigenfaces,2);
% 
% sprintf('%d',Train_Number11);
% disp('values of Train_Number11');
% disp(Train_Number11);
% 
% for k = 1 : Train_Number11
%     temp = Eigenfaces'*A(:,k); % Projection of centered images into facespace
%     ProjectedImages = [ProjectedImages temp]; 
%     
% %     disp('------ Value of ProjectedImages-------');
% %     disp(ProjectedImages);
%     
% end
% trainingFeatures=ProjectedImages';
% 
% % disp('--------training features---');
% %     disp(trainingFeatures);
% 
% for j=1:size(trainingFeatures,1)
%    trainingLabels(j,1)=0;
% end
%     k=0; 
% for i=1:length(people)
%    
% 
% 
%    
%    trainingLabels(k+1:k+File_Numbers(1,i),1)=i;
% %   labels(1:size(features,1))=i;
%    k=k+File_Numbers(1,i);
%    
% %    trainingLabels=[trainingLabels;labels];
% end
% 
% % SVMModel = svmtrain(trainingFeatures,trainingLabels);
% 
% [fname,pname] = uigetfile('*.*','Select the input image file');
%             filename = sprintf('%s%s',pname,fname); 
% %              face_image(filename);
%                 inp_image=imread(filename);
%                       imshow(inp_image,'Parent',handles.axes11);           
%                  faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
%                   facebox = step(faceDetector,inp_image);
%                  Nface=size(facebox,1);
%                  disp('size of Nfaces');
%                  disp(Nface);
%     if (Nface>0)
%         longest = (facebox(1,3) * facebox(1,4));
%         facebox_max = facebox(1,:);
%         for n=1:Nface
%             disp(n)
%             disp(facebox(n,:))
%             rectangle('Parent',handles.axes11,'position',facebox(n,:),'LineWidth',3,'LineStyle','-','EdgeColor','r'); 
%                     if ((facebox(n,3) * facebox(n,4) > longest))
%                         longest = facebox(n,3) * facebox(n,4)
%                         facebox_max = facebox(n,:);
% 
%                     end
% %         end
%                 I = imcrop(inp_image,facebox_max);
%                 imshow(I,'Parent',handles.axes2);
%                 I = imresize(I,[100 100]);
% 
%                 temp =rgb2gray(I);
%                 [irow icol] = size(temp);
%                 InImage = reshape(temp',irow*icol,1);
%                 Difference = double(InImage)-m; % Centered test image
% 
%                 ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
%                 test_vector=ProjectedTestImage';
%                  pred = multisvm( trainingFeatures,trainingLabels,test_vector );
%                     disp('....pred values....');
%                     disp(pred);
%                     disp('peoples');
%                     disp(people{pred});
%                  identified_person{n}=people{pred}
%                  disp(identified_person{n});
%                   if (strcmp(identified_person{n},'unknown'))
%                      filename11=[TrainDatabasePath,'/','unknown/','unknown.jpg'];
%                      %imwrite(Face_im_org,filename11);
% 
%                  end
%                  set(handles.edit1, 'String', identified_person{n});
%     %              TestImage = strcat(n,'\',pred,'.jpg');
%     %              disp(TestImage);   
%     %              imshow(TestImage);
% 
%                   set(handles.edit2, 'String', 'Face Recognition Done...');
%                 %         message1 = sprintf('\tFace Recognition System');
%                 %         message2=sprintf('\n Welcome: %s',identified_person);
%                         if(n<Nface)
%                              set(handles.edit2, 'String', 'Press any key to recognise next person');
%                          pause();
%                         end
%                 %  message=sprintf('%s%s',message1,message2);
%                 % h=msgbox(message);
%          end
%    else
%                 disp('No Face Detected!! Try again!!');
%                   set(handles.edit1, 'String','none');
%                  set(handles.edit2, 'String', 'No Face Detected!! Try again!!');
%                      msgbox('No Face Detected!! Try again!!');
%    end
%             
% 
% 
% guidata(hObject, handles);
% 
% % --- Executes on button press in face_rec_cam_btn.
% function face_rec_cam_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to face_rec_cam_btn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% trainingFeatures=[];
% TrainDatabasePath = strcat('Face_database');
% db_list = dir(TrainDatabasePath);
% 
% people = {'unknown'};
% for k = 3:size(db_list,1)
%     people = union(people, {db_list(k).name});
%     disp(people);
% end
% TrainDatabasePath = strcat('Face_database');
% trainingLabels=[]; 
% labels=[];
% [m,A,Eigenfaces,trainfilenames,File_Numbers] = CreateDatabase(TrainDatabasePath,people);
% disp('Database Loaded successfully.....');
% disp(File_Numbers);
% set(handles.edit2, 'String', 'Database Loaded successfully.....');
% 
% 
% ProjectedImages = [];
% Train_Number11 = size(Eigenfaces,2);
% for k = 1 : Train_Number11
%     temp = Eigenfaces'*A(:,k); % Projection of centered images into facespace
%     ProjectedImages = [ProjectedImages temp]; 
% end
% trainingFeatures=ProjectedImages';
%    
% 
% for j=1:size(trainingFeatures,1)
%    trainingLabels(j,1)=0;
% end
%     k=0; 
% for i=1:length(people)
%    
% 
% 
%    
%    trainingLabels(k+1:k+File_Numbers(1,i),1)=i;
% %   labels(1:size(features,1))=i;
%    k=k+File_Numbers(1,i);
%    
% %    trainingLabels=[trainingLabels;labels];
% end
% 
% % SVMModel = svmtrain(trainingFeatures,trainingLabels);
% 
% 
% % [fname,pname] = uigetfile('*.*','Select the input face image file');
% %   filename = sprintf('%s%s',pname,fname);
% %   I=imread(filename);
% % I=detect_face_from_cam();
% 
% 
% 
% I= getcam();
% 
%  imshow(I,'Parent',handles.axes11);
% faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
%             facebox = step(faceDetector, I);
%             Nface=size(facebox,1);
%             disp(Nface);
%             if (Nface>0)
%                 for n=1:Nface
%                
% %                 figure,imshow(I); hold on
% %                 rectangle('position',facebox(1,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');              
% %                     title('Face Detection')
% %                     hold off;        
%                 Face_im=imcrop(I,facebox(n,:));
% %                 imresize(Face_im,s);
%               
% %                 figure,imshow(Face_im); 
% 
%    rectangle('Parent',handles.axes11,'position',facebox(n,:),'LineWidth',3,'LineStyle','-','EdgeColor','y');   
% %                 figure,imshow(Face_im);  
%                 imshow(Face_im,'Parent',handles.axes2);
%                 
% %                 I=Face_im;
%                 Face_im_org=Face_im;
%                 Face_im = imresize(Face_im,[100 100]);
%   
% temp =rgb2gray(Face_im);
% [irow icol] = size(temp);
% InImage = reshape(temp',irow*icol,1);
% Difference = double(InImage)-m; % Centered test image
% 
% ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
% test_vector=ProjectedTestImage';
% 
% % pred = svmclassify(SVMModel,test_vector, 'Showplot',false)
%  pred = multisvm( trainingFeatures,trainingLabels,test_vector )
%    disp('value of pred in camera section======'); 
% disp(pred);
%  identified_person{n}=people{pred};
%   disp('peoples in camera section.........');
%     disp(people{pred});
%     
%  disp('people after camera button...');
%  
%  disp(identified_person{n});
%  
%  if (strcmp(identified_person{n},'unknown'))
%      filename11=[TrainDatabasePath,'/','unknown/','unknown.jpg'];
%      imwrite(Face_im_org,filename11);
%      disp('ERROR__________________');
%  end
%  set(handles.edit1, 'String', identified_person{n});
%   set(handles.edit2, 'String', 'Face Recognition Done...');
%   % message1 = sprintf('\tFace Recognition System');
%    % message2=sprintf('\n Welcome: %s',identified_person);
%         if(n<Nface)
%              set(handles.edit2, 'String', 'Press any key to recognise next person');
%          pause();
%         end
%         
% %  message=sprintf('%s',message1);
% %  h=msgbox(message);
%             end
%                  
%             else
%                 disp('No Face Detected!! Try again!!');
%                 set(handles.edit1, 'String', 'try again...');
%                 set(handles.edit2, 'String', 'No Face Detected!! Try again!!');
%                 
%                  warndlg('sorry! No face Detected','warning');
%             end
% 
% 
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
%   
% 
% 
% 
% 
% 
% 
% guidata(hObject, handles);


% function edit1_Callback(hObject, eventdata, handles)
% % hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% % --- Executes during object creation, after setting all properties.
% function edit1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% function edit2_Callback(hObject, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit2 as text
% %        str2double(get(hObject,'String')) returns contents of edit2 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit2_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
% 
% 
% 
% 

% --------------------------------------------------------------------
function account_Callback(hObject, eventdata, handles)
% hObject    handle to account (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function login_Callback(hObject, eventdata, handles)
% hObject    handle to login (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loginFig();


% --------------------------------------------------------------------
function signin_Callback(hObject, eventdata, handles)
% hObject    handle to signin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
registerFig();


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('I am About','About us','help');


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     prompt='Do you want exit Y/N [Y]:';
%     str=input(prompt,'s');
%     if(strcmp(str,'Y'|'y'))
%         close;
%     else
%         msgbox('noo','help','help');
%     end    
close;



% --------------------------------------------------------------------
function attendance_Callback(hObject, eventdata, handles)
% hObject    handle to attendance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  


% --------------------------------------------------------------------
function add_student_Callback(hObject, eventdata, handles)
% hObject    handle to add_student (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 h = waitbar(0,'Please wait...');
    steps = 1000;
        for step = 1:steps
            % computations take place here
            waitbar(step / steps)
        end
        close(h) 
        main_menu1();
        
        guidata(hObject, handles);
    

% --------------------------------------------------------------------
function start_attendance_Callback(hObject, eventdata, handles)
% hObject    handle to start_attendance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 h = waitbar(0,'Please wait...');
    steps = 500;
        for step = 1:steps
            % computations take place here
            waitbar(step / steps)
        end
%         hh=helpdlg('Thank you for waiting','waiting');
%         close(hh);
    close(h) 
    Attendance_home();
 guidata(hObject, handles);
    
% --------------------------------------------------------------------
function view_attendance_Callback(hObject, eventdata, handles)
% hObject    handle to view_attendance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     web('http://localhost/matlab/menu.php');
