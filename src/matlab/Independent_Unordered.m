function [ outcome ] = Independent_Unordered(length_ms, event_ms, mu_intercause_ms, alpha)
%Independent_Unordered      Generates sequences involving independent events
%   Input arguments (all durations should be given in milliseconds): 
%      [ <desired total duration>, <duration of each event>, <mu_intercause_ms = mean inter-cause delay duration>, 
%        <a constant alpha, s.t. the standard deviation of the inter-cause delay distribution is (alpha)*(mu_intercause_ms) > ]


obs_length = ms_to_frames(length_ms);   %total event-stream length
event_length = ms_to_frames(event_ms);   %event length
mu_C = ms_to_frames(mu_intercause_ms);          %inter-cause delay mean
v_C = ms_to_frames( (alpha*mu_intercause_ms)^2 );            %inter-cause delay variance

%set initial onsets for events A and B .... choose these values wisely, current values are somewhat arbitrary (selected because they generally seem to avoid excessive temporal overlaps)
onsets = [round(mu_C/2.5), mu_C];

%generate observations of A and B
outcome = zeros(2,obs_length);  %obs_length-dimensional outcome vector
for i=1:2
    event_onset=onsets(1,i);
    while event_onset<=obs_length
         event_offset=event_onset+event_length-1;
         if event_offset>obs_length, break, end;
         outcome(i,event_onset:event_offset)=i;
         delta = round(gamrnd((mu_C^2)/v_C, v_C/mu_C));
         event_onset = event_offset + delta;
    end;
end;

outcome=sum(outcome);

end