function illuminations = est4Illuminations(gain,phase,bkgbrt,cra,crb)
result1=estIllumination(gain,phase+pi/2,bkgbrt,cra,crb);
result2=estIllumination(gain,phase+pi,bkgbrt,cra,crb);
result3=estIllumination(gain,phase+1.5*pi,bkgbrt,cra,crb);
result4=estIllumination(gain,phase,bkgbrt,cra,crb);
illuminations=[result1,result2,result3,result4];
end