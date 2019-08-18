--==========================================================================================================--
--======================================== Module Information =============================================--
--==========================================================================================================--
--                                                                                         
-- Company:                IPM                                                         
-- Engineer:               Hanie Ghasemy (hanie.ghasemy@gmail.com)
--                                                                                                 
-- Project Name:           Test_Benchmark                                                            
-- Module Name:            LTS_comb                                       
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
	-- hard-coded LUT transfer function (combinational logic) 
--==========================================================================================================--

library ieee;
use ieee.std_logic_1164.all;
--== uncomment the following library declaration if using arithmetic functions with signed or unsigned values
-- use ieee.numeric_std.all;

--== uncomment the following library declaration if instantiating any xilinx leaf cells in this code
-- library unisim;
-- use unisim.vcomponents.all;

entity LTS_comb is
    port(
        d_in        : in std_logic_vector(5 downto 0);
        d_out       : out std_logic_vector(5 downto 0));
end entity;

architecture structural of LTS_comb is

begin
    process(d_in)
    begin
        case (d_in) is
            when "000000" =>    d_out <= "000001";
            when "000001" =>    d_out <= "000010";
            when "000010" =>    d_out <= "000011";
            when "000011" =>    d_out <= "000100";
            when "000100" =>    d_out <= "000101";
            when "000101" =>    d_out <= "000110";
            when "000110" =>    d_out <= "000111";
            when "000111" =>    d_out <= "001000";
            when "001000" =>    d_out <= "001001";
            when "001001" =>    d_out <= "001010";
            when "001010" =>    d_out <= "001011";
            when "001011" =>    d_out <= "001100";
            when "001100" =>    d_out <= "001101";
            when "001101" =>    d_out <= "001110";
            when "001110" =>    d_out <= "001111";
            when "001111" =>    d_out <= "010000";
            when "010000" =>    d_out <= "010001";
            when "010001" =>    d_out <= "010010";
            when "010010" =>    d_out <= "010011";
            when "010011" =>    d_out <= "010100";
            when "010100" =>    d_out <= "010101";
            when "010101" =>    d_out <= "010110";
            when "010110" =>    d_out <= "010111";
            when "010111" =>    d_out <= "011000";
            when "011000" =>    d_out <= "011001";
            when "011001" =>    d_out <= "011010";
            when "011010" =>    d_out <= "011011";
            when "011011" =>    d_out <= "011100";
            when "011100" =>    d_out <= "011101";
            when "011101" =>    d_out <= "011110";
            when "011110" =>    d_out <= "011111";
            when "011111" =>    d_out <= "100000";

            when "100000" =>    d_out <= "100001";
            when "100001" =>    d_out <= "100010";
            when "100010" =>    d_out <= "100011";
            when "100011" =>    d_out <= "100100";
            when "100100" =>    d_out <= "100101";
            when "100101" =>    d_out <= "100110";
            when "100110" =>    d_out <= "100111";
            when "100111" =>    d_out <= "101000";
            when "101000" =>    d_out <= "101001";
            when "101001" =>    d_out <= "101010";
            when "101010" =>    d_out <= "101011";
            when "101011" =>    d_out <= "101100";
            when "101100" =>    d_out <= "101101";
            when "101101" =>    d_out <= "101110";
            when "101110" =>    d_out <= "101111";
            when "101111" =>    d_out <= "110000";
            when "110000" =>    d_out <= "110001";
            when "110001" =>    d_out <= "110010";
            when "110010" =>    d_out <= "110011";
            when "110011" =>    d_out <= "110100";
            when "110100" =>    d_out <= "110101";
            when "110101" =>    d_out <= "110110";
            when "110110" =>    d_out <= "110111";
            when "110111" =>    d_out <= "111000";
            when "111000" =>    d_out <= "111001";
            when "111001" =>    d_out <= "111010";
            when "111010" =>    d_out <= "111011";
            when "111011" =>    d_out <= "111100";
            when "111100" =>    d_out <= "111101";
            when "111101" =>    d_out <= "111110";
            when "111110" =>    d_out <= "111111";
            when "111111" =>    d_out <= "000000";

            when others =>  d_out <= "000000";
            --report "unreachable" severity failure;
        end case;
    end process;   
end architecture structural;
