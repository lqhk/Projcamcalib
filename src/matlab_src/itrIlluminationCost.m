% para=gain,phase,bkgbrt,cra,crb
% brtimgsarray={brgimg1,brtimg2,brtimg3,brtimg4}
function f = itrIlluminationCost(para,mask,brtimgsarray)
global ITRCOUNT;
isdebug = 0;
imgsize=length(mask);
sumresult=0;
lastpix=0;
lastresult=0;
for pixcount=1:imgsize
    if isnan(sumresult)
        f=lastresult;
        return;
    else
        lastpix=pixcount-1;
        lastresult=sumresult;
    end
    if isequal(mask(pixcount),255) && isreal(para(pixcount)) && isreal(para(imgsize+pixcount)) && isreal(para(2*imgsize+pixcount))
        estIlls = est4Illuminations(para(pixcount),para(imgsize+pixcount),para(2*imgsize+pixcount),para(3*imgsize+1),para(3*imgsize+2));
        for phaseDiffCount=1:4
            if isnan(estIlls(phaseDiffCount))
            else
                sumresult = sumresult+realpow(brtimgsarray{phaseDiffCount}(pixcount)-estIlls(phaseDiffCount),2);
            end
        end
    end
    if isdebug
        if isequal(mod(pixcount,768),0)
            str=sprintf('pixcount is %d',pixcount);
            disp(str);
            disp(sumresult);
        end
    end
end
if isdebug
    disp(sumresult);
    disp(lastpix);
    disp(lastresult);
end
ITRCOUNT=ITRCOUNT+1;
disp(ITRCOUNT);
f=sumresult;
end