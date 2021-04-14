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
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library SIMD;
use SIMD.REGISTER_file.all;

entity MMU is
	 port(
		 clk : in std_logic;
	     );
end MMU;								  

architecture structural of MMU is	 

component ALU is
	port(					
		Op : in STD_LOGIC_VECTOR(24 downto 0);
		rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		Rd : out STD_LOGIC_VECTOR(127 downto 0)
		);
end component ALU;

component FU is
	port( 
		Op: in std_logic_vector(24 downto 0);
		rf: in REGISTER_array(31 downto 0)(127 downto 0);
		rs1: out std_logic_vector(127 downto 0);
		rs2: out std_logic_vector(127 downto 0);
		rs3: out std_logic_vector(127 downto 0)
		);
end component FU; 

signal IB: REGISTER_array(31 downto 0)(24 downto 0);
signal RF: REGISTER_array(31 downto 0)(127 downto 0);
signal PC: integer range 0 to 31 := 0;
signal Ops: REGISTER_array(0 to 3)(24 downto 0);
signal Regs: REGISTER_array_3d(0 to 2)(0 to 3)(127 downto 0);

function ops_ror(op: REGISTER_array(0 to 3)(24 downto 0)) return REGISTER_array is
begin
	return (op(3), op(0), op(1), op(2)); 
end function ops_ror;

function regs_ror(regs: REGISTER_array_3d(0 to 2)(0 to 3)(127 downto 0)) return REGISTER_array_3d is
begin
	return (regs(2), regs(0), regs(1));
end function regs_ror;

begin

	Ops(0) <= IB(PC);
	forward: FU port map (Op => Ops(1), rf => RF, rs1 => Regs(0)(0), rs2 => Regs(0)(1), rs3 => Regs(0)(2));
	logic: ALU port map (Op => Ops(2), rs1 => Regs(1)(0), rs2 => Regs(1)(1), rs3 => Regs(1)(2), Rd => Regs(1)(3));
	RF(to_integer(unsigned(Ops(3)(4 downto 0)))) <= Regs(2)(3);
	
	I_F: process(clk)			-- Instruction Forwarding
	begin
		if (rising_edge(clk)) then
			Ops <= ops_ror(Ops);
			PC <= PC + 1;
		end if;
	end process I_F;
	
	I_D: process(clk)			-- Instruction Decoding
	begin 
		if (rising_edge(clk)) then
			Ops <= ops_ror(Ops);
			Regs <= regs_ror(Regs);
		end if;
	end process I_D;
	
	E_X: process(clk)			-- Execution
	begin
		if (rising_edge(clk)) then
			Ops <= ops_ror(Ops);
			Regs <= regs_ror(Regs);
		end if;
	end process;
	
	W_B: process(clk)			-- Write back
	begin
		if (rising_edge(clk)) then
			Ops <= ops_ror(Ops);
			Regs <= regs_ror(Regs);
		end if;
	end process;
end structural;
