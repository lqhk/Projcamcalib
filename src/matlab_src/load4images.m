function [img1,img2,img3,img4] = load4images()
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 1');
  img1=imread(fullfile(tempImgpath,tempImgname));
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 2');
  img2=imread(fullfile(tempImgpath,tempImgname));
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 3');
  img3=imread(fullfile(tempImgpath,tempImgname));
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 4');
  img4=imread(fullfile(tempImgpath,tempImgname));
  %imgs={img1,img2,img3,img4};
end