-------------------------------------------------------------------------------
--
-- Title       : FU
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\FU.vhd
-- Generated   : Tue Apr 13 16:58:52 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Forwarding Unit
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.data_types.all;

entity FU is
	port(									  
		addr: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(127 downto 0);
		input: in idex;
		output: out idex
		);
end FU;

architecture behavioral of FU is
begin
	process (all)
	begin
		if input.Op(24) = '0' or input.Op = nop then
			output <= input;
		else
			if addr = input.Op(9 downto 5) then
				output.rs1 <= write_data;
			else
				output.rs1 <= input.rs1;
			end if;
			if addr = input.Op(14 downto 10) then
				output.rs2 <= write_data;
			else
				output.rs2 <= input.rs2;
			end if;
			if addr = input.Op(19 downto 15) then
				output.rs3 <= write_data;
			else
				output.rs3 <= input.rs3;
			end if;
			output.Op <= input.Op;
		end if;
	end	process;  
end behavioral;
