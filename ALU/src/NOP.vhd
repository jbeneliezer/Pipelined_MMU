-------------------------------------------------------------------------------
--
-- Title       : NOP
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\NOP.vhd
-- Generated   : Wed Mar 24 23:45:45 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------	   

library IEEE;
use IEEE.std_logic_1164.all;

entity NOP is
	 port(				
		 op : in STD_LOGIC_VECTOR(24 downto 0)
	     );
end NOP;								   

architecture behavioral of NOP is
begin
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "0000") then		   -- check for right opcode
			null;										   -- do nothing
		end if;
	end process;
end behavioral;
