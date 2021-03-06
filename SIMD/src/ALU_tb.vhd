-------------------------------------------------------------------------------
--
-- Title       : ALU_tb
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\src\ALU_tb.vhd
-- Generated   : Sun Oct 24 05:05:42 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  testbench for ALU
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.data_types.all;

entity ALU_tb is
end ALU_tb;							  

architecture ALU_tb of ALU_tb is
signal current_test: test;
signal result: std_logic_vector(127 downto 0);

component ALU is
	port(					
		input: in idex;
		rd : out std_logic_vector(127 downto 0)
		);
end component ALU;
begin
	
	uut: ALU port map (input.op => current_test.op,
						input.rs1 => current_test.rs1,
						input.rs2 => current_test.rs2,
						input.rs3 => current_test.rs3, 
						rd => result);
	
	read_file: process
		file input : text;
		variable row: line;
		variable test_input: test;
		variable space: character;
	begin
		file_open(input, "stimulus.txt", read_mode);
		while not endfile(input) loop 
			readline(input, row);
			read(row, test_input.op);
			read(row, space);
			read(row, test_input.rs1);
			read(row, space);
			read(row, test_input.rs2);
			read(row, space);
			read(row, test_input.rs3);
			read(row, space);
			read(row, test_input.rd);
			
			current_test <= test_input;
			
			wait for 20 ns;
		end loop; 
		
		file_close(input);
		
		wait;
		
	end process;
	
	verify: process(result)
	begin
		assert(result = current_test.rd) report "Error for input " & to_string(current_test.Op) severity error;
	end process;
					 
end ALU_tb;
