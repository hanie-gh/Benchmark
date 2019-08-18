--==========================================================================================================--
--======================================== Module Information =============================================--
--==========================================================================================================--
--                                                                                         
-- Company:                IPM                                                         
-- Engineer:               Hanie Ghasemy (hanie.ghasemy@gmail.com)
--                                                                                                 
-- Project Name:           Test_Benchmark                                                            
-- Module Name:            voter_tmr                                         
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
--the dont_touch works the same way as the keep. 
--however unlike the keep, don’t_touch is forwarded-annotated to place and route to prevent logic optimization. 
--this can also be used a replacement of keep and keep_hierarchy.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--== uncomment the following library declaration if using arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;

--== uncomment the following library declaration if instantiating any xilinx leaf cells in this code
-- library unisim;
-- use unisim.vcomponents.all;
--==========================================================================================================--
entity voter_tmr is
  port(
      in1     : in std_logic_vector(5 downto 0);
      in2     : in std_logic_vector(5 downto 0);
      in3     : in std_logic_vector(5 downto 0);
      output  : out std_logic_vector(5 downto 0));
end entity;
--==========================================================================================================--
architecture structural of voter_tmr is
    attribute dont_touch : string;
    attribute dont_touch of structural : architecture is "yes";  
      
    signal out0 : std_logic_vector(5 downto 0);
    signal out1 : std_logic_vector(5 downto 0);
    signal out2 : std_logic_vector(5 downto 0);

    attribute dont_touch of out0 : signal is "yes";
    attribute dont_touch of out1 : signal is "yes";
    attribute dont_touch of out2 : signal is "yes";

    component voter is
    port(
        in1     : in std_logic_vector(5 downto 0);
        in2     : in std_logic_vector(5 downto 0);
        in3     : in std_logic_vector(5 downto 0);
        output  : out std_logic_vector(5 downto 0));
    end component;    
begin
    
------------------------------------------------------------
--  instantiation : lane_tmr 
------------------------------------------------------------ 
    ins_tmr0 : voter
        port map (
        in1         => in1,
        in2         => in2,
        in3         => in3,
        output      => out0);  

    ins_tmr1 : voter
        port map (
        in1         => in1,
        in2         => in2,
        in3         => in3,
        output      => out1);

    ins_tmr2 : voter
        port map (
        in1         => in1,
        in2         => in2,
        in3         => in3,
        output      => out2);   

    ins_tmr : voter
        port map (
        in1         => out0,
        in2         => out1,
        in3         => out2,
        output      => output); 
                
end architecture structural;
