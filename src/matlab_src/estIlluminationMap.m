function map = estIlluminationMap(gain,phase,bkgbrt,cra,crb,mask)
imgwidth=size(gain,2);
imgheight=size(gain,1);
map = zeros(imgheight,imgwidth);
for rowcount=1:imgheight
    for colcount=1:imgwidth
        if isequal(mask(rowcount,colcount),255)
            map(rowcount,colcount)=estIllumination(gain(rowcount,colcount),phase(rowcount,colcount),bkgbrt(rowcount,colcount),cra,crb);
        end
    end
end
end