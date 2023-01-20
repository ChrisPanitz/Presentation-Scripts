### IMAKON 0.3 ###
### sce-file ###

scenario = "imakon_ima_0_3";

pcl_file = "imakon_0_3_ima_PCL.pcl";
#pcl_file = "sandbox.pcl";

response_matching = simple_matching;
response_logging = log_active;
response_port_output = false;
active_buttons = 15; 
default_background_color = 0,0,0;
default_all_responses = false;
default_formatted_text = true;

button_codes = 10,11,12,13,14,15,16,17,18,19,20,21,0,0,22;
# d.h., wann immer eine IRGENDEINE falsche Taste gedrückt wurde (auch bei ungeforderten Reaktionen) 


target_button_codes = 10,11,12,13,14,15,16,17,18,19,20,21,0,0,22;
# d.h., wann immer eine richtige Taste gedrückt wurde

default_output_port = 1; # port mit responsebox ist default
write_codes = true; 	# Statement notwendig für output Device Geschichten
			    
pulse_width = 3;
######################################################################

begin;

picture {} default;

### geometric forms ###

array {
	polygon_graphic {
		sides = 4;
		radius = 200;
		rotation = 45;
		line_width = 1;
		line_color = 255,0,0;
		fill_color = 255,0,0;
	} geom_square;
	polygon_graphic {
		sides = 128;
		radius = 200;
		line_width = 1;
		line_color = 0,255,0;
		fill_color = 0,255,0;
	} geom_circle;
	polygon_graphic {
		sides = 3;
		radius = 200;
		rotation = 180;
		line_width = 1;
		line_color = 0,0,255;
		fill_color = 0,0,255;
	} geom_triangle;
} geom_array;
/*
ellipse_graphic {
	ellipse_width = 200;
	ellipse_height = 100;
	color = 0,0,255;
} geom_ellipse;
*/

### instructions ###

#start habituation
text {
	caption = "Ihnen werden nun nacheinander verschiedene Gesichter gezeigt.\n\nBitte verfolgen Sie diese aufmerksam.\n\nSollten Sie noch Fragen haben, können Sie diese nun der Versuchsleiterin bzw. dem Versuchsleiter stellen.\n\n\n\nBitte starten Sie die Darbietung durch Drücken der mittleren Taste.";
	font_size = 48;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} instruct_text;

picture {
	text instruct_text;
	x = 0; y = 0;
	
	#polygon_graphic geom_square;
	#x = 0; y = -200;
} instruct_pic;

trial {
	trial_type = specific_response;
	terminator_button = 12;
	trial_duration = forever;
	all_responses = true;
		picture instruct_pic;
		time = 0;
} instruct_trial;


text {
	caption = "Bitte warten Sie auf die Versuchsleiterin bzw. den Versuchsleiter.";
	font_size = 48;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} pleasewait_text;

picture {
	text pleasewait_text;
	x = 0; y = 0;
} pleasewait_pic;

trial {
	trial_type = first_response;
	all_responses = true;
	#terminator_button = 13,14;
	trial_duration = forever;
	
	picture pleasewait_pic;
} wait_for_experimenter;


trial {
	trial_type = first_response;
	trial_duration = forever;
	
	stimulus_event {
		nothing{};
		target_button = 1;
		response_active = true;
	};	
} waitforbuttonpress;



### faces ###

array {
	bitmap {filename = "face_a.bmp";} bmp_a;
	bitmap {filename = "face_b.bmp";} bmp_b;
	bitmap {filename = "face_c.bmp";} bmp_c;
} bmp_array;

array {
	picture {
		bitmap bmp_a;
		x = 0;
		y = 0;
	} face_a;

	picture {
		bitmap bmp_b;
		x = 0;
		y = 0;
	} face_b;
	
	picture {
		bitmap bmp_c;
		x = 0;
		y = 0;
	} face_c;	
} face_array;


### cues ###

array {
	picture {
		bitmap bmp_a;
		x = 0;
		y = 0;
		
		polygon_graphic geom_square;
		center_x = 0;
		center_y = 0;
	} cue_plus_av;
	picture {
		bitmap bmp_b;
		x = 0;
		y = 0;
		
		polygon_graphic geom_circle;
		center_x = 0;
		center_y = 0;
	} cue_plus_neu;
	picture {
		bitmap bmp_c;
		x = 0;
		y = 0;
		
		polygon_graphic geom_triangle;
		center_x = 0;
		center_y = 0;
	} cue_minus;
} cue_array;

