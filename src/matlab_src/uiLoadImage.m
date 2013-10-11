function img = uiLoadImage
[imgname,imgpath]=uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image');
img=imread(fullfile(imgpath,imgname));
end