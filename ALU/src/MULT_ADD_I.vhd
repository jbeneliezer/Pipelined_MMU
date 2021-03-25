-------------------------------------------------------------------------------
--
-- Title       : MULT_ADD_I
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\MULT_ADD_I.vhd
-- Generated   : Wed Mar 24 20:49:43 2021
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

entity MULT_ADD_I is
	 port(
		 x : in STD_LOGIC_VECTOR(15 downto 0);
		 y : in STD_LOGIC_VECTOR(15 downto 0);
		 z : in STD_LOGIC_VECTOR(31 downto 0);
		 result : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end MULT_ADD_I;								 

architecture behavioral of MULT_ADD_I is
	constant max32: signed := "01111111111111111111111111111111";		  			-- max 32 bit signed number
	constant min32: signed := "10000000000000000000000000000000";		  			-- min 32 bit signed number
	signal product: signed (31 downto 0);
	signal sum: signed (31 downto 0);
begin
	compute: process (x, y, z)
	begin
		product <= signed(x) * signed(y);											-- compute x * y
		sum <= product + signed(z);													-- compute product + z
	end process;
	
	sat: process (sum)	  
	begin					   												
		if (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '1') then		-- check for overflow
			sum <= max32;															
		elsif (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '0') then	-- check for underflow
			sum <= min32;															
		end if;
		result <= std_logic_vector(sum);
	end process;

end behavioral;
