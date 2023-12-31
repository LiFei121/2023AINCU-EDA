# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.cache/wt} [current_project]
set_property parent.project_path {C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.xpr} [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/img.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/image.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/imgx.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/flower.coe}}
add_files C:/Users/lifei/Desktop/Lifei/Image-Processing-master/s2.coe
add_files C:/Users/lifei/Desktop/Lifei/Image-Processing-master/c1.coe
add_files C:/Users/lifei/Desktop/Lifei/Image-Processing-master/s3.coe
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/last.coe}}
add_files C:/Users/lifei/Desktop/Lifei/Image-Processing-master/ncu.coe
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/nculifei.coe}}
add_files C:/Users/lifei/Desktop/Lifei/Image-Processing-master/66.coe
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/flower1.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/LiFei.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/LiFei110.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/ncu2.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/namelifei.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/sign2.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/sin.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/signn.coe}}
add_files {{C:/Users/lifei/Desktop/Image-Processing-master/Final Project/Lf.coe}}
add_files {{C:/Users/lifei/Desktop/Image-Processing-master/Final Project/s.coe}}
add_files {{C:/Users/lifei/Desktop/Image-Processing-master/Final Project/image1.coe}}
add_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/lifein.coe}}
add_files c:/Users/lifei/Desktop/Lifei/Image-Processing-master/ll.coe
read_verilog -library xil_defaultlib {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/new/VGA.v}}
read_ip -quiet {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/ip/image/image.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/ip/image/image_ooc.xdc}}]

read_ip -quiet {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc}}]

read_ip -quiet {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/constrs_1/new/constr.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/lifei/Desktop/Lifei/Image-Processing-master/Final Project/VGA_1/VGA_1.srcs/constrs_1/new/constr.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top vga_syncIndex -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef vga_syncIndex.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file vga_syncIndex_utilization_synth.rpt -pb vga_syncIndex_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
