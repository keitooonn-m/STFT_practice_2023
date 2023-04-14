time = 10;
samplefs = 44100;
fs = 440;
t = linspace(0,10,time * samplefs);
omega = 2 * pi * fs;
y = sin(omega * t);
plot(t,y);