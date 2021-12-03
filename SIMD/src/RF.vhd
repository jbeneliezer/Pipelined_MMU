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
		op: in std_logic_vector(24 downto 0);
		write_addr: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(127 downto 0);
		output: out idex;
		output_rf: out vec_array(0 to 31)(127 downto 0)
		);
end RF;									   

architecture behavioral of RF is
	signal f: vec_array(0 to 31)(127 downto 0) := (others => (others => '0'));								  
begin
	write: process (all)													   
	begin  	
		-- write data
		if write_en = '1' then	
			f(to_integer(unsigned(write_addr))) <= write_data;	   
		end if;
		
		-- read data
		output.op <= op;
		output.rs1 <= f(to_integer(unsigned(op(9 downto 5)))) when op(24) = '1' else f(to_integer(unsigned(op(4 downto 0))));
		output.rs2 <= f(to_integer(unsigned(op(14 downto 10))));
		output.rs3 <= f(to_integer(unsigned(op(19 downto 15))));   
		
		-- output state
		output_rf <= f;	
				 
	end process; 	  
	
end behavioral;
