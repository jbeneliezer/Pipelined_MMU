-------------------------------------------------------------------------------
--
-- Title       : BCW
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\BCW.vhd
-- Generated   : Thu Mar 25 10:20:37 2021
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

entity BCW is
	 port(					 
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end BCW;									   

architecture behavioral of BCW is  
	signal res: std_logic_vector(127 downto 0);
begin  	   -- set each word of res to lowest word of j
	res(31 downto 0) <= j(31 downto 0);
	res(63 downto 32) <= j(31 downto 0);
	res(95 downto 64) <= j(31 downto 0);
	res(127 downto 96) <= j(31 downto 0); 
	
	process (op)
	begin
		if (op(24 downto 23) = "11" and op(18 downto 15) = "0110") then		   -- check for right opcode
			r <= res;
		end if;
	end process;

end behavioral;
