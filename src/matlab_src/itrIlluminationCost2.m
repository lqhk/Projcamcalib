% para=gain,phase,bkgbrt,cra,crb
% mask is a 0 or 1 mask
% brtimgsarray={brgimg1,brtimg2,brtimg3,brtimg4}
function f = itrIlluminationCost2(para,mask,brtimgsarray)
isdebug=0;
imgsize=length(mask);
sumresult=0;
gain=para(1:imgsize);
phase=para((imgsize+1):(2*imgsize));
bkgbrt=para((2*imgsize+1):(3*imgsize));
cra=para(3*imgsize+1);
crb=para(3*imgsize+2);
estI=cell([1,4]);
sumI=cell([1,4]);
for imgi=1:length(estI)
    if isequal(imgi,4)
        estI{imgi}=realpow(sin(phase),cra);
    else
        phasediff=imgi*pi/2;
        estI{imgi}=realpow(sin(phase+phasediff),cra);
    end
    estI{imgi}=gain.*estI{imgi}+bkgbrt;
    estI{imgi}=realpow(estI{imgi},crb);
    sumI{imgi}=brtimgsarray{imgi}-estI{imgi};
end
for imgi=1:length(estI)
    for pixi=1:imgsize
        if isnan(sumI{imgi}(pixi))
            sumI{imgi}(pixi)=0;
        end
        if isequal(mask(pixi),0)
            sumI{imgi}(pixi)=0;
        end
    end
    sumI{imgi}=abs(sumI{imgi});
    sumresult=sumresult+sum(sumI{imgi});
end
disp('looped');
f=sumresult;