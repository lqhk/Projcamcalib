function f = estIlluminationFromArray(para,mask)
imgsize=length(mask);
map=zeros(imgsize,1);
for pixcount=1:imgsize
    if isequal(mask(pixcount),255) && isreal(para(pixcount)) && isreal(para(imgsize+pixcount)) && isreal(para(2*imgsize+pixcount))
        estIlls = est4Illuminations(para(pixcount),para(imgsize+pixcount),para(2*imgsize+pixcount),para(3*imgsize+1),para(3*imgsize+2));
        map(pixcount)=estIlls(1);
    end
end
f=reshape(map,768,1024);
end