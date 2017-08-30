function [] = ActuatorMove( handle, jogAmount)
%MOVE Move the specified actuator the specified amount.
%   handle      :   The handle of the actuator from ActuatorInit.
%   moveAmount  :   Amount to move in mm. Open loop control dictates that
%                   for safety this shouldn't be too much.

%% Controlling the Hardware
%h.MoveHome(0,0); % Home the stage. First 0 is the channel ID (channel 1)
% second 0 is to move immediately
%% Event Handling
handle.registerevent({'MoveComplete' 'MoveCompleteHandler'});

%% Sending Moving Commands
timeout = 10; % timeout for waiting the move to be completed
%h.MoveJog(0,1); % Jog

handle.SetJogStepSize(CHAN1_ID, jogAmount);


t1 = clock; % current time
while(etime(clock,t1)<timeout)
    % wait while the motor is active; timeout to avoid dead loop
    s = handle.GetStatusBits_Bits(0);
    if (IsMoving(s) == 0)
        pause(2); % pause 2 seconds;
        handle.MoveHome(0,0);
        disp('Home Started!');
        break;
    end
end

end

