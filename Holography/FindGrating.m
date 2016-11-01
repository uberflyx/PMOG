% Loops through grating values to search for an optimal value.
% Hit CTRL+C when you see it!

min = 700;
step = 2;
max = 900;

for i = min:step:max
   i
   hologramHalfOAM(i, 45, 0.1, [0 0], [1 1],1, false, false, [20 10; -12 -10]);
   pause(0.1);
end