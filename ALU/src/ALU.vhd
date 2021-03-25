-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\SIMD\ALU\src\ALU.vhd
-- Generated   : Tue Mar 23 15:35:33 2021
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

entity ALU is
	port(					
		 Op : in STD_LOGIC_VECTOR(24 downto 0);
		 A : in STD_LOGIC_VECTOR(127 downto 0);
		 B : in STD_LOGIC_VECTOR(127 downto 0);
		 C : in STD_LOGIC_VECTOR(127 downto 0);
		 Rd : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;									   

architecture structural of ALU is

component SIMALS is
	port(	 			   
		op: in STD_LOGIC_VECTOR(24 downto 0);
		i : in STD_LOGIC_VECTOR(127 downto 0);
		j : in STD_LOGIC_VECTOR(127 downto 0);
		k : in STD_LOGIC_VECTOR(127 downto 0);
		r : out STD_LOGIC_VECTOR(127 downto 0)
		);
end component; 

component SIMAHS is
	 port(					
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SIMSLS is
	 port(					  
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SIMSHS is
	 port(					 
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SLIMALS is
	 port(				   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SLIMAHS is
	 port(					
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SLIMSLS is
	 port(				   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SLIMSHS is
	 port(					   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 k : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component NOP is
	 port(				
		 op : in STD_LOGIC_VECTOR(24 downto 0)
	     );
end component;

component AU is
	 port(					
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component ABSDB is
	 port(				 
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component AHU is
	 port(					
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component AHS is
	 port(				   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component AND_128 is
	 port(				   
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component BCW is
	 port(					 
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component MAXWS is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component MINWS is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component MLHU is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component MLHCU is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component OR_128 is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component PCNTW is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component ROTW is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SFHS is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;

component SFW is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end component;
	
begin  
	
	SIMALS_0: SIMALS port map (Op => op, i => A, j => B, k => C, r => Rd);				-- SIMALS
	SIMAHS_0: SIMAHS port map (Op => op, i => A, j => B, k => C, r => Rd);				-- SIMAHS
	SIMSLS_0: SIMSLS port map (Op => op, i => A, j => B, k => C, r => Rd);				-- SIMSLS
	SIMSHS_0: SIMSHS port map (Op => op, i => A, j => B, k => C, r => Rd);				-- SIMSHS
	SLIMALS_0: SLIMALS port map (Op => op, i => A, j => B, k => C, r => Rd);			-- SLIMALS
	SLIMAHS_0: SLIMAHS port map (Op => op, i => A, j => B, k => C, r => Rd);			-- SLIMAHS
	SLIMSLS_0: SLIMSLS port map (Op => op, i => A, j => B, k => C, r => Rd);			-- SLIMSLS
	SLIMSHS_0: SLIMSHS port map (Op => op, i => A, j => B, k => C, r => Rd);			-- SLIMSHS
	NOP_0: NOP port map (Op => op);														-- NOP
	AU_0: AU port map (Op => op, i => A, j => B, r => Rd);								-- AU
	ABSDB_0: ABSDB port map (Op => op, i => A, j => B, r => Rd);						-- ABSDB
	AHU_0: AHU port map (Op => op, i => A, j => B, r => Rd);							-- AHU
	AHS_0: AHS port map (Op => op, i => A, j => B, r => Rd);							-- AHS 
	AND_128_0: AND_128 port map (Op => op, i => A, j => B, r => Rd);					-- AND
	BCW_0: BCW port map (Op => op, i => A, j => B, r => Rd);							-- BCW
	MAXWS_0: MAXWS port map (Op => op, i => A, j => B, r => Rd);						-- MAXWS
	MINWS_0: MINWS port map (Op => op, i => A, j => B, r => Rd);						-- MINWS
	MLHU_0: MLHU port map (Op => op, i => A, j => B, r => Rd);							-- MLHU
	MLHCU_0: MLHCU port map (Op => op, i => A, j => B, r => Rd);						-- MLHCU
	OR_128_0: OR_128 port map (Op => op, i => A, j => B, r => Rd);						-- OR
	PCNTW_0: PCNTW port map (Op => op, i => A, j => B, r => Rd);						-- PCNTW
	ROTW_0: ROTW port map (Op => op, i => A, j => B, r => Rd);							-- ROTW
	SFHS_0: SFHS port map (Op => op, i => A, j => B, r => Rd);							-- SFHS
	SFW_0: SFW port map (Op => op, i => A, j => B, r => Rd);							-- SFW
	
end structural;