array {
	picture{
		polygon_graphic geom_square;
		x = 0;
		y = 0;
	} square_pic;
	picture{
		polygon_graphic geom_circle;
		x = 0;
		y = 0;
	} circle_pic;
	picture{
		polygon_graphic geom_triangle;
		x = 0;
		y = 0;
	} triangle_pic;
} geompic_array;
### Audio ###

#array {
#	sound {
#		wavefile {filename = "tone_a.wav";} wav_a;
#	} tone_a;
#	
#	sound {
#		wavefile {filename = "tone_b.wav";} wav_b;
#	} tone_b;
#} tone_array;

sound {
	wavefile {filename = "startle.wav";} wav_startle;
} startle;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		sound startle;
		time = 0;
		code = "startle_hab";
		port = 1;
		port_code = 0;
	} startlehab_event;
} startlehab_trial;



array {
	sound {
		wavefile {filename = "ima_square_av.wav";} wav_square_av;
	} sound_square_av;
	sound {
		wavefile {filename = "ima_circle_av.wav";} wav_circle_av;
	} sound_circle_av;
	sound {
		wavefile {filename = "ima_triangle_av.wav";} wav_triangle_av;
	} sound_triangle_av;
} ima_av_sound_array;

array {
	sound {
		wavefile {filename = "ima_square_neu.wav";} wav_square_neu;
	} sound_square_neu;
	sound {
		wavefile {filename = "ima_circle_neu.wav";} wav_circle_neu;
	} sound_circle_neu;
	sound {
		wavefile {filename = "ima_triangle_neu.wav";} wav_triangle_neu;
	} sound_triangle_neu;
} ima_neu_sound_array;

array {
	sound {
		wavefile {filename = "ima_square_minus.wav";} wav_square_minus;
	} sound_square_minus;
	sound {
		wavefile {filename = "ima_circle_minus.wav";} wav_circle_minus;
	} sound_circle_minus;
	sound {
		wavefile {filename = "ima_triangle_minus.wav";} wav_triangle_minus;
	} sound_triangle_minus;
} ima_minus_sound_array;


sound {
	wavefile {filename = "signal.wav";} wav_signal;
} signal_sound;

#sound {
#		wavefile wav_square_av; # changes in pcl
#} ima_av_sound;
#
#sound {
#	wavefile wav_circle_neu; # changes in pcl
#} ima_neu_sound;
#
#sound {
#	wavefile wav_triangle_minus; # changes in pcl
#} ima_minus_sound;


### ISI ###

text {
	caption = "+";
	font_size = 60;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} fixtext;


picture {
	text fixtext;
	x = 0; y = 0;
} fixpic;



### trials ###

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture fixpic;
		time = 0;
		duration = 1000;
		code = "waiting";
	} waiting_event;
} waiting_trial;
	
trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture {};
		time = 0;
		duration = 1; # changes in pcl
		code = "cs_plus_av";
		port_code = 0; # changes in pcl
		port = 1;
	} cs_plus_av_event;
	
	stimulus_event {
		nothing {};
		time = 0; # changes in pcl
		duration = 1; # changes in pcl
		code = ""; # changes in pcl
		port = 1;
	} cue_plus_av_event;
/*
	stimulus_event {
		#sound startle;
		nothing {};
		time = 100; # changes in pcl
		duration = 100; # changes in pcl
		code = "startle"; # changes in pcl
		port = 1;
		#parallel = true;
	} startle_plus_av_event;
*/	
	stimulus_event {
		picture fixpic;
		time = 1; # changes in pcl
		duration = 1000; # changes in pcl
		code = "isi";
	} isi_plus_av_event;
} cs_plus_av_trial;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture {};
		time = 0;
		duration = 1; # changes in pcl
		code = "cs_plus_neu";
		port_code = 0; # changes in pcl
		port = 1;
	} cs_plus_neu_event;
	
	stimulus_event {
		nothing {};
		time = 0; # changes in pcl
		duration = 1; # changes in pcl
		code = ""; # changes in pcl
		port = 1;
	} cue_plus_neu_event;
/*
	stimulus_event {
		#sound startle;
		nothing {};
		time = 100; # changes in pcl
		duration = 100; # changes in pcl
		code = "startle"; # changes in pcl
		port = 1;
		#parallel = true;
	} startle_plus_neu_event;
*/
	stimulus_event {
		picture fixpic;
		time = 1; # changes in pcl
		duration = 1000; # changes in pcl
		code = "isi";
	} isi_plus_neu_event;
} cs_plus_neu_trial;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture {};
		time = 0;
		duration = 1; # changes in pcl
		code = "cs_minus";
		port_code = 0; # changes in pcl
		port = 1;
	} cs_minus_event;
	
	stimulus_event {
		nothing {};
		time = 0; # changes in pcl
		duration = 1; # changes in pcl
		code = ""; # changes in pcl
		port = 1;
	} cue_minus_event;
