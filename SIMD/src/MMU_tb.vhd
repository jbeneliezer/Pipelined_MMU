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
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.data_types.all;
use std.textio.all;

entity MMU_tb is
end;

architecture bench of MMU_tb is
	
	component MMU
		port(
			clk : in std_logic;
			rst: in std_logic;
			input: in vec_array(0 to 63)(24 downto 0);
			output: out vec_array(0 to 63)(127 downto 0)
			);
	end component;
	
	signal clk: std_logic;
	signal rst: std_logic; 
	signal input: vec_array(0 to 63)(24 downto 0);
	signal output: vec_array(0 to 63)(127 downto 0);
		
	constant clock_period: time := 10 ns;
	signal stop_the_clock: std_logic;
	
begin
	
	uut: MMU port map (clk => clk, rst => rst, input => input);
	
	stop_the_clock <= '1';
	
	FILE_IN : process
		file text_file : text open read_mode is "stimulus.txt";
		variable text_line : line;
		variable index: integer := 0;
		variable data: vec_array(0 to 63)(24 downto 0);
	begin
		while not endfile(text_file) loop
			readline(text_file, text_line);	
			if text_line.all'length = 0 then
				next;
			else
				read(text_line, data(index));
			end if;
		end loop;
		rst <= '1';
		input <= data;
		wait for 10 ns;
		stop_the_clock <= '0';
		rst <= '0';
		wait for 3000ns;
		stop_the_clock <= '1';
	end process;
				 
	clocking: process
	begin
		while not stop_the_clock = '1' loop
			clk <= '0', '1' after clock_period / 2;
			wait for clock_period;
		end loop;
	end process;
	
	FILE_OUT : process
		file text_file : text open write_mode is "results.txt";
		variable text_line : line;
		variable input: vec_array(0 to 63)(24 downto 0);
		variable index: integer := 0;
	begin
		for i in 0 to 63 loop
			write(text_line, output(i));
			writeline(text_file, text_line);
		end loop;
		wait;
	end process;
	
end;
