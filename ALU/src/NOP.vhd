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

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {NOP} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity NOP is
	 port(
		 clk : in STD_LOGIC;
		 op : in STD_LOGIC_VECTOR(9 downto 0)
	     );
end NOP;

--}} End of automatically maintained section

architecture behavioral of NOP is
begin
	process (all)
	begin
		if (clk'event and clk = '1' and op = "11----0000") then
			null;
		end if;
	end process;
end behavioral;
