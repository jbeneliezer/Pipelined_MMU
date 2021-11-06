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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.data_types.all;

entity FU is
	port( 
		Op: in std_logic_vector(24 downto 0);
		rs1: out std_logic_vector(4 downto 0);
		rs2: out std_logic_vector(4 downto 0);
		rs3: out std_logic_vector(4 downto 0);
		Op_out: out std_logic_vector(24 downto 0)
		);
end FU;

architecture behavioral of FU is	    
begin
	process(Op)
	begin 
		if (Op(24) = '0') then
			null;
		else
			if (Op(23) = '0') then
				rs3 <= Op(19 downto 15);
			end if;	 
			rs2 <= Op(14 downto 10);
			rs1 <= Op(9 downto 5);
		end if;
		Op_out <= Op;
	end	process;  
end behavioral;
