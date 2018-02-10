sl_lanechange

% we can't push the simulate button on the Simulink model from this script so we simulate it
out = sim('sl_lanechange') 

clf
plot(q(:,1), q(:,2))