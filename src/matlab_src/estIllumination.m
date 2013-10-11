function illumination = estIllumination(gain,phase,bkgbrt,cra,crb)
    illumination=realpow(gain * realpow(sin(phase),cra) + bkgbrt,crb);
end