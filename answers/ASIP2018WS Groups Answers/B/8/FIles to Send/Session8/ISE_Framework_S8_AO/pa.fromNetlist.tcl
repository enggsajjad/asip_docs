
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ISE_Framework_S8_AO -dir "/home/asip02/Schreibtisch/Session8/brownie2/ISE_Framework_S8_AO/planAhead_run_2" -part xc5vlx110tff1136-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/asip02/Schreibtisch/Session8/brownie2/ISE_Framework_S8_AO/dlx_toplevel.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/asip02/Schreibtisch/Session8/brownie2/ISE_Framework_S8_AO} }
set_param project.paUcfFile  "dlx_toplevel.ucf"
add_files "dlx_toplevel.ucf" -fileset [get_property constrset [current_run]]
open_netlist_design
