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

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MULT_ADD_L} architecture {behavioral}}

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

--}} End of automatically maintained section

architecture behavioral of MULT_ADD_L is 
	constant max64 : signed := "0111111111111111111111111111111111111111111111111111111111111111";
	constant min64 : signed := "1000000000000000000000000000000000000000000000000000000000000000";
begin
	process (all)
		variable product: signed (63 downto 0);
		variable sum: signed (63 downto 0);
		variable sign: std_logic;
	begin
		product := signed(x) * signed(y);
		sign :=  product(63);
		sum := product + signed(z);
		if (sign = z(63) and not z(63) = sum(63) and sign = '1') then
			sum := max64;
		elsif (sign = z(63) and not z(63) = sum(63) and sign = '0') then
			sum := min64;
		end if;						  
		result <= std_logic_vector(sum);
	end process;
end behavioral;
