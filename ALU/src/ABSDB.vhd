-------------------------------------------------------------------------------
--
-- Title       : ABSDB
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\ABSDB.vhd
-- Generated   : Wed Mar 24 23:51:34 2021
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

entity ABSDB is
	 port(				 
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ABSDB;									

architecture behavioral of ABSDB is	  
	signal res: signed (127 downto 0);	
begin			 
	res <= (abs(signed(j) - signed(i)));					  -- compute absolute difference between i and j
	
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "0010") then			  -- check for right opcode
			r <= std_logic_vector(res);
		end if;
	end process;
					 

end behavioral;
