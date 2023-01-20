### Probe-US IMAKON 0.3 ###
### sce-file ###

scenario = "imakon_0_3_real";

response_matching = simple_matching;
active_buttons = 3; 
default_background_color = 0,0,0;
default_all_responses = false;
default_formatted_text = true;

write_codes = true;
response_port_output = false;

no_logfile = true;

######################################################################

begin;

picture {} default;

picture {
	text {
		caption = "+";
		font_size = 60;
		font = "Arial";
		font_color = 210,210,210;
		background_color = 0,0,0;
	};
	x = 0;
	y = 0;
} fixpic;


### trials ###

trial {
	trial_type = first_response;
	trial_duration = forever;
	
	stimulus_event {
		nothing{};
		target_button = 1,2,3;
		response_active = true;
	};	
} waitforbuttonpress;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	LOOP
		$i 25;
		stimulus_event {
			nothing{};
			time = '$i*20';
			duration = 500;
			port = 1;
			port_code = 1;
			code_width = 5;
		};
	ENDLOOP;
} workup_shock_trial;	


trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		nothing{};
		time = 0;
		duration = 500;
		port = 1;
		port_code = 4;
		code_width = 500;
	} ;
} vibrohab_trial;

######################################################################




begin_pcl;

fixpic.present();

display_window.set_background_color(0, 0, 0); display_window.erase(); display_window.set_text_color(200, 0, 0); display_window.draw_text ("(1) Elektrischer Reiz\n\n(2) Vibrationsreiz\n\n(0) Beenden");

loop
	bool finished = false
until
	finished == true
begin
	waitforbuttonpress.present();
	if response_manager.last_response() == 1 then
		workup_shock_trial.present();
	elseif response_manager.last_response() == 2 then
		vibrohab_trial.present();
	elseif response_manager.last_response() == 3 then
		finished = true;
	end;
end;
