-------------------------------------------------------------------------------
--
-- Title       : data_types
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\REG_file.vhd
-- Generated   : Tue Apr 6 16:26:19 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : some custom types
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package data_types is
	
	type vec_array is array(natural range<>) of std_logic_vector;
	
	type idex is record
		Op	:	std_logic_vector(24 downto 0);
		rs1	:	std_logic_vector(127 downto 0);
		rs2	:	std_logic_vector(127 downto 0);
		rs3	:	std_logic_vector(127 downto 0);
	end record idex;
	
	constant z128: std_logic_vector(127 downto 0) := (others => '0');
	
	constant nop: std_logic_vector(24 downto 0) := "1100000000000000000000000";
	
	constant idex_clr: idex := (Op => nop,
							rs1 => z128,
							rs2 => z128,
							rs3 => z128);
	
end package data_types;
