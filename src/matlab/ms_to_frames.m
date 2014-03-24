function [ num_frames ] = ms_to_frames( num_ms )
%ms_to_frames converts values given in milliseconds
%to (numerically-rounded) values in terms of # of frames
%for a given frame rate (fps)

fps = 30.0; %frames per second

fpms = fps/1000; %frames per millisecond
num_frames = round(fpms*num_ms);

end

