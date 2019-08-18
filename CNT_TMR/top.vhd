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
        gpio_led_out_err        : out std_logic;
        gpio_led_out_cnt        : out std_logic_vector(5 downto 0)); 
end entity;
--==========================================================================================================--
architecture structural of top is

    signal clk_in           : std_logic := '0';
    signal clk_raw          : std_logic := '0';
    signal clk_ibufgds      : std_logic := '0';
    signal pat_err_out      : std_logic;
    --signal pat_gen_out      : std_logic_vector(5 downto 0);

    component lane_tmr is
    port(clk_in      : in std_logic;
         rst_in      : in std_logic;
         pat_err_out : out std_logic;
         pat_gen_out : out std_logic_vector(5 downto 0));
    end component;
--==========================================================================================================--
begin
    ------------------------------------------------------------
    --  instantiation : lane_tmr 
    ------------------------------------------------------------  
    ins : lane_tmr port map
    (clk_in               => clk_in,
     rst_in               => gpio_switch_in_rst,
     pat_err_out          => pat_err_out,  
     pat_gen_out         => gpio_led_out_cnt);  


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
    (o     => clk_raw, 
     i     => clk_ibufgds);



  ------------------------------------------------------------
  --  clock division
  ------------------------------------------------------------  
  proc : process(clk_raw, gpio_switch_in_rst)
  variable counter  : integer := 0;
  begin	 
    if (rising_edge(clk_raw)) then
        if gpio_switch_in_rst = '1' then
            counter := 0;
            clk_in  <= '0'; 
        else
            counter := counter + 1;
            if counter = 100000000 then 
                counter := 0;
                clk_in  <= not clk_in;
            else 
                clk_in  <= clk_in;
            end if;
        end if;
    end if;
  end process proc;    

end architecture structural;
