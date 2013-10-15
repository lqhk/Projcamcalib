%%  Read original images
origimgs=cell([1,4]);
%[origimgs{1},origimgs{2},origimgs{3},origimgs{4}]=load4images();
[origimgs{1},origimgs{2},origimgs{3},origimgs{4}]=load4images('images0019.bmp','images0020.bmp','images0021.bmp','images0018.bmp');
imgwidth=size(origimgs{1},2);
imgheight=size(origimgs{1},1);
for i=1:size(origimgs,2)
    if imgwidth ~= size(origimgs{i},2) || imgheight ~= size(origimgs{i},1)
        disp('The width or the height of images are not equal!');
        return;
    end
end

 %% Convert to gain, phase and bkgbrt(background brightness)
 disp('Converting RGB files to brightness images');
brtimgs=cell([1,size(origimgs,2)]);
for i=1:size(origimgs,2)
    if isequal(size(origimgs{i},3),3)
        brtimgs{i}=getBrightnessFromRGB(origimgs{i});
    elseif isequal(size(origimgs{i},3),1)
        brtimgs{i}=origimgs{i};
    end
end
clear origimgs;

disp('Computing gain, phase and bkgbrt');
phasediff24=brtimgs{2}-brtimgs{4};
phasediff31=brtimgs{3}-brtimgs{1};
rawbkgbrt=(brtimgs{1}+brtimgs{2}+brtimgs{3}+brtimgs{4})./4;
rawgain=2.*realsqrt(realpow(phasediff24,2)+realpow(phasediff31,2))./(brtimgs{1}+brtimgs{2}+brtimgs{3}+brtimgs{4});
rawphase=atan(phasediff24./phasediff31);
clear phasediff24 phasediff31;

%% Estimate
disp('Loading mask image');
maskimg=uiLoadImage();
if imgwidth ~= size(maskimg,2) || imgheight ~= size(maskimg,1)
    disp('The width or the height of mask is not equal those of images!');
    return;
end
if size(maskimg,3)~=1
    disp('Mask is a multi-channel image, use only the first channel.');
    maskimg = maskimg(:,:,1);
end

%% Prepare array
maskarray=reshape(maskimg,numel(maskimg),1);
%initpara=[reshape(rawgain,imgwidth*imgheight,1);reshape(rawphase,imgwidth*imgheight,1);reshape(rawbkgbrt,imgwidth*imgheight,1);1;1];
rawgainarray=reshape(rawgain,imgwidth*imgheight,1);
rawphasearray=reshape(rawphase,imgwidth*imgheight,1);
rawbkgbrtarray=reshape(rawbkgbrt,imgwidth*imgheight,1);
brtimgsarray = cell([1,4]);
for imgcount=1:4
    brtimgsarray{imgcount}=reshape(brtimgs{imgcount},imgwidth*imgheight,1);
end
[initpara,initmaskarray,validPixel]=prepareParaArray(rawgainarray,rawphasearray,rawbkgbrtarray,maskarray,brtimgsarray);
fn=@(p)itrIlluminationCost(p,maskarray,brtimgsarray);
options=optimset('Display','iter','MaxIter',2);
%[para,fval]=fminunc(fn,initpara,options);