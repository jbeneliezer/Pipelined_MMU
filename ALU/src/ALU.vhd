-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\SIMD\ALU\src\ALU.vhd
-- Generated   : Tue Mar 23 15:35:33 2021
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
--{entity {ALU} architecture {behavior}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;		 

entity ALU is
	port(					
		 Op : in STD_LOGIC_VECTOR(24 downto 0);
		 A : in STD_LOGIC_VECTOR(127 downto 0);
		 B : in STD_LOGIC_VECTOR(127 downto 0);
		 C : in STD_LOGIC_VECTOR(127 downto 0);
		 Rd : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture behavioral of ALU is
	component MULT_ADD_I is
	 	port(
		 	x : in STD_LOGIC_VECTOR(15 downto 0);
		 	y : in STD_LOGIC_VECTOR(15 downto 0);
		 	z : in STD_LOGIC_VECTOR(31 downto 0);
		 	result : out STD_LOGIC_VECTOR(31 downto 0)
			);
	end component;
	
	component MULT_SUB_I is
	 	port(
			x: in STD_LOGIC_VECTOR(15 downto 0);
			y : in STD_LOGIC_VECTOR(15 downto 0);
			z : in STD_LOGIC_VECTOR(31 downto 0);
			result : out STD_LOGIC_VECTOR(31 downto 0)
			);
	end component;	
	
	component MULT_ADD_L is
	 	port(
		 	x : in STD_LOGIC_VECTOR(31 downto 0);
		 	y : in STD_LOGIC_VECTOR(31 downto 0);
		 	z : in STD_LOGIC_VECTOR(63 downto 0);
		 	result : out STD_LOGIC_VECTOR(63 downto 0)
			);
	end component;	
	
	component MULT_SUB_L is
	 	port(
			x : in STD_LOGIC_VECTOR(31 downto 0);
			y : in STD_LOGIC_VECTOR(31 downto 0);
			z : in STD_LOGIC_VECTOR(63 downto 0);
			result : out STD_LOGIC_VECTOR(63 downto 0)
		    );
end component;
	
begin					   
	case Op(24 downto 15) is
		when "0---------" => --li
			process (all)
			begin
				case Op(23 downto 21) is
					when "000" => Rd(15 downto 0) <= Op(20 downto 5);
					when "001" => Rd(31 downto 16) <= Op(20 downto 5);
					when "010" => Rd(47 downto 32) <= Op(20 downto 5);
					when "011" => Rd(63 downto 48) <= Op(20 downto 5);
					when "100" => Rd(79 downto 64) <= Op(20 downto 5);
					when "101" => Rd(95 downto 80) <= Op(20 downto 5);
					when "110" => Rd(111 downto 96) <= Op(20 downto 5);
					when "111" => Rd(127 downto 112) <= Op(20 downto 5);
				end case;
			end process;
		when "10000-----" => --SIMALS
			SIMALS_0: MULT_ADD_I port map (x => A(15 downto 0), y => B(15 downto 0), z => C(31 downto 0), result => Rd(31 downto 0));
			SIMALS_1: MULT_ADD_I port map (x => A(47 downto 32), y => B(47 downto 32), z => C(63 downto 32), result => Rd(63 downto 32));
			SIMALS_2: MULT_ADD_I port map (x => A(79 downto 64), y => B(79 downto 64), z => C(95 downto 64), result => Rd(95 downto 64));
			SIMALS_3: MULT_ADD_I port map (x => A(111 downto 96), y => B(111 downto 96), z => C(127 downto 96), result => Rd(127 downto 96));
		when "10001-----" => --SIMAHS
			SIMAHS_0: MULT_ADD_I port map (x => A(31 downto 16), y => B(31 downto 16), z => C(31 downto 0), result => Rd(31 downto 0));
			SIMAHS_1: MULT_ADD_I port map (x => A(63 downto 48), y => B(63 downto 48), z => C(63 downto 32), result => Rd(63 downto 32));
			SIMAHS_2: MULT_ADD_I port map (x => A(95 downto 80), y => B(95 downto 80), z => C(95 downto 64), result => Rd(95 downto 64));
			SIMAHS_3: MULT_ADD_I port map (x => A(127 downto 112), y => B(127 downto 112), z => C(127 downto 96), result => Rd(127 downto 96));
		when "10010-----" => --SIMSLS
			SIMSLS_0: MULT_SUB_I port map (x => A(15 downto 0), y => B(15 downto 0), z => C(31 downto 0), result => Rd(31 downto 0));
			SIMSLS_1: MULT_SUB_I port map (x => A(47 downto 32), y => B(47 downto 32), z => C(63 downto 32), result => Rd(63 downto 32));
			SIMSLS_2: MULT_SUB_I port map (x => A(79 downto 64), y => B(79 downto 64), z => C(95 downto 64), result => Rd(95 downto 64));
			SIMSLS_3: MULT_SUB_I port map (x => A(111 downto 96), y => B(111 downto 96), z => C(127 downto 96), result => Rd(127 downto 96));
		when "10011-----" => --SIMSHS
			SIMSHS_0: MULT_SUB_I port map (x => A(31 downto 16), y => B(31 downto 16), z => C(31 downto 0), result => Rd(31 downto 0));
			SIMSHS_1: MULT_SUB_I port map (x => A(63 downto 48), y => B(63 downto 48), z => C(63 downto 32), result => Rd(63 downto 32));
			SIMSHS_2: MULT_SUB_I port map (x => A(95 downto 80), y => B(95 downto 80), z => C(95 downto 64), result => Rd(95 downto 64));
			SIMSHS_3: MULT_SUB_I port map (x => A(127 downto 112), y => B(127 downto 112), z => C(127 downto 96), result => Rd(127 downto 96));
		when "10100-----" => --SLIMALS
			SLIMALS_0: MULT_ADD_L port map (x => A(31 downto 0), y => B(31 downto 0), z => C(63 downto 0), result => Rd(63 downto 0));
			SLIMALS_1: MULT_ADD_L port map (x => A(95 downto 64), y => B(95 downto 64), z => C(127 downto 64), result => Rd(127 downto 64));
		when "10101-----" => --SLIMAHS
			SLIMAHS_0: MULT_ADD_L port map (x => A(63 downto 32), y => B(63 downto 32), z => C(63 downto 0), result => Rd(63 downto 0));
			SLIMAHS_1: MULT_ADD_L port map (x => A(127 downto 96), y => B(127 downto 96), z => C(127 downto 64), result => Rd(127 downto 64));
		when "10110-----" => --SLIMSLS
			SLIMSLS_0: MULT_SUB_L port map (x => A(31 downto 0), y => B(31 downto 0), z => C(63 downto 0), result => Rd(63 downto 0));
			SLIMSLS_1: MULT_SUB_L port map (x => A(95 downto 64), y => B(95 downto 64), z => C(127 downto 64), result => Rd(127 downto 64));
		when "10111-----" => --SLIMSHS
			SLIMSHS_0: MULT_SUB_L port map (x => A(63 downto 32), y => B(63 downto 32), z => C(63 downto 0), result => Rd(63 downto 0));
			SLIMSHS_1: MULT_SUB_L port map (x => A(127 downto 96), y => B(127 downto 96), z => C(127 downto 64), result => Rd(127 downto 64));
		when "11----0000" => --NOP
			null;
		when "11----0001" => --AU
			Rd(31 downto 0) <= std_logic_vector(unsigned(A(31 downto 0)) + unsigned(B(31 downto 0)));
			Rd(63 downto 32) <= std_logic_vector(unsigned(A(63 downto 32)) + unsigned(B(63 downto 32)));
			Rd(95 downto 64) <= std_logic_vector(unsigned(A(95 downto 64)) + unsigned(B(95 downto 64)));
			Rd(127 downto 96) <= std_logic_vector(unsigned(A(127 downto 96)) + unsigned(B(127 downto 96)));
		when "11----0010" => --ABSDB
			
		when "11----0011" => --AHU
		when "11----0100" => --AHS
		when "11----0101" => --AND
		when "11----0110" => --BCW
		when "11----0111" => --MAXWS
		when "11----1000" => --MINWS
		when "11----1001" => --MLHU
		when "11----1010" => --MLHCU
		when "11----1011" => --OR
		when "11----1100" => --PCNTW
		when "11----1101" => --ROTW
		when "11----1110" => --SFHS
		when "11----1111" => --SFW
	end case;	
end behavioral;
