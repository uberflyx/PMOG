function [ handle ] = ActuatorInit( actuatorName, serialNumber )
%ACTUATORINIT Initialise the specified controller and return the handle.
%   Download the Thorlabs APT software to get the ActiveX control that is used:
%   https://www.thorlabs.com/software_pages/viewsoftwarepage.cfm?code=Motion_Control
%   Tutorial: http://www.thorlabs.com/tutorials/Thorlabs_APT_MATLAB.docx
%
%   actuatorName    :   A friendly name for this actuator (like it's axis)
%   serialNumber    :   The controller serial number (to identify which)

%% Create Matlab Figure Container
fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 650; % figure window size;Width
fpos(4) = 450; % Height

f = figure('Position', fpos,...
    'Menu','None',...
    'Name',[actuatorName, ' (Actuator GUI)']);

%% Create ActiveX Controller
handle = actxcontrol('MGPIEZO.MGPiezoCtrl.1',[20 20 600 400 ], f);

%% Initialize
% Set the Serial Number
%SN = 45822682; % put in the serial number of the hardware
set(handle,'HWSerialNum', serialNumber);

% Start Control
handle.StartCtrl;

%handle.SetVoltOutput(CHAN1_ID, 75);

%Maybe set serial number here...

% Indentify the device
handle.Identify;

pause(5); % waiting for the GUI to load up;

end

