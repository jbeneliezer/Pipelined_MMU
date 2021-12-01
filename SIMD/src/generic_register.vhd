-------------------------------------------------------------------------------
--
-- Title       : generic_register
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\generic_register.vhd
-- Generated   : Wed Dec 1 12:42:18 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Generic register.
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity generic_register is
	generic(
		type t;
		constant clr: t
	);
	port(
		clk: in std_logic;
		rst: in std_logic;
		D: in t;
		Q: out t
	);
end entity generic_register; 

architecture behavioral of generic_register is
begin
	process (clk, rst)
	begin
		if rst = '1' then
			Q <= clr;  			-- reset 
		elsif clk = '1' then
			Q <= D;				-- set
		end if;
	end process; 
end behavioral;

	