-------------------------------------------------------------------------------
--
-- Title       : EX_WB
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\EX_WB.vhd
-- Generated   : Mon May  3 20:47:49 2021
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
use work.data_types.all;

entity EX_WB is
	 port(
		 clk : in std_logic;
		 rst : in std_logic;
		 D : in std_logic_vector(127 downto 0);
		 Q: out std_logic_vector(127 downto 0)
	     );
end EX_WB;									

architecture behavioral of EX_WB is
begin
	
	process(clk, rst)
	begin
		if rst = '1' then
			Q <= z128;  	-- reset
		elsif rising_edge(clk) then
			Q <= D;					-- set
		end if;
	end process;

end behavioral;
