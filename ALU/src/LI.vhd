-------------------------------------------------------------------------------
--
-- Title       : LI
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\LI.vhd
-- Generated   : Thu Mar 25 14:09:29 2021
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

entity LI is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end LI;										 

architecture behavioral of LI is
begin
	process (op)
	begin 
		if (op(24) = '0') then			   -- check for right opcode
			case (op(23 downto 21)) is
				when "000" => r(15 downto 0) <= op(20 downto 5);			   -- set the specied range of r to immediate
				when "001" => r(31 downto 16) <= op(20 downto 5);
				when "010" => r(47 downto 32) <= op(20 downto 5);
				when "011" => r(63 downto 48) <= op(20 downto 5);
				when "100" => r(79 downto 64) <= op(20 downto 5);
				when "101" => r(95 downto 80) <= op(20 downto 5);
				when "110" => r(111 downto 96) <= op(20 downto 5);
				when "111" => r(127 downto 112) <= op(20 downto 5);
				when others => null;
			end case; 
		end if;
	end process;

end behavioral;
