-------------------------------------------------------------------------------
--
-- Title       : PCNTW
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\PCNTW.vhd
-- Generated   : Thu Mar 25 11:07:26 2021
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

entity PCNTW is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end PCNTW;									  

architecture behavioral of PCNTW is	 
	signal res: std_logic_vector(127 downto 0);
begin		-- for each word in j, count the number of ones by looping through each bit field
	count0: process (j)
	variable count: unsigned (31 downto 0) := "00000000000000000000000000000000";
	begin
		for a in 0 to 31 loop
			count := count + unsigned("0000000000000000000000000000000" & j(a));
		end loop;
		res(31 downto 0) <= std_logic_vector(count); 
	end process;
	
	count1: process (j)
	variable count: unsigned (31 downto 0) := "00000000000000000000000000000000";
	begin
		for a in 32 to 63 loop
			count := count + unsigned("0000000000000000000000000000000" & j(a));
		end loop;
		res(63 downto 32) <= std_logic_vector(count); 
	end process;
	
	count2: process (j)
	variable count: unsigned (31 downto 0) := "00000000000000000000000000000000";
	begin
		for a in 64 to 95 loop
			count := count + unsigned("0000000000000000000000000000000" & j(a));
		end loop;
		res(95 downto 64) <= std_logic_vector(count); 
	end process;
	
	count3: process (j)
	variable count: unsigned (31 downto 0) := "00000000000000000000000000000000";
	begin
		for a in 96 to 127 loop
			count := count + unsigned("0000000000000000000000000000000" & j(a));
		end loop;
		res(127 downto 96) <= std_logic_vector(count); 
	end process;
	
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "1100") then					-- check for right opcode
			r <= res;
		end if;
	end process;  

end behavioral;
