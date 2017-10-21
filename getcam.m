
function I = getcam()
% vid=videoinput('demo',1,'YUY2_640x480'); %video object configuration. % laptop
vid=videoinput('winvideo',1,'YUY2_640x480'); %video object configuration. % laptop
% vid=videoinput('winvideo',1,'YUY2_640x480'); %video object configuration. % laptop
set(vid,'ReturnedColorSpace','rgb');
% vid = videoinput('winvideo', 1, 'RGB24_320x240');%desktop
preview(vid);
choice=menu('Capture Frame',...
            '   Capture   ',...
            '     Exit    ');
          
I = [];
if (choice == 1)  
            
    I = getsnapshot(vid);    
            
 
    
   
end
closepreview(vid);