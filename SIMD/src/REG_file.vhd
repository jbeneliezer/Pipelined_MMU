														  -------------------------------------------------------------------------------
--
-- Title       : REG_file
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\REG_file.vhd
-- Generated   : Tue Apr  6 16:26:19 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Register file type
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package REG_file is
 	type REG_file is array(31 downto 0) of std_logic_vector(127 downto 0);	
end package REG_file;
