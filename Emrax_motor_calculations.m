% x-axis is rpm, y-axis is torque
    peakPower = input('peak power of motor ');
    motorEfficiency = input('efficiency of motor ');
    maxRPM = input('max revolutions per minute of motor ');

% at 0 rpm, the engine has a stall torque
    stallT = ( peakPower * motorEfficiency * 0.00134102 ) / maxRPM * 5252; % .00134102 is the W:hp constant. 5252 is a constant in calculating torque.

% This number is now in pound*feet. Convert to Nm
    stallT = stallT * 1.3558179483314; %1.355... = constant

% Not taking into account the peak 7000rpm for a few seconds
    x = 0:5:6000;

% http://lancet.mit.edu/motors/motors3.html
    torqueMotor = stallT - (x.*stallT)./6000;

         figure(1);

        datacursormode on;

        xlabel('Rotational speed (RPM)');

        ylabel('Torque (Nm)');

        title('Torque vs. RPM using an estimated Stall Torque Value');

        plot(x,torqueMotor)
        
% Some helpful information for the graph:

% The max power is exactly half of the rotational speed, which in this

% case is also half of the torque as well. Turns out to be 3000RPM and

% 50Nm for the max power of the motor.

    computedPower = 50*3000 / 9.5488 / 1000;

    disp(['Theoretical maximum power given an arbitrary stall torque: ',num2str(computedPower)]);

    powerError = 20 - computedPower;

    disp(['Error between computed power and Emrax 208 technical data sheet: ',num2str(powerError)]);