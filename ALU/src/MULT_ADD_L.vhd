-------------------------------------------------------------------------------
--
-- Title       : MULT_ADD_L
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\MULT_ADD_L.vhd
-- Generated   : Wed Mar 24 21:28:38 2021
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

entity MULT_ADD_L is
	 port(
		 x : in STD_LOGIC_VECTOR(31 downto 0);
		 y : in STD_LOGIC_VECTOR(31 downto 0);
		 z : in STD_LOGIC_VECTOR(63 downto 0);
		 result : out STD_LOGIC_VECTOR(63 downto 0)
	     );
end MULT_ADD_L;									

architecture behavioral of MULT_ADD_L is 
	constant max64 : signed := "0111111111111111111111111111111111111111111111111111111111111111";		-- max 64 bit signed number
	constant min64 : signed := "1000000000000000000000000000000000000000000000000000000000000000";		-- min 64 bit signed number
	signal product: signed (63 downto 0);
	signal sum: signed (63 downto 0);
begin
	compute: process (x, y, z)
	begin
		product <= signed(x) * signed(y);																-- compute x * y
		sum <= product + signed(z);																		-- compute product + z
	end process;
	
	sat: process (sum)	  
	begin					   												
		if (product(63) = z(63) and not z(63) = sum(63) and sum(63) = '1') then							-- check for overflow
			sum <= max64;															
		elsif (product(63) = z(63) and not z(63) = sum(63) and sum(63) = '0') then						-- check for underflow
			sum <= min64;																
		end if;
		result <= std_logic_vector(sum);
	end process;
end behavioral;
