function [outParaArray,outMaskArray,outValidCount] = prepareParaArray(inGainArray,inPhaseArray,inBkgBrtArray,inMaskArray,inBrtImgsArray)
estI=cell([1,4]);
imgsize=length(inMaskArray);
sumI=cell([1,4]);
outMaskArray=ones(imgsize,1);
outValidCount=imgsize;
for pixi=1:imgsize
    if inMaskArray(pixi)<1
        outMaskArray(pixi)=0;
        outValidCount=outValidCount-1;
    end
end
for imgi=1:length(estI)
    if isequal(imgi,4)
        estI{imgi}=inGainArray.*sin(inPhaseArray)+inBkgBrtArray;
    else
        phasediff=imgi*pi/2;
        estI{imgi}=inGainArray.*sin(inPhaseArray+phasediff)+inBkgBrtArray;
    end
    sumI{imgi}=inBrtImgsArray{imgi}-estI{imgi};
    for pixi=1:imgsize
        if isnan(sumI{imgi}(pixi)) && isequal(outMaskArray(pixi),1)
            outMaskArray(pixi)=0;
            outValidCount=outValidCount-1;
        end
    end
end
outParaArray=zeros(3*outValidCount+2,1);
vpixi=1;
for pixi=1:imgsize
    if isequal(outMaskArray(pixi),1)
        outParaArray(vpixi)=inGainArray(pixi);
        outParaArray(outValidCount+vpixi)=inPhaseArray(pixi);
        outParaArray(2*outValidCount+vpixi)=inBkgBrtArray(pixi);
        vpixi=vpixi+1;
    end
end
outParaArray(3*outValidCount+1)=1;
outParaArray(3*outValidCount+2)=1;

end