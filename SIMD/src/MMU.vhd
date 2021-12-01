-------------------------------------------------------------------------------
--
-- Title       : MMU
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\SIMD\src\MMU.vhd
-- Generated   : Tue Apr 13 16:46:18 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Top-level design of multimedia unit.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.data_types.all;

entity MMU is
	port(
		clk : in std_logic;
		rst: in std_logic;
		input: in vec_array(0 to 63)(24 downto 0);
		output: out result;
		output_rf: out vec_array(0 to 31)(127 downto 0)
		);
end MMU;								  

architecture structural of MMU is

	component IB is
		port(					
			rst: in std_logic;
			index: in std_logic_vector(5 downto 0);
			program: in vec_array(0 to 63)(24 downto 0);
			instruction_out: out std_logic_vector(24 downto 0)
			);
	end component IB;
	
	component RF is
		port(				   
			write_en: in std_logic;					   				   
			op: in std_logic_vector(24 downto 0);
			write_addr: in std_logic_vector(4 downto 0);
			write_data: in std_logic_vector(127 downto 0);
			output: out idex;
			output_rf: out vec_array(0 to 31)(127 downto 0)
			);
	end component RF; 
	
	component FU is
		port(									 
			addr: in std_logic_vector(4 downto 0);
			write_data: in std_logic_vector(127 downto 0);
			input: in idex;
			output: out idex
			);
	end component FU;
	
	component ALU is
		port(					
			input: in idex;
			rd : out std_logic_vector(127 downto 0)
			);
	end component ALU;
	
	component generic_register is
		generic(
			type t;
			constant clr: t
		);
		port(
			clk: in std_logic;
			rst: in std_logic;
			D: in t;
			Q: out t
		);
	end component generic_register;
	
	-- Write enable condition
	function w_e(op: std_logic_vector(24 downto 0)) return std_logic is
	begin
		if op = nop then return '0';
		else return '1';
		end if;
	end function;
	
	-- Program Counter
	signal PC: std_logic_vector(5 downto 0) := (others => '0');
	
	-- IB Signals
	signal program: vec_array(0 to 63)(24 downto 0); 
	signal instr0: std_logic_vector(24 downto 0) := nop;
	
	-- RF Signals
	signal instr1: std_logic_vector(24 downto 0) := nop;
	signal rf_out: idex := idex_clr;  				   
	
	-- FU Signals
	signal fu_in: idex := idex_clr;
	
	-- ALU Signals
	signal alu_in: idex := idex_clr;
	signal alu_out: std_logic_vector(127 downto 0);
	
	-- WB Signals
	signal wb_out: exwb := exwb_clr;
	
	signal final_rf: vec_array(0 to 31)(127 downto 0);	
	
begin
	instructions: IB		-- IB
		port map(rst => rst, index => PC, program => input, instruction_out => instr0);				
	
	REG0: generic_register		-- IF_ID Register
		generic map (t => std_logic_vector(24 downto 0), clr => nop)
		port map (clk => clk, rst => rst, D => instr0, Q => instr1);
																																		   
	r_f: RF		-- RF
		port map (write_en => wb_out.write_en, Op => instr1, write_addr => wb_out.op(4 downto 0), write_data => wb_out.data,
		output => rf_out, output_rf => final_rf);									 		  
	
	REG1: generic_register		 -- ID_EX Register	
		generic map (t => idex, clr => idex_clr)
		port map (clk => clk, rst => rst, D => rf_out, Q => fu_in);		
	
	forward: FU		-- FU
		port map (addr => wb_out.op(4 downto 0), write_data => wb_out.data, input => fu_in, output => alu_in);
		
	logic: ALU		-- ALU
		port map (input => alu_in, rd => alu_out);				
	
	REG2: generic_register		--EX_WB Register
		generic map (t => exwb, clr => exwb_clr)
		port map (clk => clk, rst => rst, D => (w_e(alu_in.op), alu_in.op, alu_out), Q => wb_out);
																   
	PC <= (others => '0') when rst = '1' else std_logic_vector(unsigned(PC) + 1) when rising_edge(clk);
	 
	-- write results
	output.PC <= PC;
	output.instr0 <= instr0;
	output.instr1 <= instr1;
	output.rf_out <= rf_out; 					 
	output.fu_in <= fu_in;	 
	output.alu_in <= alu_in;
	output.alu_out <= alu_out;
	output.wb_out <= wb_out;
	
	output_rf <= final_rf;
	
end structural;