/*
	stimulus_event {
		#sound startle;#
		nothing {}; # changes in pcl
		time = 100; # changes in pcl
		duration = 100; # changes in pcl
		code = "startle"; # changes in pcl
		port = 1;
		#parallel = true;
	} startle_minus_event;
*/
	stimulus_event {
		picture fixpic;
		time = 1; # changes in pcl
		duration = 1000; # changes in pcl
		code = "isi";
	} isi_minus_event;
} cs_minus_trial;

nothing {} nothing_stim;


### Reinstatement ###

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture fixpic;
		time = 0;
		duration = 5000;
	};
		
	stimulus_event {
		picture {
			polygon_graphic {};
			x = 0; y = 0;
		} reinst_pic;
		time = 5000;
		duration = 1; # changes in pcl
		code = "cue_reinstatement";
		port_code = 0; # changes in pcl
		port = 1;
	} reinst_event;
	
	stimulus_event {
		picture fixpic;
		deltat = 1000; # changes in pcl
		duration = 5000;
	} after_reinst_event;	
} reinst_trial;



### Material für Abfragen ###

text {
	caption = "Wie <u><b>angenehm bzw. unangenehm</b></u> empfinden Sie dieses Gesicht auf einer Skala von 1 bis 5? \n\n 1 = sehr angenehm            5 = sehr unangenehm";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} pleasant_text;

text {
	caption = "Wie <u><b>aktivierend</b></u> empfinden Sie dieses Gesicht auf einer Skala von 1 bis 5? \n\n 1 = nicht aktivierend            5 = sehr aktivierend";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} arousal_text;

text {
	caption = "Wie <u><b>verängstigt</b></u> sind Sie beim Anblick dieses Gesichts auf einer Skala von 1 bis 5? \n\n 1 = nicht verängstigt       5 = sehr verängstigt";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} anxiety_text;

text {
	caption = "Wie <u><b>verärgert</b></u> sind Sie beim Anblick dieses Gesichts auf einer Skala von 1 bis 5? \n\n 1 = nicht verärgert       5 = sehr verärgert";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} anger_text;

text {
	caption = "Wie <u><b>angeekelt</b></u> sind Sie beim Anblick dieses Gesichts auf einer Skala von 1 bis 5? \n\n 1 = nicht angeekelt       5 = sehr angeekelt";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} disgust_text;

text {
	caption = "Wie häufig, glauben Sie, folgte diesem Bild das laute Geräusch? \n\n 0 = nie        1 = manchmal        2 = häufig        3 = immer";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} contingency_text;

text {
	caption = "Wie <u><b>unangenehm</b></u> finden Sie die Vorstellung, die mit diesem Symbol verknüpft ist? \n\n 0 = überhaupt nicht unangenehm            10 = extrem unangenehm\n\nFalls Sie keine Vorstellung mit diesem Symbol verknüpft haben, drücken Sie bitte die Taste unten links.";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} cuerat_text;

text{
	caption = "Wie <u><b>unangenehm</b></u> fanden Sie den elektrischen Reiz zuletzt? \n\n 0 = überhaupt nicht unangenehm            10 = extrem unangenehm";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} usrat_av_text;

text{
	caption = "Wie <u><b>unangenehm</b></u> fanden Sie den elektrischen Reiz zuletzt? \n\n 0 = überhaupt nicht unangenehm            10 = extrem unangenehm";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} usrat_neu_text;

#pleasant-pics
array {
	picture {
		bitmap bmp_a;
			x = 0;
			y = 70;
		text pleasant_text;
			x = 0;
			y = -280;
	} pfa;

	picture {
		bitmap bmp_b;
			x = 0;
			y = 70;
		text pleasant_text;
			x = 0;
			y = -280;
	} pfb;
	
	picture {
		bitmap bmp_c;
			x = 0;
			y = 70;
		text pleasant_text;
			x = 0;
			y = -280;
	} pfc;	
} ppic_array;

#arousal-pics
array {
	picture {
		bitmap bmp_a;
			x = 0;
			y = 70;
		text arousal_text;
			x = 0;
			y = -280;
	} afa;

	picture {
		bitmap bmp_b;
			x = 0;
			y = 70;
		text arousal_text;
			x = 0;
			y = -280;
	} afb;
	
	picture {
		bitmap bmp_c;
			x = 0;
			y = 70;
		text arousal_text;
			x = 0;
			y = -280;
	} afc;
} apic_array;

