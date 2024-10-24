% Real time plotting.

clear all
close all
clc

% Update to the correct port
arduino = serial('/dev/tty.usbserial-10', 'BaudRate', 9600); % Use the correct port here
fopen(arduino); % Initiate Arduino communication

CM(1) = 0; % Initialize distance variable
time(1) = 0; % Initialize time variable
i = 1; % Initialize index for plotting
tic; % Start timer

while (toc <= 100) % Loop for 100 seconds
    % Read a line from Arduino
    data = fgets(arduino); % Read the line from the serial port
    CM(2) = str2double(data); % Convert the string to a double
    
    % Check if the conversion was successful
    if isnan(CM(2))
        disp('Warning: Unable to convert data to number');
        CM(2) = 0; % Default value in case of error
    end
    
    time(2) = toc; % Get elapsed time
    figure(1);
    grid on;
    axis([toc - 10, toc + 10, 0, 35]); % Set axis limits
    h(i) = plot(time, CM, 'b', 'LineWidth', 1); % Plot the distance with thin lines
    hold on
    CM(1) = CM(2); % Update previous distance
    time(1) = time(2); % Update previous time
    if (i >= 300) % Limit number of lines on the plot
        delete(h(i - 299)); % Delete the oldest line
    end
    i = i + 1; % Increment index
end

fclose(arduino); % End communication with Arduino
