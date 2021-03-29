-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\compile\ALU.vhd
-- Generated   : Sun Mar 28 22:23:31 2021
-- From        : C:\My_Designs\SIMD\ALU\..\blocks\ALU.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

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

---- Component declarations -----

component ABSDB
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component AHS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component AHU
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component AND_128
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component AU
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component BCW
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component LI
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MAXWS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MINWS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MLHCU
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component MLHU
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component NOP
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0)
  );
end component;
component OR_128
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component PCNTW
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component ROTW
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SFHS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SFW
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SIMAHS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SIMALS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SIMSHS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SIMSLS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SLIMAHS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SLIMALS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SLIMSHS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component SLIMSLS
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal r0 : STD_LOGIC_VECTOR(127 downto 0);
signal r1 : STD_LOGIC_VECTOR(127 downto 0);
signal r10 : STD_LOGIC_VECTOR(127 downto 0);
signal r11 : STD_LOGIC_VECTOR(127 downto 0);
signal r12 : STD_LOGIC_VECTOR(127 downto 0);
signal r13 : STD_LOGIC_VECTOR(127 downto 0);
signal r14 : STD_LOGIC_VECTOR(127 downto 0);
signal r15 : STD_LOGIC_VECTOR(127 downto 0);
signal r16 : STD_LOGIC_VECTOR(127 downto 0);
signal r17 : STD_LOGIC_VECTOR(127 downto 0);
signal r18 : STD_LOGIC_VECTOR(127 downto 0);
signal r19 : STD_LOGIC_VECTOR(127 downto 0);
signal r2 : STD_LOGIC_VECTOR(127 downto 0);
signal r20 : STD_LOGIC_VECTOR(127 downto 0);
signal r21 : STD_LOGIC_VECTOR(127 downto 0);
signal r22 : STD_LOGIC_VECTOR(127 downto 0);
signal r23 : STD_LOGIC_VECTOR(127 downto 0);
signal r24 : STD_LOGIC_VECTOR(127 downto 0);
signal r3 : STD_LOGIC_VECTOR(127 downto 0);
signal r4 : STD_LOGIC_VECTOR(127 downto 0);
signal r5 : STD_LOGIC_VECTOR(127 downto 0);
signal r6 : STD_LOGIC_VECTOR(127 downto 0);
signal r7 : STD_LOGIC_VECTOR(127 downto 0);
signal r8 : STD_LOGIC_VECTOR(127 downto 0);
signal r9 : STD_LOGIC_VECTOR(127 downto 0);

begin

---- Processes ----

process (Op,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24)
                       begin
                         case (Op) is 
                           when "0------------------------" => 
                              Rd <= r0;
                           when "10000--------------------" => 
                              Rd <= r1;
                           when "10001--------------------" => 
                              Rd <= r2;
                           when "10010--------------------" => 
                              Rd <= r3;
                           when "10011--------------------" => 
                              Rd <= r4;
                           when "10100--------------------" => 
                              Rd <= r5;
                           when "10101--------------------" => 
                              Rd <= r6;
                           when "10110--------------------" => 
                              Rd <= r7;
                           when "10111--------------------" => 
                              Rd <= r8;
                           when "11----0000---------------" => 
                              Rd <= r9;
                           when "11----0001---------------" => 
                              Rd <= r10;
                           when "11----0010---------------" => 
                              Rd <= r11;
                           when "11----0011---------------" => 
                              Rd <= r12;
                           when "11----0100---------------" => 
                              Rd <= r13;
                           when "11----0101---------------" => 
                              Rd <= r14;
                           when "11----0110---------------" => 
                              Rd <= r15;
                           when "11----0111---------------" => 
                              Rd <= r16;
                           when "11----1000---------------" => 
                              Rd <= r17;
                           when "11----1001---------------" => 
                              Rd <= r18;
                           when "11----1010---------------" => 
                              Rd <= r19;
                           when "11----1011---------------" => 
                              Rd <= r20;
                           when "11----1100---------------" => 
                              Rd <= r21;
                           when "11----1101---------------" => 
                              Rd <= r22;
                           when "11----1110---------------" => 
                              Rd <= r23;
                           when "11----1111---------------" => 
                              Rd <= r24;
                           when others => 
                              null;
                         end case;
                       end process;
                      

----  Component instantiations  ----

ABSDB_0 : ABSDB
  port map(
       op => op,
       i => A,
       j => B,
       r => r11
  );

AHS_0 : AHS
  port map(
       op => op,
       i => A,
       j => B,
       r => r13
  );

AHU_0 : AHU
  port map(
       op => op,
       i => A,
       j => B,
       r => r12
  );

AND_128_0 : AND_128
  port map(
       op => op,
       i => A,
       j => B,
       r => r14
  );

AU_0 : AU
  port map(
       op => op,
       i => A,
       j => B,
       r => r10
  );

BCW_0 : BCW
  port map(
       op => op,
       i => A,
       j => B,
       r => r15
  );

LI_0 : LI
  port map(
       op => op,
       r => r0
  );

MAXWS_0 : MAXWS
  port map(
       op => op,
       i => A,
       j => B,
       r => r16
  );

MINWS_0 : MINWS
  port map(
       op => op,
       i => A,
       j => B,
       r => r17
  );

MLHCU_0 : MLHCU
  port map(
       op => op,
       i => A,
       j => B,
       r => r19
  );

MLHU_0 : MLHU
  port map(
       op => op,
       i => A,
       j => B,
       r => r18
  );

NOP_0 : NOP
  port map(
       op => op
  );

OR_128_0 : OR_128
  port map(
       op => op,
       i => A,
       j => B,
       r => r20
  );

PCNTW_0 : PCNTW
  port map(
       op => op,
       i => A,
       j => B,
       r => r21
  );

ROTW_0 : ROTW
  port map(
       op => op,
       i => A,
       j => B,
       r => r22
  );

SFHS_0 : SFHS
  port map(
       op => op,
       i => A,
       j => B,
       r => r23
  );

SFW_0 : SFW
  port map(
       op => op,
       i => A,
       j => B,
       r => r24
  );

SIMAHS_0 : SIMAHS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r2
  );

SIMALS_0 : SIMALS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r1
  );

SIMSHS_0 : SIMSHS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r4
  );

SIMSLS_0 : SIMSLS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r3
  );

SLIMAHS_0 : SLIMAHS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r6
  );

SLIMALS_0 : SLIMALS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r5
  );

SLIMSHS_0 : SLIMSHS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r8
  );

SLIMSLS_0 : SLIMSLS
  port map(
       op => op,
       i => A,
       j => B,
       k => C,
       r => r7
  );


end structural;