#anxiety-pics
array {
	picture {
		bitmap bmp_a;
			x = 0;
			y = 70;
		text anxiety_text;
			x = 0;
			y = -280;
	} anxfa;

	picture {
		bitmap bmp_b;
			x = 0;
			y = 70;
		text anxiety_text;
			x = 0;
			y = -280;
	} anxfb;
	
	picture {
		bitmap bmp_c;
			x = 0;
			y = 70;
		text anxiety_text;
			x = 0;
			y = -280;
	} anxfc;
} anxpic_array;

#anger-pics
array {
	picture {
		bitmap bmp_a;
			x = 0;
			y = 70;
		text anger_text;
			x = 0;
			y = -280;
	} angfa;

	picture {
		bitmap bmp_b;
			x = 0;
			y = 70;
		text anger_text;
			x = 0;
			y = -280;
	} angfb;
	
	picture {
		bitmap bmp_c;
			x = 0;
			y = 70;
		text anger_text;
			x = 0;
			y = -280;
	} angfc;
} angpic_array;

#disgust-pics
array {
	picture {
		bitmap bmp_a;
			x = 0;
			y = 70;
		text disgust_text;
			x = 0;
			y = -280;
	} disfa;

	picture {
		bitmap bmp_b;
			x = 0;
			y = 70;
		text disgust_text;
			x = 0;
			y = -280;
	} disfb;
	
	picture {
		bitmap bmp_c;
			x = 0;
			y = 70;
		text disgust_text;
			x = 0;
			y = -280;
	} disfc;
} dispic_array;

#contingency-pics
array {
	picture {
		bitmap bmp_a;
			x = 0;
			y = 70;
		text contingency_text;
			x = 0;
			y = -280;
	} cfa;

	picture {
		bitmap bmp_b;
			x = 0;
			y = 70;
		text contingency_text;
			x = 0;
			y = -280;
	} cfb;
	
	picture {
		bitmap bmp_c;
			x = 0;
			y = 70;
		text contingency_text;
			x = 0;
			y = -280;
	} cfc;	
} cpic_array;

#cue-rating-pics
array {
	picture {
		polygon_graphic geom_square;
			x = 0;
			y = 100;
		text cuerat_text;
			x = 0;
			y = -250;
	} cuerat_square;

	picture {
		polygon_graphic geom_circle;
			x = 0;
			y = 100;
		text cuerat_text;
			x = 0;
			y = -250;
	} cuerat_circle;
	
	picture {
		polygon_graphic geom_triangle;
			x = 0;
			y = 100;
		text cuerat_text;
			x = 0;
			y = -250;
	} cuerat_triangle;	
} cueratpic_array;


#pleasant-trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "pleasant_plus_av";
				response_active = true;
		} p_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "pleasant_plus_neu";
				response_active = true;
		} p_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "pleasant_minus";
				response_active = true;
		} p_minus_event;
	};
} ptrial_array;

#arousal-trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "arousal_plus_av";
				response_active = true;
		} a_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "arousal_plus_neu";
				response_active = true;
		} a_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "arousal_minus";
				response_active = true;
		} a_minus_event;
	};
} atrial_array;

#anxiety-trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "anxiety_plus_av";
				response_active = true;
		} anx_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "anxiety_plus_neu";
				response_active = true;
		} anx_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "anxiety_minus";
				response_active = true;
		} anx_minus_event;
	};
} anxtrial_array;

#anger-trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "anger_plus_av";
				response_active = true;
		} ang_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "anger_plus_neu";
				response_active = true;
		} ang_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "anger_minus";
				response_active = true;
		} ang_minus_event;
	};
} angtrial_array;

#arousal-trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "disgust_plus_av";
				response_active = true;
		} dis_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "disgust_plus_neu";
				response_active = true;
		} dis_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 2,3,4,5,6;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "disgust_minus";
				response_active = true;
		} dis_minus_event;
	};
} distrial_array;

/*
#contingency trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_plus_av";
				response_active = true;
		} c_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_plus_neu";
				response_active = true;
		} c_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_minus";
				response_active = true;
		} c_minus_event;
	};
} ctrial_array;
*/

#contingency trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_csplusav_usav";
				response_active = true;
		} c_plus_av_event_usav;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_csplusneu_usav";
				response_active = true;
		} c_plus_neu_event_usav;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_csminus_usav";
				response_active = true;
		} c_minus_event_usav;
	};
} ctrial_av_array;

