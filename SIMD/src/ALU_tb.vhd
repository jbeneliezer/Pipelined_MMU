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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use work.all; 
use work.data_types.all;

entity ALU_tb is
end ALU_tb;							  

architecture ALU_tb of ALU_tb is
signal current_test: test;
signal result: std_logic_vector(127 downto 0);

component ALU is
	port(					
		Op : in STD_LOGIC_VECTOR(24 downto 0);
		rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		Rd : out STD_LOGIC_VECTOR(127 downto 0)
		);
end component ALU;
begin
	
	uut: ALU port map (Op => current_test.Op,
						rs1 => current_test.rs1,
						rs2 => current_test.rs2,
						rs3 => current_test.rs3,
						Rd => result);
	
	read_file: process
		file input : text;
		variable row: line;
		variable index: int_array(0 to 24);
		variable test_input: test;
		variable space: character;
	begin
		file_open(input, "stimulus.txt", read_mode);
		while not endfile(input) loop 
			readline(input, row);
			read(row, test_input.Op);
			read(row, space);
			read(row, test_input.rs1);
			read(row, space);
			read(row, test_input.rs2);
			read(row, space);
			read(row, test_input.rs3);
			read(row, space);
			read(row, test_input.Rd);
			
			current_test <= test_input;
			
			wait for 60 ns;
		end loop; 
		
		file_close(input);
	end process;
	
	verify: process(result)
	begin
		assert(result = current_test.Rd) report "Error for input " & to_string(current_test.Op) severity error;
	end process;
					 
end ALU_tb;
