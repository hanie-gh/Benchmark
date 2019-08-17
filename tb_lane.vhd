--==========================================================================================================--
--======================================== Module Information =============================================--
--==========================================================================================================--
--                                                                                         
-- Company:                IPM                                                         
-- Engineer:               Hanie Ghasemy (hanie.ghasemy@gmail.com)
--                                                                                                 
-- Project Name:           Test_Benchmark                                                            
-- Module Name:            tb_lane                                         
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--== uncomment the following library declaration if instantiating any xilinx leaf cells in this code
--library unisim;
--use unisim.vcomponents.all;

entity tb_lane is     
end entity;

architecture behavioral of tb_lane is
    component lane is 
        port(
            clk_in      : in std_logic;
            rst_in      : in std_logic;
            pat_err_out : out std_logic); 
    end component;
    ----------------------------------------------------------------------------------------------------
    --====================================== signal definition ======================================--
    ----------------------------------------------------------------------------------------------------       	
    --== clock & reset & controller signal
    signal stopSimulation		        : boolean   := false;
    signal startSimulation		        : boolean   := false;
    signal clk_in           		    : std_logic := '0';
    signal rst_in                  	    : std_logic := '1';
    signal pat_err_out                  : std_logic;
    constant period_200                 : time      := 5000  ps;     
begin
    ----------------------------------------------------------------------------------------------------
    --================================ instantiation of the ttc_fifo ================================--
    ---------------------------------------------------------------------------------------------------- 
    ins_lane: lane 
        port map(          
        clk_in 								=> clk_in,
        rst_in 								=> rst_in,
        pat_err_out 						=> pat_err_out);	    
    ----------------------------------------------------------------------------------------------------
    --=========================== simulation control & stimulus generation ===========================--
    ----------------------------------------------------------------------------------------------------
    --======================================== clock & rst_in ========================================--  
	--== simulation control 
	stopsimulation <= true after 50000 ns;		-- duration of the simulation	
    assert not stopsimulation report "simulation finished" severity note;	

	startSimulation <= true after 100 ns;			
    assert not startSimulation report "simulation started" severity note;	
    -- assert not startData report "simulation started" severity note;    

    --== 200 mhz clock generation process ==--
    -- clk_in <= not clk_in  after period_200/2;
    clk_in_200 : process	
    begin   
        if not stopsimulation then	
            clk_in	<= '0';			
            wait for period_200/2;			
            clk_in	<= '1';			
            wait for period_200/2;	
        end if;		
    end process; 

    --== rst_in 
    p_rst_in : process	
	begin   
		if (not startSimulation) or stopsimulation then	
            rst_in	<= '1';
            wait for period_200;
        elsif startSimulation and (not stopsimulation) then
            rst_in	<= '0';	
            wait for period_200;
		end if;		
   end process;  

end architecture;