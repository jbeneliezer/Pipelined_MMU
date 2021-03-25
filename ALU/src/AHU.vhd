-------------------------------------------------------------------------------
--
-- Title       : AHU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\AHU.vhd
-- Generated   : Thu Mar 25 00:08:02 2021
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

entity AHU is
	 port(					
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end AHU;									 

architecture behavioral of AHU is
signal res: std_logic_vector(127 downto 0);
begin	 	-- comput sum of each halfword of i and j
 	res(15 downto 0) <= std_logic_vector(unsigned(i(15 downto 0)) + unsigned(j(15 downto 0)));
	res(31 downto 16) <= std_logic_vector(unsigned(i(31 downto 16)) + unsigned(j(31 downto 16)));
	res(47 downto 32) <= std_logic_vector(unsigned(i(47 downto 32)) + unsigned(j(47 downto 32)));
	res(63 downto 48) <= std_logic_vector(unsigned(i(63 downto 48)) + unsigned(j(63 downto 48)));
	res(79 downto 64) <= std_logic_vector(unsigned(i(79 downto 64)) + unsigned(j(79 downto 64)));
	res(95 downto 80) <= std_logic_vector(unsigned(i(95 downto 80)) + unsigned(j(95 downto 80)));
	res(111 downto 96) <= std_logic_vector(unsigned(i(111 downto 96)) + unsigned(j(111 downto 96)));
	res(127 downto 112) <= std_logic_vector(unsigned(i(127 downto 112)) + unsigned(j(127 downto 112)));	  
	
	process (op)
	begin
		if (op = "11----0010---------------") then			  -- check for right opcode
			r <= res;
		end if;
	end process;


end behavioral;
