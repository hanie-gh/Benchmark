--==========================================================================================================--
--======================================== Module Information =============================================--
--==========================================================================================================--
--                                                                                         
-- Company:                IPM                                                         
-- Engineer:               Hanie Ghasemy (hanie.ghasemy@gmail.com)
--                                                                                                 
-- Project Name:           Test_Benchmark                                                            
-- Module Name:            LTS                                         
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
--== uncomment the following library declaration if using arithmetic functions with signed or unsigned values
-- use ieee.numeric_std.all;

--== uncomment the following library declaration if instantiating any xilinx leaf cells in this code
-- library unisim;
-- use unisim.vcomponents.all;
--==========================================================================================================--
entity LTS is
    port(
        clk_in      : in std_logic;
        d_in        : in std_logic_vector(5 downto 0);
        d_out       : out std_logic_vector(5 downto 0));
end entity;
--==========================================================================================================--
architecture structural of LTS is
  signal d_s : std_logic_vector(5 downto 0) := (others => '0');

  component LTS_comb is
    port(
        d_in        : in std_logic_vector(5 downto 0);
        d_out       : out std_logic_vector(5 downto 0));
  end component;
--==========================================================================================================--
begin
  ------------------------------------------------------------
  --  sequential part
  ------------------------------------------------------------  
  reg : process(clk_in)
  begin	 
    if (rising_edge(clk_in)) then
      d_out <= d_s;
    end if;
  end process reg;
  ------------------------------------------------------------
  --  combinational part (hard-code adder)
  ------------------------------------------------------------
  ins_LTS_comb : LTS_comb
    port map
    (
      d_in    => d_in,
      d_out   => d_s
    );   
       
end architecture structural;
