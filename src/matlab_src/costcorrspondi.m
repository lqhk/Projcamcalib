function f = costcorrspondi(matx,realimg1,realimg2,realimg3,realimg4)
  if size(matx,3)~=4
      exit;
  end
  gainm=matx(:,:,1);
  thetam=matx(:,:,2);
  bkgm=matx(:,:,3);
  ta=matx(1,1,4);
  tb=matx(1,2,4);
  esti1=(gainm.*((sin(thetam+pi/2)).^ta)+bkgm).^tb;
  esti2=(gainm.*((sin(thetam+2*pi/2)).^ta)+bkgm).^tb;
  esti3=(gainm.*((sin(thetam+3*pi/2)).^ta)+bkgm).^tb;
  esti4=(gainm.*((sin(thetam)).^ta)+bkgm).^tb;
  temp1=(realimg1-esti1).^2;
  temp2=(realimg2-esti2).^2;
  temp3=(realimg3-esti3).^2;
  temp4=(realimg4-esti4).^2;
  stemp1=sum(temp1);
  stemp2=sum(temp2);
  stemp3=sum(temp3);
  stemp4=sum(temp4);
  f=sum(stemp1)+sum(stemp2)+sum(stemp3)+sum(stemp4);
end