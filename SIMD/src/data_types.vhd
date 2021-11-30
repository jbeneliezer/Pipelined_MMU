-------------------------------------------------------------------------------
--
-- Title       : data_types
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\REG_file.vhd
-- Generated   : Tue Apr 6 16:26:19 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : some custom types
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package data_types is
	
	type vec_array is array(natural range<>) of std_logic_vector;
	
	type idex is record
		Op	:	std_logic_vector(24 downto 0);
		rs1	:	std_logic_vector(127 downto 0);
		rs2	:	std_logic_vector(127 downto 0);
		rs3	:	std_logic_vector(127 downto 0);
	end record idex;
	
	type int_array is array(integer range<>) of integer;
	
	type test is record
		Op	:	std_logic_vector(24 downto 0);
		rs1	:	std_logic_vector(127 downto 0);
		rs2	:	std_logic_vector(127 downto 0);
		rs3	:	std_logic_vector(127 downto 0);
		Rd	:	std_logic_vector(127 downto 0);
	end record test;
	
	type result is record
		PC: std_logic_vector(5 downto 0);
		
		-- IB Signals 
		instr0: std_logic_vector(24 downto 0);
		
		-- RF Signals
		instr1: std_logic_vector(24 downto 0); 
		rf_out: vec_array(0 to 2)(127 downto 0);
		write_en: std_logic;
		write_data: std_logic_vector(127 downto 0); 
		write_addr: std_logic_vector(4 downto 0);
		
		-- FU Signals
		instr2: std_logic_vector(24 downto 0);
		fu_in: vec_array(0 to 2)(127 downto 0);
		
		-- ALU Signals
		alu_in: vec_array(0 to 2)(127 downto 0);
		alu_out: std_logic_vector(127 downto 0);
	end record result;
	
	type results is array(natural range<>) of result;						 
	
	constant nop: std_logic_vector(24 downto 0) := "1100000000000000000000000";
	
	constant idex_clr: idex := (Op => nop,
							rs1 => (others => '0'),
							rs2 => (others => '0'),
							rs3 => (others => '0'));
	
end package data_types;
