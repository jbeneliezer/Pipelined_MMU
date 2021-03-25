-------------------------------------------------------------------------------
--
-- Title       : SFW
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SFW.vhd
-- Generated   : Thu Mar 25 11:59:48 2021
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
use IEEE.numeric_std.all;

entity SFW is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end SFW;									

architecture behavioral of SFW is 
	signal res: std_logic_vector(127 downto 0);
begin		   		-- compute unsigned subtraction for each word in i and j
	res(31 downto 0) <= std_logic_vector(unsigned(i(31 downto 0)) - unsigned(j(31 downto 0)));		 
	res(63 downto 32) <= std_logic_vector(unsigned(i(63 downto 32)) - unsigned(j(63 downto 32)));
	res(95 downto 64) <= std_logic_vector(unsigned(i(95 downto 64)) - unsigned(j(95 downto 64)));
	res(127 downto 96) <= std_logic_vector(unsigned(i(127 downto 96)) - unsigned(j(127 downto 96))); 
	
	process (op) 
	begin
		if (op = "11----1111---------------") then			-- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
