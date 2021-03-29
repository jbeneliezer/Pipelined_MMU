-------------------------------------------------------------------------------
--
-- Title       : MLHU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\MLHU.vhd
-- Generated   : Thu Mar 25 10:42:49 2021
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

entity MLHU is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end MLHU;									

architecture behavioral of MLHU is	 
	signal res: std_logic_vector(127 downto 0);
begin				-- set each word of res to product of lower halfwords of each word in i and j	
	res(31 downto 0) <= std_logic_vector(unsigned(i(15 downto 0)) * unsigned(j(15 downto 0)));				
	res(63 downto 32) <= std_logic_vector(unsigned(i(47 downto 32)) * unsigned(j(47 downto 32)));				
	res(95 downto 64) <= std_logic_vector(unsigned(i(79 downto 64)) * unsigned(j(79 downto 64)));				
	res(127 downto 96) <= std_logic_vector(unsigned(i(111 downto 96)) * unsigned(j(111 downto 96)));
	
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "1001") then			   -- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
