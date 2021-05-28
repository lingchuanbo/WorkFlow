/*
Particle Looper
Version 1.1
Written By: Jason Hayes (jhayes@ballisticpixel.com)
Date:02/12/2002
Developed for 3D Studio MAX 4.2
Description: Will loop supported particle systems.  Please read the Help html file for usage.
			 The supported particles systems are:
			 
			 	- Super Spray
			 	- Blizzard
			 	- PArray
			 	- PCloud
				
			 The advantage of using this over Peter Watje's "Particles +" plugin is that you can use
			 some of the default MAX particle systems in case you need to use instanced geometry. 
			 What sucks is that it's a big cheese workaround, but it does the trick! :)

Version 1.0: Initial script.
Version 1.1: (Requested) Added the ability to choose a custom prefix for the looped particle systems.
*/


-- macroscript ParticleLooper
-- category:"BPL Tools"
-- buttonText:"ParticleLooper"
-- toolTip:"Particle Looper"
-- icon:#("ParticleLooper",1)
-- (

global base_system
global particle_sys01
global particle_sys02
global particle_sys03
global particle_sys04

if particle_looper != undefined then (closeRolloutFloater particle_looper)
particle_looper = newRolloutFloater "Particle Looper" 240 494

rollout support_ro "Supported Particle Systems"
(
label lb_Blizzard "Blizzard"
label lb_PArray "PArray"
label lb_PCloud "PCloud"
label lb_SuperSpray "Super Spray"
)

rollout pl_ro "Parameters"
(
pickbutton pick_particle_sys "Pick Base Particle System" width:200 height:30
label lb_base_system "none"
label space01 ""

group "Emitter Start / Stop Frame Range"
	(
	spinner sp_frame_range "Num Frames:" range:[-9999,9999,0] type:#integer width:105 align:#right
	)

group "Custom Properties"
	(
	checkbox cb_wire_color "Consistent wire color"
	checkbox cb_custom_prefix "Custom Prefix"
	edittext et_prefix "Prefix:" text:"PL_" enabled:false
	)

group "Looping"
	(
	button loop_system "Loop Particle System" width:190 height:30
	button delete_looped_system "Delete Looped System" width:190 height:30 toolTip:"Will only delete systems with the prefix 'PL_'"
	)



/* EVENTS */
on cb_custom_prefix changed state do
	(
	if state == true then (et_prefix.enabled = true) else (et_prefix.enabled = false)
	)


on pick_particle_sys picked obj do
	(
	base_system = obj
	lb_base_system.text = base_system.name
	
	/* Get the num frames of the base systems emitter start / stop and put it into the slider */
	base_system_start = base_system.emitter_start
	base_system_stop = base_system.emitter_stop
	num_frames = base_system_stop - base_system_start
	sp_frame_range.value = num_frames
	)
	
	
on loop_system pressed do
	(
	undo on
	(
	frame_range = sp_frame_range.value
	wire_color = base_system.wireColor
	prefix_name = et_prefix.text as string
	
	/* Create the new particles */
	particle_sys01 = base_system
	particle_sys02 = copy particle_sys01
	particle_sys03 = copy particle_sys02
	particle_sys04 = copy particle_sys03
	
	/* Rename the new particle systems to the prefix */
	particle_sys02.name = (prefix_name + particle_sys02.name)
	particle_sys03.name = (prefix_name + particle_sys03.name)
	particle_sys04.name = (prefix_name + particle_sys04.name)

		/* DEBUG */
		format "SYS02 NAME=%\n" particle_sys02.name
		format "SYS03 NAME=%\n" particle_sys03.name
		format "SYS04 NAME=%\n" particle_sys04.name
		/* DEBUG END */

	/* Adjust the particles emitter start / stop for the loop */
	sys01_start = particle_sys01.emitter_start
	sys01_stop = particle_sys01.emitter_stop

	particle_sys02.emitter_start = sys01_stop
	particle_sys02.emitter_stop = sys01_stop + frame_range

	particle_sys03.emitter_start = sys01_start - frame_range
	particle_sys03.emitter_stop = sys01_start

	particle_sys04.emitter_start = particle_sys03.emitter_start - frame_range
	particle_sys04.emitter_stop = particle_sys03.emitter_start
	
	/* If the user wants the wire color to be the same, do it here */
	try
	(
	if cb_wire_color.state == true then
		(
		particle_sys02.wireColor = wire_color
		particle_sys03.wireColor = wire_color
		particle_sys04.wireColor = wire_color
		)
	)
	catch()
	)--end undo
	)


on delete_looped_system pressed do
	(
	undo on
		(
		delete $'PL_*'
		)
	)

)--end rollout



rollout about_ro "About" rolledUp:true
(
label lb_1 "Particle Looper" align:#right
label lb_2 "Version 1.1" align:#right
label lb_3 "Written By Jason Hayes" align:#right
label lb_4 "jhayes@ballisticpixel.com" align:#right
button btn_help "Help" width:190

on btn_help pressed do
	(
	help_path = GetDir #help
	help_file = (help_path + "\\ParticleLooper_Help.htm")
	shellLaunch help_file ""
	)
)


addRollout support_ro particle_looper
addRollout pl_ro particle_looper
addRollout about_ro particle_looper

-- )--end macroscript