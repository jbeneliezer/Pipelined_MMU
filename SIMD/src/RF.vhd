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

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;  
use work.data_types.all;

entity RF is
	port(				  
		write_en: in std_logic;
		Op: in std_logic_vector(24 downto 0);
		write_addr: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(127 downto 0);
		rs1: out std_logic_vector(127 downto 0);
		rs2: out std_logic_vector(127 downto 0);
		rs3: out std_logic_vector(127 downto 0);
		output_rf: out vec_array(0 to 31)(127 downto 0)
		);
end RF;									   

architecture behavioral of RF is								  
begin
	write: process 
	variable f: vec_array(0 to 31)(127 downto 0) := (others => (others => '0'));
	begin 
		while true loop
			wait until write_en = '1' or Op'event or write_addr'event or write_data'event;
			rs1 <= f(to_integer(unsigned(Op(9 downto 5)))) when Op(24) = '1' else f(to_integer(unsigned(Op(4 downto 0))));
			rs2 <= f(to_integer(unsigned(Op(14 downto 10))));
			rs3 <= f(to_integer(unsigned(Op(19 downto 15))));
			if write_en = '1' then	
				f(to_integer(unsigned(write_addr))) := write_data;	
			end if;	
			output_rf <= f;
		end loop;
				 
	end process; 	  
	
end behavioral;
