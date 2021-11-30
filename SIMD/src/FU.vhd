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
		Op: in std_logic_vector(24 downto 0);
		addr: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(127 downto 0);
		rs_in: in vec_array(0 to 2)(127 downto 0);
		rs_out: out vec_array(0 to 2)(127 downto 0)
		);
end FU;

architecture behavioral of FU is
begin
	process (all)
	begin
		if Op(24) = '0' or Op = nop then
			rs_out <= rs_in;
		else
			if addr = Op(9 downto 5) then
				rs_out(0) <= write_data;
			else
				rs_out(0) <= rs_in(0);
			end if;
			if addr = Op(14 downto 10) then
				rs_out(1) <= write_data;
			else
				rs_out(1) <= rs_in(1);
			end if;
			if addr = Op(19 downto 15) then
				rs_out(2) <= write_data;
			else
				rs_out(2) <= rs_in(2);
			end if;
		end if;
	end	process;  
end behavioral;
