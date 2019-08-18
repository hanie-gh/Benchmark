--==========================================================================================================--
--======================================== Module Information =============================================--
--==========================================================================================================--
--                                                                                         
-- Company:                IPM                                                         
-- Engineer:               Hanie Ghasemy (hanie.ghasemy@gmail.com)
--                                                                                                 
-- Project Name:           Test_Benchmark                                                            
-- Module Name:            lane                                         
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
  -- Each lane consists of a TMR-ed pattern generator, a chain of Logic Test Structures (LTS), a TMR-ed pattern checker. 
  -- The pattern generator outputs test vectors which are periodically repeated 6 bits wide sequences from 0 to 63. 
  -- A width of the test vector was set to 6 bits because the input of an LUT in Kintex-7 is also 6 bits wide. 
  -- The LTS is replicated 64 times, forming a chain that shifts the test vectors. 
  -- The basic LTS consists of a hard-coded LUT transfer function (Combinational Logic) and an output register (R). 
  -- The combinational logic increments the input data by 1 and the output register holds the value for one clock cycle. 
  -- In order to test different redundancy topologies in the LTS, it is possible to employ TMR either in the combinational logic, the output register or both.
  -- Also, the data voter between the combinational logic and the output register or the full chain of the basic LTS can be implemented with TMR. 
  -- After the reset signal is deasserted, the pattern generator starts outputting test vectors which are pushed through the chain of the LTS at a frequency of 100MHz. 
  -- 64 clock cycles later, data at the output from the chain of the LTS are copies of the data outputted by the pattern generator. 
  -- This condition remains true unless an error occurs either in the pattern generator, the chain of the LTS, or the routing between those modules and the pattern checker. 
  -- The pattern checker compares the output from the chain of the LTS to the reference output from the pattern generator. 
  -- If a discrepancy is found, a pattern error signal is asserted on the PAT ERR output. 
--==========================================================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--== uncomment the following library declaration if using arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;

--== uncomment the following library declaration if instantiating any xilinx leaf cells in this code
-- library unisim;
-- use unisim.vcomponents.all;
--==========================================================================================================--
entity lane is
    port(
        clk_in      : in std_logic;
        rst_in      : in std_logic;
        pat_err_out : out std_logic
        --lane_war_out: out std_logic
        );
end entity;
--==========================================================================================================--
architecture structural of lane is
    signal pat_gen_s  : std_logic_vector(5 downto 0) := (others => '0');
    signal pat_chk_s  : std_logic_vector(5 downto 0) := (others => '0');
    type chain_lts is array (0 to 64) of std_logic_vector(5 downto 0);
  signal lts_s      : chain_lts := (others => (others => '0'));

  component LTS is
    port(
        clk_in      : in std_logic;
        d_in        : in std_logic_vector(5 downto 0);
        d_out       : out std_logic_vector(5 downto 0));
    end component;
--==========================================================================================================--
begin
  ------------------------------------------------------------
  --  pattern generator
  ------------------------------------------------------------  
  proc : process(clk_in, rst_in)
  begin	 
    if (rising_edge(clk_in)) then
        if rst_in = '1' then
            pat_gen_s <= (others => '0');
        else
            pat_gen_s <= pat_gen_s + 1;
        end if;
    end if;
  end process proc;
  lts_s(0)      <= pat_gen_s;
  pat_chk_s     <= lts_s(63);

  ------------------------------------------------------------
  --  chane of 64 LTS
  ------------------------------------------------------------ 
  gen_cas: for i in 0 to 63 generate   
    begin  --"begin" statement for "generate"
    --entity work.LTS port map   --usual port mapping
    ins : LTS port map
    (clk_in  => clk_in,
    d_in    => lts_s(i),
    d_out   => lts_s(i+1));  
    
  end generate;  --end "generate" block.

  ------------------------------------------------------------
  --  pattern checker
  ------------------------------------------------------------                   
  pat_err_out   <= '0' when lts_s(64)=pat_gen_s else
                   '1';


end architecture structural;
