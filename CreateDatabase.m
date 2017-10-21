function [m,A,Eigenfaces,trainfilenames,File_Numbers]=CreateDatabase(TrainDatabasePath,people)

% Align a set of face images (the training set T1, T2, ... , TM )
%
%
File_Numbers=[];
index=0;              

%%%%%%%%%%%%%%%%%%%%%%%% File management
% TrainFiles = dir(TrainDatabasePath);
 T=[];

for t=1:length(people)

    str = strcat(people{t});
    Folder = strcat(TrainDatabasePath,'\',str,'\');
    File=dir(Folder);

    

 Train_Number = 0;
 for i = 1:size(File,1)
%         disp('=======================');
%         disp({File(i).name,'..'});
      if not(strcmp(File(i).name,'.')|strcmp(File(i).name,'..')|strcmp(File(i).name,'Thumbs.db')) %try uniquely
          Train_Number = Train_Number + 1; % Number of all images in the training database
      end
  end
 File_Numbers(1,t)=Train_Number;

 %%%%%%%%%%%%%%%%%%%%%%%% Construction of 2D matrix from 1D image vectors
for j=1:Train_Number
 filename = sprintf('%s%s',Folder,File(j+2).name);
 fname=File(j+2).name;
 index=index+1;
    trainfilenames{index}=filename;
    img = imread(filename);
    
     img = rgb2gray(img);
     img = imresize(img,[300 300]);
    
    [irow icol] = size(img);
   
    temp = reshape(img',irow*icol,1);   % Reshaping 2D images into 1D image vectors
    T = [T temp]; % 'T' grows after each turn                    
end
end


[m,A,Eigenfaces] = EigenfaceCore(T);

