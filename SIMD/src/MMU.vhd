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
		output: out vec_array(0 to 63)(127 downto 0)
		);
end MMU;								  

architecture structural of MMU is
	
	component ALU is
		port(					
			Op : in STD_LOGIC_VECTOR(24 downto 0);
			rs1 : in STD_LOGIC_VECTOR(127 downto 0);
			rs2 : in STD_LOGIC_VECTOR(127 downto 0);
			rs3 : in STD_LOGIC_VECTOR(127 downto 0);
			Rd : out STD_LOGIC_VECTOR(127 downto 0);
			Op_out: out std_logic_vector(24 downto 0)
			);
	end component ALU;
	
	component FU is
		port( 
			Op: in std_logic_vector(24 downto 0);
			i_rs1: out std_logic_vector(4 downto 0);
			i_rs2: out std_logic_vector(4 downto 0);
			i_rs3: out std_logic_vector(4 downto 0);
			Op_out: out std_logic_vector(24 downto 0)
			);
	end component FU;
	
	component IB is
		port(
			clk : in std_logic;
			rst: in std_logic;
			index: std_logic_vector(5 downto 0);
			D: in vec_array(0 to 63)(24 downto 0);
			Q: out std_logic_vector(24 downto 0)
			);
	end component IB;
	
	component RF is
		port(
			clk: in std_logic;
			en: in std_logic;
			i_get0: in std_logic_vector(4 downto 0);
			i_get1: in std_logic_vector(4 downto 0);
			i_get2: in std_logic_vector(4 downto 0); 
			i_send: in std_logic_vector(4 downto 0);
			D: in std_logic_vector(127 downto 0);
			Q0: out std_logic_vector(127 downto 0);
			Q1: out std_logic_vector(127 downto 0);
			Q2: out std_logic_vector(127 downto 0)
			);
	end component RF;
	
	component IF_ID is
		port(
			clk: in std_logic;
			rst: in std_logic;
			D: in std_logic_vector(24 downto 0);
			Q: out std_logic_vector(24 downto 0)
			);
	end component IF_ID;
	
	component ID_EX is
		port(
			clk : in std_logic;
			rst : in std_logic;
			D: in idex;
			Q: out idex
			);
	end component ID_EX;
	
	component EX_WB is
		port(
			clk : in std_logic;
			rst : in std_logic;
			D : in std_logic_vector(127 downto 0);
			Q: out std_logic_vector(127 downto 0)
			);
	end component EX_WB;
	
	signal PC: std_logic_vector(5 downto 0) := "000000";
	signal op: std_logic_vector(24 downto 0) := nop;
	signal fu_in: std_logic_vector(24 downto 0);
	signal fu_out: vec_array(0 to 2)(4 downto 0);
	signal fu_out_op: std_logic_vector(24 downto 0) := nop;
	signal rf_out: vec_array(0 to 2)(127 downto 0);
	signal alu_in: idex;
	signal alu_out: std_logic_vector(127 downto 0);
	signal alu_out_op: std_logic_vector(24 downto 0) := nop;
	signal write: std_logic_vector(127 downto 0);
	signal i_write: std_logic_vector(4 downto 0);
	signal write_enable: std_logic := '0';
	
begin																
	instructions: IB port map(clk => clk, rst => rst, index => PC, D => input, Q => op);				   
	ifid: IF_ID port map (clk => clk, rst => rst, D => op, Q => fu_in);
	forward: FU port map (Op => fu_in, i_rs1 => fu_out(0), i_rs2 => fu_out(1), i_rs3 => fu_out(2), Op_out => fu_out_op);
	r_f: RF port map (clk => clk, en => write_enable, i_get0 => fu_out(0), i_get1 => fu_out(1), i_get2 => fu_out(2), i_send => i_write, D => write,
		Q0 => rf_out(0), Q1 => rf_out(1), Q2 => rf_out(2));
	idex: ID_EX port map (clk => clk, rst => rst, D => (fu_out_op, rf_out(0), rf_out(1), rf_out(2)), Q => alu_in);
	logic: ALU port map (Op => alu_in.Op, rs1 => alu_in.rs1, rs2 => alu_in.rs2, rs3 => alu_in.rs3, Rd => alu_out, Op_out => alu_out_op);
	wb: EX_WB port map (clk => clk, rst => rst, D => alu_out, Q => write);
	
	PC <= "000000" when rst = '1' else std_logic_vector(unsigned(PC) + 1) when rising_edge(clk);
	write_enable <= '0' when alu_out_op = nop else '1';
	output(to_integer(unsigned(PC))) <= alu_out;
end structural;
