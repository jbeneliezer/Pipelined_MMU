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

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MULT_ADD_I} architecture {MULT_ADD_I}}

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
	constant max32: signed := "01111111111111111111111111111111";
	constant min32: signed := "10000000000000000000000000000000";
begin
	process (all)
		variable product: signed (31 downto 0);
		variable sum: signed (31 downto 0);
		variable sign: std_logic;
	begin
		product := signed(x) * signed(y);
		sign :=  product(31);
		sum := product + signed(z);
		if (sign = z(31) and not z(31) = sum(31) and sign = '1') then
			sum := max32;
		elsif (sign = z(31) and not z(31) = sum(31) and sign = '0') then
			sum := min32;
		end if;
		result <= std_logic_vector(sum);
	end process;

end behavioral;
