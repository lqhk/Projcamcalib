% para=gain,phase,bkgbrt,cra,crb
% brtimgsarray={brgimg1,brtimg2,brtimg3,brtimg4}
function f = itrIlluminationCost(para,mask,brtimgsarray)
imgsize=length(mask);
sumresult=0;
lastpix=0;
lastresult=0;
for pixcount=1:imgsize
    if isnan(sumresult)
    else
        lastpix=pixcount-1;
        lastresult=sumresult;
    end
    if isequal(mask(pixcount),255) && isreal(para(pixcount)) && isreal(para(imgsize+pixcount)) && isreal(para(2*imgsize+pixcount))
        estIlls = est4Illuminations(para(pixcount),para(imgsize+pixcount),para(2*imgsize+pixcount),para(3*imgsize+1),para(3*imgsize+2));
        for phaseDiffCount=1:4
            sumresult = sumresult+realpow(brtimgsarray{phaseDiffCount}(pixcount)-estIlls(phaseDiffCount),2);
        end
    end
    if isequal(mod(pixcount,768),0)
        str=sprintf('pixcount is %d',pixcount);
        disp(str);
        disp(sumresult);
    end
end
disp(sumresult);
disp(lastpix);
disp(lastresult);
f=sumresult;
end