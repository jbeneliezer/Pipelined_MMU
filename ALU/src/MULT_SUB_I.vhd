-------------------------------------------------------------------------------
--
-- Title       : MULT_SUB_I
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\MULT_SUB_I.vhd
-- Generated   : Wed Mar 24 20:55:59 2021
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

entity MULT_SUB_I is
	 port(
		 x : in STD_LOGIC_VECTOR(15 downto 0);
		 y : in STD_LOGIC_VECTOR(15 downto 0);
		 z : in STD_LOGIC_VECTOR(31 downto 0);
		 result : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end MULT_SUB_I;								

architecture behavioral of MULT_SUB_I is
	constant max32: signed := "01111111111111111111111111111111";					   		-- max signed 32 bit number
	constant min32: signed := "10000000000000000000000000000000";							-- min signed 32 bit number
	signal product: signed (31 downto 0);
	signal dif: signed (31 downto 0);
begin	  
	compute: process (x, y, z)
	begin
		product <= signed(x) * signed(y);													-- compute x * y
		dif <= signed(z) - product;															-- compute z - product
	end process;
	
	sat: process (dif)
	begin							  
		if (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '1') then			-- check for overflow
			dif <= max32;
		elsif (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '0') then		-- check for underflow
			dif <= min32;
		end if;
		result <= std_logic_vector(dif);
	end process;

end behavioral;
