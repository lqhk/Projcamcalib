%%  Read original images
origimgs=cell([1,4]);
[origimgs{1},origimgs{2},origimgs{3},origimgs{4}]=load4images();
imgwidth=size(origimgs{1},2);
imgheight=size(origimgs{1},1);
for i=1:size(origimgs,2)
    if imgwidth ~= size(origimgs{i},2) && imgheight ~= size(origimgs{i},1)
        exit;
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
rawphase=atan((brtimgs{2}-brtimgs{4})./(brtimgs{3}-brtimgs{1}));
clear phasediff24 phasediff31;
