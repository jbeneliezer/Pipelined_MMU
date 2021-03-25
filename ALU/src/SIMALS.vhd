-------------------------------------------------------------------------------
--
-- Title       : SIMALS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SIMALS.vhd
-- Generated   : Wed Mar 24 23:01:34 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {SIMALS} architecture {structural}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SIMALS is
	port(	 
		 clk: in STD_LOGIC;
		 op: in STD_LOGIC_VECTOR(9 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
		 );
end SIMALS;

--}} End of automatically maintained section

architecture structural of SIMALS is
	signal res: std_logic_vector(127 downto 0);
	component MULT_ADD_I is
	 	port(
		 	x : in STD_LOGIC_VECTOR(15 downto 0);
		 	y : in STD_LOGIC_VECTOR(15 downto 0);
			z : in STD_LOGIC_VECTOR(31 downto 0);
			result : out STD_LOGIC_VECTOR(31 downto 0)
		    );
	end component;
begin
	SIMALS_0: MULT_ADD_I port map (x => i(15 downto 0), y => j(15 downto 0), z => k(31 downto 0), result => res(31 downto 0));
	SIMALS_1: MULT_ADD_I port map (x => i(47 downto 32), y => j(47 downto 32), z => k(63 downto 32), result => res(63 downto 32));
	SIMALS_2: MULT_ADD_I port map (x => i(79 downto 64), y => j(79 downto 64), z => k(95 downto 64), result => res(95 downto 64));
	SIMALS_3: MULT_ADD_I port map (x => i(111 downto 96), y => j(111 downto 96), z => k(127 downto 96), result => res(127 downto 96));
	process (all)
	begin
		if (clk'event and clk = '1' and op = "10000-----") then
			r <= res;
		end if;
	end process;  
end structural;
