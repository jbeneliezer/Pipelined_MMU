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

library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.data_types.all;

entity RF is
	port(				  
		write_en: in std_logic;
		li: in std_logic;
		read_addr_0: in std_logic_vector(4 downto 0);
		read_addr_1: in std_logic_vector(4 downto 0);
		read_addr_2: in std_logic_vector(4 downto 0); 
		write_addr: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(127 downto 0);
		rs1: out std_logic_vector(127 downto 0);
		rs2: out std_logic_vector(127 downto 0);
		rs3: out std_logic_vector(127 downto 0)   
		);
end RF;									   

architecture behavioral of RF is								  
begin
	write: process 
	variable f: vec_array(0 to 31)(127 downto 0) := (others => z128);
	begin 
		while true loop
			wait until write_en = '1' or li = '1' or read_addr_0'event or read_addr_1'event or read_addr_2'event or
			write_addr'event or write_data'event;
			rs1 <= f(to_integer(unsigned(read_addr_0)));
			rs2 <= f(to_integer(unsigned(read_addr_1)));
			rs3 <= f(to_integer(unsigned(read_addr_2)));
			if write_en = '1' then
				if li = '1' then
					f(to_integer(unsigned(write_addr))) := f(to_integer(unsigned(write_addr))) or write_data;
				else
					f(to_integer(unsigned(write_addr))) := write_data;
				end if;
			end if;
		end loop;

	end process; 	  
	
end behavioral;
