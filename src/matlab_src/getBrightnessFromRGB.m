function brightness = getBrightnessFromRGB(rgbimg)
  hsvimg=rgb2hsv(rgbimg);
  brightness=hsvimg(:,:,3);
end