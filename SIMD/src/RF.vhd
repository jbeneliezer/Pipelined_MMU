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
		en: in std_logic;
		i_get0: in std_logic_vector(4 downto 0);
		i_get1: in std_logic_vector(4 downto 0);
		i_get2: in std_logic_vector(4 downto 0); 
		i_send: in std_logic_vector(4 downto 0);
		D: in std_logic_vector(127 downto 0);
		Q0: out std_logic_vector(127 downto 0);
		Q1: out std_logic_vector(127 downto 0);
		Q2: out std_logic_vector(127 downto 0)
		);
end RF;									   

architecture behavioral of RF is
	signal f: vec_array(0 to 31)(127 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) and en = '1' then
			f(to_integer(unsigned(i_send))) <= D;
		end if;
	end process;
		  
	Q0 <= f(to_integer(unsigned(i_get0)));
	Q1 <= f(to_integer(unsigned(i_get1)));
	Q2 <= f(to_integer(unsigned(i_get2)));
end behavioral;
