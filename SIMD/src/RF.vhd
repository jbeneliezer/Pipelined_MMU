-------------------------------------------------------------------------------
--
-- Title       : RF
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\RF.vhd
-- Generated   : Mon May  3 18:25:28 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Register file
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.data_types.all;

entity RF is
	port(
		clk: in std_logic;
		write_en: in std_logic;
		read_addr_0: in std_logic_vector(4 downto 0);
		read_addr_1: in std_logic_vector(4 downto 0);
		read_addr_2: in std_logic_vector(4 downto 0); 
		write_addr: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(127 downto 0);
		read_data_0: out std_logic_vector(127 downto 0);
		read_data_1: out std_logic_vector(127 downto 0);
		read_data_2: out std_logic_vector(127 downto 0)
		);
end RF;									   

architecture behavioral of RF is
	signal f: vec_array(0 to 31)(127 downto 0);
begin
	write: process
	begin
		if write_en = '1' then
			f(to_integer(unsigned(write_addr))) <= write_data;
		end if;
	end process;
		  
	read_data_0 <= f(to_integer(unsigned(read_addr_0)));
	read_data_1 <= f(to_integer(unsigned(read_addr_1)));
	read_data_2 <= f(to_integer(unsigned(read_addr_2)));
end behavioral;
