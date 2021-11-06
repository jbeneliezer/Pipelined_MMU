-------------------------------------------------------------------------------
--
-- Title       : IB
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\IB.vhd
-- Generated   : Mon May  3 20:54:27 2021
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
use work.data_types.all;

entity IB is
	 port(
		 clk : in std_logic;
		 rst: in std_logic;
		 index: std_logic_vector(5 downto 0);
		 instruction_in: in vec_array(0 to 63)(24 downto 0);
		 instruction_out: out std_logic_vector(24 downto 0)
	     );
end IB;

architecture behavioral of IB is
	signal f: vec_array(0 to 63)(24 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '1' then
			f <= instruction_in;
		elsif rising_edge(clk) then
			instruction_out <= instruction_in(to_integer(unsigned(index)));
		end if;
	end process; 
end behavioral;
