-------------------------------------------------------------------------------
--
-- Title       : MMU_tb
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\MMU_tb.vhd
-- Generated   : Mon May  3 20:31:48 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for MMU
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_Std.all; 
use std.textio.all;
use std.env.finish;
use work.data_types.all; 

entity MMU_tb is
end;

architecture bench of MMU_tb is
	
	component MMU
		port(
			clk : in std_logic;
			rst: in std_logic;
			input: in vec_array(0 to 63)(24 downto 0);
			output: out result;
			output_rf: out vec_array(0 to 31)(127 downto 0)
			);
	end component;
	
	signal clk: std_logic;
	signal rst: std_logic; 
	signal input: vec_array(0 to 63)(24 downto 0) := (others => (others => '0'));
	signal output: result;
	signal outputs: results(0 to 63);	
	signal output_rf: vec_array(0 to 31)(127 downto 0) := (others => (others => '0'));
begin
	
	uut: MMU port map (clk => clk, rst => rst, input => input, output => output, output_rf => output_rf);
	
	read_file: process
		file file_in : text open read_mode is "stimulus.txt";
		variable row: line;
		variable test_input: vec_array(0 to 63)(24 downto 0) := (others => (others => '0'));
		variable i: integer := 0;
	begin		   									   
		while not endfile(file_in) and i < 64 loop 
			readline(file_in, row);
			read(row, test_input(i));
			i := i + 1;
		end loop; 
		
		file_close(file_in);
		input <= test_input;
		
		wait;
				
	end process;
	
	clock: process				
	begin
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait for 10 ns;
		for i in 0 to 63 loop
			clk <= '1';
			if (i < 64) then
				outputs(i) <= output;
			end if;
			wait for 5 ns;
			clk <= '0';
			wait for 5 ns;
		end loop;
		rst <= '1';
		wait;
	end process;
	
	write_file: process
		file file_out : text open write_mode is "results.txt";
		variable row: line;	   
	begin
		wait until rst = '0';
		wait until rst = '1';		
		write(row, "PC ", left, 3);	
		write(row, "instr0 ", left, 8);
		write(row, "instr1 ", left, 8);
		write(row, "instr2 ", left, 8);
		write(row, "e ", left, 2); 
		write(row, "wa ", left, 3);
		write(row, "write_data ", left, 33); 
		writeline(file_out, row);
		writeline(file_out, row);
		for i in 0 to 63 loop
			
			-- write basic signals
			hwrite(row, outputs(i).PC, left, 2);
			write(row, " ", left, 1);
			hwrite(row, outputs(i).instr0, left, 7); 
			write(row, " ", left, 1);
			hwrite(row, outputs(i).instr1, left, 7);  
			write(row, " ", left, 1);
			hwrite(row, outputs(i).fu_in.op, left, 7); 
			write(row, " ", left, 1);
			write(row, outputs(i).wb_out.write_en, left, 1);
			write(row, " ", left, 1);	  
			hwrite(row, outputs(i).wb_out.op(4 downto 0), left, 2);
			write(row, " ", left, 1);
			hwrite(row, outputs(i).wb_out.data, left, 32);
			writeline(file_out, row);
			
			-- write rf_out
			write(row, " ", left, 4);
			write(row, "rf_out ", right, 7);
			hwrite(row, outputs(i).rf_out.rs1, left, 32);
			write(row, " ", left, 1);
			hwrite(row, outputs(i).rf_out.rs2, left, 32);
			write(row, " ", left, 1);
			hwrite(row, outputs(i).rf_out.rs3, left, 32);
			writeline(file_out, row);
			
			-- write fu_in
			write(row, " ", left, 4);
			write(row, "fu_in ", right, 7);
			hwrite(row, outputs(i).fu_in.rs1, left, 32);	
			write(row, " ", left, 1);
			hwrite(row, outputs(i).fu_in.rs2, left, 32);
			write(row, " ", left, 1);
			hwrite(row, outputs(i).fu_in.rs3, left, 32);
			writeline(file_out, row);
			
			-- write alu_in
			write(row, " ", left, 4);
			write(row, "alu_in ", right, 7);
			hwrite(row, outputs(i).alu_in.rs1, left, 32); 
			write(row, " ", left, 1);
			hwrite(row, outputs(i).alu_in.rs2, left, 32); 
			write(row, " ", left, 1);
			hwrite(row, outputs(i).alu_in.rs3, left, 32);
			writeline(file_out, row);
			
			-- write alu_out   
			write(row, " ", left, 3);
			write(row, "alu_out ", right, 8);
			hwrite(row, outputs(i).alu_out, left, 32);
			writeline(file_out, row);
			writeline(file_out, row);
			
			
		end loop;  
		
		writeline(file_out, row);
		for i in 0 to 31 loop
			hwrite(row, output_rf(i), left, 32);
			writeline(file_out, row);
		end loop;
		
		file_close(file_out);
		
		wait for 10 ns;
		
		finish;
		
	end process;
	
end;
