-------------------------------------------------------------------------------
--
-- Title       : RF
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\RF.vhd
-- Generated   : Tue Apr  6 16:26:19 2021
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

entity RF is
	port(
		read1 : out STD_LOGIC_VECTOR(127 downto 0);
		read2 : out STD_LOGIC_VECTOR(127 downto 0);
		read3 : out STD_LOGIC_VECTOR(127 downto 0);
		write : in STD_LOGIC_VECTOR(127 downto 0)
		);	 		
end RF;				  

architecture behavioral of RF is   
	type file is array (32 downto 0) of std_logic_vector(127 downto 0);
	signal rf: file;
begin	
	
end behavioral;
