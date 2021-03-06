function [] = tableHandling(packet, handles)
% After creating the csv file and writing to it from serial, this function
% is called. Takes RAW CSV file and checks each row of column 3 (see mission
% guideline for future use.
% 'glider'. Determines which table to fill on GUI.


%{
Probe
---------------
1 - Team ID
2 - Mission Time
3 - Packet Count
4 - Altitude
5 - Pressure
6 - Temperature
7 - Voltage
8 - GPS Time
9 - GPS Latitude
10 - GPS Longitude
11 - GPS Altitude
12 - GPS Sats
13 - Tilt X
14 - Tilt Y
15 - Tilt Z
16 - Software State

%}

global matrix;

tele = strsplit(packet, ','); %Split the telemtry into seperate cells

sz = size(tele);

if(sz(2) ~= 17)
    totalNeeded = 17 - sz(2);
    for j=1:totalNeeded
        tele{end+j} = "-69";
    end
end


pk = str2num(tele{3}); %Get the packet count from the telemetry
sS = str2num(tele{16});
tID = str2num(tele{1});
alt = str2num(tele{4});

    

set(handles.altText,"String",alt);

update_GUIcurrentStateButton(handles, sS); %Update the current state button in GUI
 

%{
assign current telemtry to a new row of the global matrix "probe"
its done this way because in order to continually update a ui table in
matlab with new information and have all the old information you need to
add new rows to your global matrix.
%}

if(tID ~= 0)
    for i= 1:17
        try
            matrix.probe(pk, i) = str2num(tele{i}); %
        catch EX
            tele{i} = "-420";
            matrix.probe(pk,i) = str2num(tele{i});
    end

    updateGUI_probeTable(handles, matrix.probe, pk); %Update the ui Table

end



end

