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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.data_types.all;

entity MMU is
	port(
		clk : in std_logic;
		rst: in std_logic;
		input: in vec_array(0 to 63)(24 downto 0);
		output: out result
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
		
	component IF_ID is
		port(
			clk: in std_logic;
			rst: in std_logic;
			D: in std_logic_vector(24 downto 0);
			Q: out std_logic_vector(24 downto 0)
			);
	end component IF_ID;
	
	component RF is
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
	end component RF;

	
	component ID_EX is
		port(
			clk : in std_logic;
			rst : in std_logic;
			D: in idex;
			Q: out idex
			);
	end component ID_EX;
	
	component FU is
		port(
			Op: in std_logic_vector(24 downto 0);
			addr: in std_logic_vector(4 downto 0);
			write_data: in std_logic_vector(127 downto 0);
			rs_in: in vec_array(0 to 2)(127 downto 0);
			rs_out: out vec_array(0 to 2)(127 downto 0)
			);
	end component FU;
	
	component ALU is
		port(					
			Op : in STD_LOGIC_VECTOR(24 downto 0);
			rs1 : in STD_LOGIC_VECTOR(127 downto 0);
			rs2 : in STD_LOGIC_VECTOR(127 downto 0);
			rs3 : in STD_LOGIC_VECTOR(127 downto 0);
			Rd : out STD_LOGIC_VECTOR(127 downto 0)
			);
	end component ALU;	 
	
	component EX_WB is
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
	end component EX_WB;
	
	signal PC: std_logic_vector(5 downto 0) := "000000";
	
	-- IB Signals
	signal program: vec_array(0 to 63)(24 downto 0); 
	signal instr0: std_logic_vector(24 downto 0) := nop;
	
	-- RF Signals
	signal instr1: std_logic_vector(24 downto 0) := nop; 
	signal rf_out: vec_array(0 to 2)(127 downto 0);
	signal write_en: std_logic := '0';
	signal li: std_logic := '0';
	signal write_data: std_logic_vector(127 downto 0); 
	signal write_addr: std_logic_vector(4 downto 0);   
	
	-- FU Signals
	signal instr2: std_logic_vector(24 downto 0);
	signal fu_in: vec_array(0 to 2)(127 downto 0);
	
	-- ALU Signals
	signal alu_in: vec_array(0 to 2)(127 downto 0);
	signal alu_out: std_logic_vector(127 downto 0);
	
	
begin
	instructions: IB port map(rst => rst, index => PC, program => input, instruction_out => instr0);		-- IB
	
	REG0: IF_ID port map (clk => clk, rst => rst, D => instr0, Q => instr1);											-- IF_ID Register
																																		   
	r_f: RF port map (write_en => write_en, li => li, read_addr_0 => instr1(9 downto 5), read_addr_1 => instr1(14 downto 10), read_addr_2 => instr1(19 downto 15),  -- RF
		write_addr => write_addr, write_data => write_data, rs1 => rf_out(0), rs2 => rf_out(1), rs3 => rf_out(2));									 
																												  
	REG1: ID_EX port map (clk => clk, rst => rst, D => (instr1, rf_out(0), rf_out(1), rf_out(2)),				-- ID_EX Register
		Q.Op => instr2, Q.rs1 => fu_in(0), Q.rs2 => fu_in(1), Q.rs3 => fu_in(2));		
	
	forward: FU port map (Op => instr2, addr => write_addr, write_data => write_data, rs_in(0) => fu_in(0), rs_in(1) => fu_in(1), rs_in(2) => fu_in(2),	-- FU
		rs_out(0) => alu_in(0), rs_out(1) => alu_in(1), rs_out(2) => alu_in(2));
		
	logic: ALU port map (Op => instr2, rs1 => alu_in(0), rs2 => alu_in(1), rs3 => alu_in(2), Rd => alu_out);				-- ALU
	
	REG2: EX_WB port map (clk => clk, rst => rst, Op => instr2, Rd => alu_out, write_en => write_en, li => li, addr => write_addr, data => write_data);													-- WB
	
	PC <= "000000" when rst = '1' else std_logic_vector(unsigned(PC) + 1) when rising_edge(clk);
	 
	-- write results
	output.PC <= PC;
	output.instr0 <= instr0;
	output.instr1 <= instr1;
	output.rf_out <= rf_out;
	output.instr2 <= instr2;
	output.write_en <= write_en;
	output.li <= li;
	output.write_data <= write_data; 
	output.write_addr <= write_addr; 					 
	output.fu_in <= fu_in;	 
	output.alu_in <= alu_in;
	output.alu_out <= alu_out;
	
end structural;
