--==========================================================================================================--
--======================================== Module Information =============================================--
--==========================================================================================================--
--                                                                                         
-- Company:                IPM                                                         
-- Engineer:               Hanie Ghasemy (hanie.ghasemy@gmail.com)
--                                                                                                 
-- Project Name:           Test_Benchmark                                                            
-- Module Name:            top                                         
--                                                                                                 
-- Language:               VHDL'93                                                                  
--                                                                                                   
-- Target Device:          Kintex7 - KC705                                                         
-- Tool version:           VIVADO 2019.01                                                               
--                                                                                                   
-- Version:                0.1                                                                      
--
-- Description:			               
--
-- Versions history:       DATE         VERSION   AUTHOR            DESCRIPTION
--
--                         11/08/2019   1.0       hanie         	- First             
--
--==========================================================================================================--

--==========================================================================================================--
--========================================== Additional Comments ==========================================--
--==========================================================================================================-- 
	-- hard-coded LUT transfer function (combinational logic) plus output register (sequential logic)
--==========================================================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--== uncomment the following library declaration if using arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;

--== uncomment the following library declaration if instantiating any xilinx leaf cells in this code
library unisim;
use unisim.vcomponents.all;
--==========================================================================================================--
entity top is
    port(
        clk_in_p                : in  std_logic;
        clk_in_n                : in  std_logic;
        gpio_switch_in_rst      : in std_logic;
        gpio_led_out_err        : out std_logic); 
end entity;
--==========================================================================================================--
architecture structural of top is

    signal clk_in           : std_logic;
    signal clk_ibufgds      : std_logic;
    signal pat_err_out      : std_logic;

    component lane is
    port(
        clk_in              : in std_logic;
        rst_in              : in std_logic;
        pat_err_out         : out std_logic);
    end component;
--==========================================================================================================--
begin
    ------------------------------------------------------------
    --  instantiation : lane 
    ------------------------------------------------------------  
    ins : lane port map
    (clk_in               => clk_in,
    rst_in               => gpio_switch_in_rst,
    pat_err_out          => pat_err_out);  


    gpio_led_out_err <= not (pat_err_out);
    ------------------------------------------------------------
    --  differential clock buffer
    ------------------------------------------------------------
    ins_ibufgds : ibufgds
    generic map (iostandard => "lvds")
    port map 
    (o    => clk_ibufgds, 
    i    => clk_in_p,
    ib   => clk_in_n);

    ins_bufg : bufg
    port map 
    (o     => clk_in, 
    i     => clk_ibufgds);

end architecture structural;
