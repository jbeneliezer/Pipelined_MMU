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
		 Op : in std_logic_vector(24 downto 0);
		 Rd: in std_logic_vector(127 downto 0);
		 write_en: out std_logic;
		 li: out std_logic;
		 addr: out std_logic_vector(4 downto 0);
		 data: out std_logic_vector(127 downto 0)
	     );
end EX_WB;									

architecture behavioral of EX_WB is
begin	
	process(rst, clk)
	begin 
		if rst = '1' then
			write_en <= '0';
			addr <= "00000";
			data <= z128;
		elsif clk = '1' then
			if Op = nop then
				write_en <= '0';
			else
				write_en <= '1';
			end if;
			if Op(24) = '0' then
				li <= '1';
			else
				li <= '0';
			end if;
			addr <= Op(4 downto 0);
			data <= Rd;
		end if;
	end process;

end behavioral;
