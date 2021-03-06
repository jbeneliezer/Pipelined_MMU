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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.data_types.all;

entity IB is
	 port(			 
		 rst: in std_logic;
		 index: in std_logic_vector(5 downto 0);
		 program: in vec_array(0 to 63)(24 downto 0);
		 instruction_out: out std_logic_vector(24 downto 0)
	     );
end IB;

architecture behavioral of IB is
	signal f: vec_array(0 to 63)(24 downto 0) := (others => nop);
begin
	reset: process(rst)
	begin
		if rst = '1' then
			f <= program;
		end if;
	end process;

	instruction_out <= f(to_integer(unsigned(index)));

end behavioral;