array{
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_csplusav_usneu";
				response_active = true;
		} c_plus_av_event_usneu;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_csplusneu_usneu";
				response_active = true;
		} c_plus_neu_event_usneu;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "contingency_csminus_usneu";
				response_active = true;
		} c_minus_event_usneu;
	};
} ctrial_neu_array;

#cue rating trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4,5,6,7,8,9,10,11,12,15;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "cuerat_plus_av";
				response_active = true;
		} cuerat_plus_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4,5,6,7,8,9,10,11,12,15;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "cuerat_plus_neu";
				response_active = true;
		} cuerat_plus_neu_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4,5,6,7,8,9,10,11,12,15;
		trial_duration = forever;
		stimulus_event{
				nothing{};
				code = "cuerat_minus";
				response_active = true;
		} cuerat_minus_event;
	};
} cuerattrial_array;



#us rating trials
array{
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4,5,6,7,8,9,10,11;
		trial_duration = forever;
		stimulus_event{
				picture{
					text usrat_av_text;
					x = 0; y = 0;
				};
				code = "usrat_av";
				response_active = true;
		} usrat_av_event;
	};
	trial{
		trial_type = first_response;
		terminator_button = 1,2,3,4,5,6,7,8,9,10,11;
		trial_duration = forever;
		stimulus_event{
				picture{
					text usrat_neu_text;
					x = 0; y = 0;
				};
				code = "usrat_neu";
				response_active = true;
		} usrat_neu_event;
	};
} usrattrial_array;


### startle rating ###
text {
	caption = "Wie <u><b>unangenehm</b></u> finden Sie das eben gehörte Geräusch? \n\n 0 = überhaupt nicht unangenehm            10 = extrem unangenehm";
	font_size = 36;
	font = "Arial";
	font_color = 210,210,210;
	background_color = 0,0,0;
} startlerat_text;

picture {
	bitmap {
		filename = "speakericon.bmp";
		scale_factor = 0.15;
	};
		x = 0;
		y = 70;
	text startlerat_text;
		x = 0;
		y = -280;
} startlerat_pic;	

trial{
	trial_type = first_response;
	terminator_button = 1,2,3,4,5,6,7,8,9,10,11,12;
	trial_duration = forever;
	stimulus_event{
			picture startlerat_pic;
			code = "startlerat";
			response_active = true;
	} startlerat_event;
} startlerat_trial;



# imagination scripts
trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture {};
		time = 0;
	} imacue_av_event;
	
	stimulus_event {
		nothing {};
		time = 0;
	} imasound_av_event;
} ima_av_trial;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture {};
		time = 0;
	} imacue_neu_event;
	
	stimulus_event {
		nothing {};
		time = 0;
	} imasound_neu_event;
} ima_neu_trial;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		picture {};
		time = 0;
	} imacue_minus_event;
	
	stimulus_event {
		nothing {};
		time = 0;
	} imasound_minus_event;
} ima_minus_trial;



# material for baseline
#trial {
#	trial_type = fixed;
#	trial_duration = stimuli_length;
	picture {
		text {
			font_size = 48;
			font = "Arial";
			caption = "Bitte halten Sie Ihre Augen geschlossen.";
		} during_baseline_text;
		x = 0;
		y = 0;
	} baseline_picture;
#	time = 0;
#	duration = 5000;
#	
#	stimulus_event{
#		picture baseline_picture;
#		port_code = 0; #changes in PCL
#		port = 1;
#		deltat = 5000;
#		duration = 300000; #changes in PCL
#	} baseline_start_event;
#
#	stimulus_event{
#		picture {};
#		port_code = 0; #changes in PCL
#		port = 1;
#		deltat = 301000; #changes in PCL
#		duration = 1000;
#	} baseline_end_event;
#} baseline;




### for shock work up ###
trial {
	trial_type = first_response;
	trial_duration = forever;
	
	stimulus_event {
		nothing{};
		target_button = 13,14;
		response_active = true;
	};	
} workup_button_trial;

trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	LOOP
		$i 25;
		stimulus_event {
			nothing{};
			time = '25 - $i';
			duration = 1;
			port = 2;
			port_code = 1;
		};
	ENDLOOP;
} workup_shock_trial;	


trial {
	trial_type = fixed;
	trial_duration = stimuli_length;
	
	stimulus_event {
		nothing{};
		time = 0;
		code = "vibration_hab";
		port = 1,2;
		port_code = 0,0;
	} vibrohab_event;
} vibrohab_trial;