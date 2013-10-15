function [img1,img2,img3,img4] = load4images(varargin)
disp(varargin);
if isequal(numel(varargin),0)
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 1');
  img1=imread(fullfile(tempImgpath,tempImgname));
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 2');
  img2=imread(fullfile(tempImgpath,tempImgname));
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 3');
  img3=imread(fullfile(tempImgpath,tempImgname));
  [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select image 4');
  img4=imread(fullfile(tempImgpath,tempImgname));
  %imgs={img1,img2,img3,img4};
elseif isequal(numel(varargin),1)
    names=varargin{1};
    if isequal(numel(names),4)
        [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select a folder by open image');
        img1=imread(fullfile(tempImgpath,names(1)));
        img2=imread(fullfile(tempImgpath,names(2)));
        img3=imread(fullfile(tempImgpath,names(3)));
        img4=imread(fullfile(tempImgpath,names(4)));
    end   
elseif isequal(numel(varargin),4)
%     names=zeros(1,4);
%     for i=numel(varargin)
%         names(i)=varargin{i};
%     end
    [tempImgname,tempImgpath] = uigetfile({'*.bmp';'*.jpg';'*.png'},'Select a folder by open image');
    img1=imread(fullfile(tempImgpath,varargin{1}));
    img2=imread(fullfile(tempImgpath,varargin{2}));
    img3=imread(fullfile(tempImgpath,varargin{3}));
    img4=imread(fullfile(tempImgpath,varargin{4}));
end
end