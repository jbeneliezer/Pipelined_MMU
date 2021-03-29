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
	signal r0: std_logic_vector(127 downto 0);	  
	signal r1: std_logic_vector(127 downto 0);	  
	signal r2: std_logic_vector(127 downto 0);	  
	signal r3: std_logic_vector(127 downto 0);	  
	signal r4: std_logic_vector(127 downto 0);	  
	signal r5: std_logic_vector(127 downto 0);	  
	signal r6: std_logic_vector(127 downto 0);	  
	signal r7: std_logic_vector(127 downto 0);	  
	signal r8: std_logic_vector(127 downto 0);	  
	signal r9: std_logic_vector(127 downto 0);	  
	signal r10: std_logic_vector(127 downto 0);	  
	signal r11: std_logic_vector(127 downto 0);	  
	signal r12: std_logic_vector(127 downto 0);	  
	signal r13: std_logic_vector(127 downto 0);	  
	signal r14: std_logic_vector(127 downto 0);	  
	signal r15: std_logic_vector(127 downto 0);	  
	signal r16: std_logic_vector(127 downto 0);	  
	signal r17: std_logic_vector(127 downto 0);	  
	signal r18: std_logic_vector(127 downto 0);	  
	signal r19: std_logic_vector(127 downto 0);	  
	signal r20: std_logic_vector(127 downto 0);	  
	signal r21: std_logic_vector(127 downto 0);	  
	signal r22: std_logic_vector(127 downto 0);	  
	signal r23: std_logic_vector(127 downto 0);	  
	signal r24: std_logic_vector(127 downto 0);	  	 

	component LI is
		 port(
			 op : in STD_LOGIC_VECTOR(24 downto 0);
			 r : out STD_LOGIC_VECTOR(127 downto 0)
		     );
	end component;
	
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
	LI_0: LI port map (op => Op, r => r0);												-- LI
	SIMALS_0: SIMALS port map (op => Op, i => A, j => B, k => C, r => r1);				-- SIMALS
	SIMAHS_0: SIMAHS port map (op => Op, i => A, j => B, k => C, r => r2);				-- SIMAHS
	SIMSLS_0: SIMSLS port map (op => Op, i => A, j => B, k => C, r => r3);				-- SIMSLS
	SIMSHS_0: SIMSHS port map (op => Op, i => A, j => B, k => C, r => r4);				-- SIMSHS
	SLIMALS_0: SLIMALS port map (op => Op, i => A, j => B, k => C, r => r5);			-- SLIMALS
	SLIMAHS_0: SLIMAHS port map (op => Op, i => A, j => B, k => C, r => r6);			-- SLIMAHS
	SLIMSLS_0: SLIMSLS port map (op => Op, i => A, j => B, k => C, r => r7);			-- SLIMSLS
	SLIMSHS_0: SLIMSHS port map (op => Op, i => A, j => B, k => C, r => r8);			-- SLIMSHS
	NOP_0: NOP port map (op => Op);														-- NOP
	AU_0: AU port map (op => Op, i => A, j => B, r => r10);								-- AU
	ABSDB_0: ABSDB port map (op => Op, i => A, j => B, r => r11);						-- ABSDB
	AHU_0: AHU port map (op => Op, i => A, j => B, r => r12);							-- AHU
	AHS_0: AHS port map (op => Op, i => A, j => B, r => r13);							-- AHS 
	AND_128_0: AND_128 port map (op => Op, i => A, j => B, r => r14);					-- AND
	BCW_0: BCW port map (op => Op, i => A, j => B, r => r15);							-- BCW
	MAXWS_0: MAXWS port map (op => Op, i => A, j => B, r => r16);						-- MAXWS
	MINWS_0: MINWS port map (op => Op, i => A, j => B, r => r17);						-- MINWS
	MLHU_0: MLHU port map (op => Op, i => A, j => B, r => r18);							-- MLHU
	MLHCU_0: MLHCU port map (op => Op, i => A, j => B, r => r19);						-- MLHCU
	OR_128_0: OR_128 port map (op => Op, i => A, j => B, r => r20);						-- OR
	PCNTW_0: PCNTW port map (op => Op, i => A, j => B, r => r21);						-- PCNTW
	ROTW_0: ROTW port map (op => Op, i => A, j => B, r => r22);							-- ROTW
	SFHS_0: SFHS port map (op => Op, i => A, j => B, r => r23);							-- SFHS
	SFW_0: SFW port map (op => Op, i => A, j => B, r => r24);							-- SFW	

	process(all)
	begin
		case? (Op) is
			when "0------------------------" => Rd <= r0;
			when "10000--------------------" => Rd <= r1; 
			when "10001--------------------" => Rd <= r2;
			when "10010--------------------" => Rd <= r3;
			when "10011--------------------" => Rd <= r4;
			when "10100--------------------" => Rd <= r5;
			when "10101--------------------" => Rd <= r6;
			when "10110--------------------" => Rd <= r7;
			when "10111--------------------" => Rd <= r8; 
			when "11----0000---------------" => Rd <= r9; 
			when "11----0001---------------" => Rd <= r10; 
			when "11----0010---------------" => Rd <= r11; 
			when "11----0011---------------" => Rd <= r12; 
			when "11----0100---------------" => Rd <= r13; 
			when "11----0101---------------" => Rd <= r14; 
			when "11----0110---------------" => Rd <= r15; 
			when "11----0111---------------" => Rd <= r16; 
			when "11----1000---------------" => Rd <= r17; 
			when "11----1001---------------" => Rd <= r18; 
			when "11----1010---------------" => Rd <= r19; 
			when "11----1011---------------" => Rd <= r20; 
			when "11----1100---------------" => Rd <= r21; 
			when "11----1101---------------" => Rd <= r22; 
			when "11----1110---------------" => Rd <= r23; 
			when "11----1111---------------" => Rd <= r24; 
			when others => null;
		end case?;
	end process;   
end structural;
