
###############################################
## KC705 Development Board (XC7K325TFFG900-2)
###############################################
#
#  Clock period
#  200 MHz oscillator
create_clock -period 5.000 -name clk_in_p [get_ports clk_in_p]
create_clock -period 5.000 -name clk_in_n [get_ports clk_in_n]
create_clock -period 5.000 -name clk_raw [get_nets clk_raw]

# Pin locs
set_property PACKAGE_PIN AD12 [get_ports clk_in_p]
set_property PACKAGE_PIN AD11 [get_ports clk_in_n]
set_property IOSTANDARD LVDS [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_n]

set_property PACKAGE_PIN Y28 [get_ports gpio_switch_in_rst]
set_property IOSTANDARD LVCMOS25 [get_ports gpio_switch_in_rst]

set_property PACKAGE_PIN AB8 [get_ports {gpio_led_out_err}]
set_property IOSTANDARD LVCMOS15 [get_ports {gpio_led_out_err}]

set_property PACKAGE_PIN AC9  [get_ports {gpio_led_out_cnt[0]}]
set_property PACKAGE_PIN AB9  [get_ports {gpio_led_out_cnt[1]}]
set_property PACKAGE_PIN AE26 [get_ports {gpio_led_out_cnt[2]}]
set_property PACKAGE_PIN G19  [get_ports {gpio_led_out_cnt[3]}]
set_property PACKAGE_PIN E18  [get_ports {gpio_led_out_cnt[4]}]
set_property PACKAGE_PIN F16  [get_ports {gpio_led_out_cnt[5]}]

set_property IOSTANDARD LVCMOS15 [get_ports {gpio_led_out_cnt[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {gpio_led_out_cnt[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_led_out_cnt[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_led_out_cnt[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_led_out_cnt[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_led_out_cnt[5]}]