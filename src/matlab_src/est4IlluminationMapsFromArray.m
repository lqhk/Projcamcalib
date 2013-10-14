function f = est4IlluminationMapsFromArray(para,mask)
imgsize=length(mask);
map=cell([1,4]);
f=map;
for imgcount=1:length(map)
    map{imgcount}=zeros(imgsize,1);
end
for pixcount=1:imgsize
    if isequal(mask(pixcount),255) && isreal(para(pixcount)) && isreal(para(imgsize+pixcount)) && isreal(para(2*imgsize+pixcount))
        estIlls = est4Illuminations(para(pixcount),para(imgsize+pixcount),para(2*imgsize+pixcount),para(3*imgsize+1),para(3*imgsize+2));
        for imgcount=1:length(map)
            map{imgcount}(pixcount)=estIlls(imgcount);
        end
    end
end
for imgcount=1:length(estIlls)
    f{imgcount}=reshape(map{imgcount},768,1024);
end
end