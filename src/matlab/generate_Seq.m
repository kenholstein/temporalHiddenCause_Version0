function [ outcome ] = generate_Seq(varargin)
%generate_Seq    main function for generating temporal sequences
%
%Input arguments (all durations should be given in milliseconds): 
%
%   To generate sequences involving independent events (4 arguments):
%      [  <desired total duration>, 
%           <duration of each event (133ms corresponds to 4 frames)>, 
%           <mu_intercause_ms = mean inter-cause delay duration>, 
%           <a constant alpha, s.t. the standard deviation of the inter-cause delay distribution is (alpha)*(mu_intercause_ms) > ]
%
%   To generate sequences involving a cause and an effect (7 arguments):
%      [  <desired total duration>, 
%           <duration of each event (133ms corresponds to 4 frames)>, 
%           <mu_intercause_ms = mean inter-cause delay duration>, 
%           <a constant alpha, s.t. the standard deviation of any given delay distribution is (alpha)*(the distribution's mean) > 
%           <mu_cause_effect_ms = mean cause_effect delay duration>, 
%           <probability of a (B,A) event order (versus an (A,B) order) > 
%           <boolean: is cause_effect delay variable (enter '1') or constant (enter '0')>]

if nargin==4
    outcome = Independent_Unordered(varargin{1:4});
end
 
if nargin==7
    outcome = Non_Independent(varargin{1:7});
end


end

