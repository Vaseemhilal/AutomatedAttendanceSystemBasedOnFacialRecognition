function main_menu1()
s=[100 100];

while (1==1)
    
    choice=menu('Face Recognition System Create database ',...
        'Capture and detect face from Webcam ',...
        'Detect Face From Image ',...
        'Exit');
    
    if (choice ==1)
        
        I= getcam();
        
        if (~isempty(I))
            
            %             figure,imshow(I); Original image here
            faceDetector = vision.CascadeObjectDetector();
            faceDetector.MinSize = [60 60];
            faceDetector.MergeThreshold = 10;
            facebox = step(faceDetector, I);
            Nface=size(facebox,1);
            if (Nface>0)
                longest = (facebox(1,3) * facebox(1,4));
                facebox_max = facebox(1,:);
                for n=1:Nface
                    %rectangle('Parent',handles.axes1,'position',facebox(n,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');
                    if ((facebox(n,3) * facebox(n,4)) > longest)
                        longest = (facebox(n,3) * facebox(n,4))
                        facebox_max = facebox(n,:);
                    end
                end
                figure,imshow(I); hold on
                rectangle('position',facebox_max,'LineWidth',5,'LineStyle','-','EdgeColor','y');
                title('Face Detection')
                hold off;
                Face_im=imcrop(I,facebox_max);
                prompt1={'Enter Student Name ','Enter Roll Number for this student'};
                title1='Enter Person Name ';
                answer1=inputdlg(prompt1,title1);
                person_name = answer1{1};
                %num = answer1{2};
                rollno=answer1{2};
                rnd=randi(20,1);
                
                rnd=num2str(rnd);
                
                facefilename=['Face_database/',rollno,'/','photo',rnd,rollno,'.jpg'];
                filename1=['images/',rollno,'/','photo',rnd,rollno,'.jpg'];
                
                folder_name=['Face_database/',rollno];
                folder_name1=['images/',rollno];
                
                
                %                 imresize(Face_im,s);
                if (strcmp(rollno,'0'))
                    msgbox('Face is not detected properly','Face Detection Error','error');
                    pause(2);
                else
                    if ~exist(folder_name,'dir')
                        mkdir(folder_name);
                    end
                    
                    if ~exist(folder_name1,'dir')
                        mkdir(folder_name1);
                    end
                    conn=dbconnConfig();
                    if(isconnection(conn))
                        imwrite(Face_im,facefilename);
                        imwrite(I,filename1);
                        figure,imshow(Face_im);
                        
                        result = get(fetch(exec(conn,  ['select count(*) from tblstudent where rollno = ' '''' rollno ''''])), 'Data');
                        
                        setdbprefs('DataReturnFormat','numeric');
                        disp(result);
                        if(result>0)
                            msgbox('This RollNumber is already registered','Info','help');
                        else
                            colnames={'rollno','name'};
                            coldata={rollno,person_name};
                            insert(conn,'tblstudent',colnames,coldata);
                        end
                        
                    else
                        warndlg('Connection problem','Warning');
                        disp(sprintf('Connection failed:&nbsp;%s', conn.Message));
                    end
                end
                
                
            else
                disp('No Face Detected!! Try again!!');
                msgbox('No Face Detected!! Try again!!');
            end
            
            
        end
        
        
        
    end
    if(choice==2)
        
        %=====================================================================================
        %
        %             clear all
        %             clc
        %             close all
        
        %To detect Face
        FDetect = vision.CascadeObjectDetector;
        
%             FDetect.MinSize = [60 60];
            FDetect.MergeThreshold = 10;
        %Read the input image
        [fname,pname] = uigetfile('*.*','Select the input image file');
        filename = sprintf('%s%s',pname,fname);
        %              face_image(filename);
        disp(filename);
        I=imread(filename);
        
        
        k=1;
        BB = step(FDetect,I);
        
        
        %                      label=5;
        %                     IFaces = insertObjectAnnotation(I, 'rectangle', BB,label, ...
        %                          'Color','red', 'TextColor', 'black');
        %
        % %                 IFaces = insertObjectAnnotation(I, 'rectangle', BB, 'Face');
        %                 figure, imshow(IFaces), title('Detected faces');
        figure,
        imshow(I); hold on
        title('Face Detection');
        for i = 1:size(BB,1)
            rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','y');
        end
        
        if(size(BB,1)>0)
            %                       figure, imshow(IFaces), title('Dddetected faces');
            
            %                 figure,
            %                 imshow(I); hold on
            %                 for i = 1:size(BB,1)
            %                     rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
            %                 end
            
            
            hold on;
            for i = 1:size(BB,1)
                J= imcrop(I,BB(i,:));
                figure(3),subplot(3,3,i);imshow(J);
                title('Detection Face');
                k=k+1;
                % J=rgb2gray(J);
                I2= imresize(J, [300 300]);
                
                prompt1={'Enter Student Name ','Enter Roll Number for this student'};
                title1='Enter Person Name ';
                answer1=inputdlg(prompt1,title1);
                person_name = answer1{1};
                rollno=answer1{2};
                %num = answer1{2};
                
                rnd=randi(20,1);
                rnd=num2str(rnd);
                facefilename=['Face_database/',rollno,'/','photo',rnd,rollno,'.jpg'];
                filename1=['images/',rollno,'/','photo',rnd,rollno,'.jpg'];
                folder_name=['Face_database/',rollno];
                folder_name1=['images/',rollno];
                
                if (~isempty(I))
                    if (strcmp(rollno,'0'))
                        msgbox('Face is not detected properly','Face Detection Error','error');
                        pause(2);
                    else
                        if ~exist(folder_name,'dir')
                            mkdir(folder_name);
                        end
                        
                        if ~exist(folder_name1,'dir')
                            mkdir(folder_name1);
                        end
                        
                        conn=dbconnConfig();
                        if(isconnection(conn))
                            imwrite(I2,filename1);
                            imwrite(I2,facefilename);
                            
                            %                                         figure,imshow(I2);
                            %                                         figure,imshow(J);
                            result = get(fetch(exec(conn,  ['select count(*) from tblstudent where rollno = ' '''' rollno ''''])), 'Data');
                            
                            setdbprefs('DataReturnFormat','numeric');
                            disp(result);
                            if(result>0)
                                msgbox('This RollNumber is already registered','Info','help');
                            else
                                colnames={'rollno','name'};
                                coldata={rollno,person_name};
                                insert(conn,'tblstudent',colnames,coldata);
                            end
                        else
                            warndlg('Connection Error','Warning');
                            disp(sprintf('Connection failed:&nbsp;%s', conn.Message));
                        end
                    end
                    
                    
                end
            end
            
            
        else
            disp('No Face Detected!! Try again!!');
            msgbox('No Face Detected!! Try again!!');
        end
        
    end
    
    %--------------------------------------------------------------------------------------------------
    %                        [fname,pname] = uigetfile('*.*','Select the input face image file');
    %                         filename = sprintf('%s%s',pname,fname);
    %             %              face_image(filename);
    %                             I=imread(filename);
    %                                 figure,imshow(I);
    %                             prompt1={'Enter Student Name ','Enter Roll number for this Student'};
    %                             title1='Enter student Name ';
    %                             answer1=inputdlg(prompt1,title1);
    %                             person_name = answer1{1};
    %                             num = answer1{2};
    %                             facefilename=['Face_database/',person_name,'/',person_name,num,'.jpg'];
    %                             folder_name=['Face_database/',person_name];
    %                             folder_name1=['images/',person_name];
    %                             if ~exist(folder_name,'dir')
    %                                 mkdir(folder_name);
    %                             end
    %
    %                              if ~exist(folder_name1,'dir')
    %                                 mkdir(folder_name1);
    %                             end
    %                             filename1=['images/',person_name,'/',person_name,num,'.jpg'];
    %                         if (~isempty(I))
    %                         imwrite(I,filename1);
    %
    %                         faceDetector = vision.CascadeObjectDetector();
    %                         facebox = step(faceDetector, I);
    %                         Nface=size(facebox,1);
    %                         if (Nface>0)
    %                             longest = (facebox(1,3) * facebox(1,4));
    %                             facebox_max = facebox(1,:);
    %                             for n=1:Nface
    %                                 %rectangle('Parent',handles.axes1,'position',facebox(n,:),'LineWidth',5,'LineStyle','-','EdgeColor','b');
    %                                 if ((facebox(n,3) * facebox(n,4)) > longest)
    %                                     longest = (facebox(n,3) * facebox(n,4))
    %                                     facebox_max = facebox(n,:);
    %                                 end
    %                             end
    %                             figure,imshow(I); hold on
    %                             rectangle('position',facebox_max,'LineWidth',5,'LineStyle','-','EdgeColor','y');
    %                                 title('Face Detection')
    %                                 hold off;
    %                             Face_im=imcrop(I,facebox_max);
    %                             imwrite(Face_im,facefilename);
    %                             figure,imshow(Face_im);
    
   
    
    
    if (choice == 3)
        
        clc;
        %         close('main_menu1');
        clear choice
        %
        %
        return;
        %
    end
    
    
    
end

end
