-------------------------------------------------------------------------------
--
-- Title       : AU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\AU.vhd
-- Generated   : Wed Mar 24 23:47:37 2021
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
--{entity {AU} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity AU is
	 port(
		 clk : in STD_LOGIC;
		 op : in STD_LOGIC_VECTOR(9 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end AU;

--}} End of automatically maintained section

architecture behavioral of AU is 
	signal res: std_logic_vector(127 downto 0);
begin
 	res(31 downto 0) <= std_logic_vector(unsigned(i(31 downto 0)) + unsigned(j(31 downto 0)));
	res(63 downto 32) <= std_logic_vector(unsigned(i(63 downto 32)) + unsigned(j(63 downto 32)));
	res(95 downto 64) <= std_logic_vector(unsigned(i(95 downto 64)) + unsigned(j(95 downto 64)));
	res(127 downto 96) <= std_logic_vector(unsigned(i(127 downto 96)) + unsigned(j(127 downto 96)));
	process (all)
	begin
		if (clk'event and clk = '1' and op = "11----0000") then
			r <= res;
		end if;
	end process;

end behavioral;
