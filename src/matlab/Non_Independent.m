function [ outcome ] = Non_Independent( length_ms, event_ms, mu_intercause_ms, alpha, mu_cause_effect_ms, prob_B_A, variable_delay )
%Non_Independent    Generates sequences involving a cause and an effect
%   Input arguments (all durations should be given in milliseconds): 
%      [ <desired total duration>, <duration of each event>, <mu_intercause_ms = mean inter-cause delay duration>, 
%        <a constant alpha, s.t. the standard deviation of any given delay distribution is (alpha)*(the distribution's mean) > 
%        <mu_cause_effect_ms = mean cause_effect delay duration>, <probability of a (B,A) event order (versus an (A,B) order) > 
%        <boolean: is cause_effect delay variable (enter '1') or constant (enter '0')>]

obs_length = ms_to_frames(length_ms);       %total event-stream length
event_length = ms_to_frames(event_ms);       %event length
mu_C = ms_to_frames(mu_intercause_ms);              %inter-cause delay mean
mu_E=ms_to_frames(mu_cause_effect_ms);                 %cause-effect delay mean
v_C = ms_to_frames( (alpha*mu_intercause_ms)^2 );                  %inter-cause delay variance
v_E = ms_to_frames( (alpha*mu_cause_effect_ms)^2 );                %cause-effect delay variance


onset_C = mu_C;         %fixed initial onset for C (cause)

event_order = [1,2];    %set initial A,B event order

%generate observations of C and E (effect)
outcome = zeros(2,obs_length); %obs_length-dimensional outcome vector
while onset_C<=obs_length
     %add scheduled occurrence of C, schedule and add occurrence of E
     offset_C=onset_C+event_length-1;
     outcome(event_order(1,1),onset_C:offset_C) = event_order(1,1);
     
     %note below that the scheduled day is currently arranged such that overlaps are impossible (delay is added to offset_C, not onset_C)
     if variable_delay==1
        onset_E = offset_C + round(gamrnd((mu_E^2)/v_E, v_E/mu_E));
     else
        onset_E = offset_C + round(mu_E);
     end;
     offset_E=onset_E+event_length-1;
     if offset_E>obs_length, break, end;
     outcome(event_order(1,2),onset_E:offset_E) = event_order(1,2);
     
     %set next event order
     if rand(1)>prob_B_A, event_order=[1,2]; else event_order=[2,1]; end;
     
     %schedule next occurrence of C
     delta_C=round(gamrnd((mu_C^2)/v_C, v_C/mu_C));
     onset_C = offset_C + delta_C;
end;

outcome=sum(outcome);

end