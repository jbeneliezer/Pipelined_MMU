-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\ALU_tb.vhd
-- Generated   : Tue Nov 30 01:06:47 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\ALU_tb.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library simd;
use simd.data_types.all;
use std.TEXTIO.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity ALU_tb is 
end ALU_tb;

architecture ALU_tb of ALU_tb is

---- Component declarations -----

component ALU
  port(
       Op : in STD_LOGIC_VECTOR(24 downto 0);
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       Rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal current_test : test;
signal result : STD_LOGIC_VECTOR(127 downto 0);

begin

---- Processes ----

read_file : process
                         file input : text;
                         variable row : line;
                         variable test_input : test;
                         variable space : character;
                       begin
                         FILE_OPEN(input,"stimulus.txt",read_mode);
                         while not endfile(input) loop
                             READLINE(input,row);
                             READ(row,test_input.Op);
                             READ(row,space);
                             READ(row,test_input.rs1);
                             READ(row,space);
                             READ(row,test_input.rs2);
                             READ(row,space);
                             READ(row,test_input.rs3);
                             READ(row,space);
                             READ(row,test_input.Rd);
                             current_test <= test_input;
                             wait for 20 ns;
                         end loop;
                         FILE_CLOSE(input);
                         wait;
                       end process;
                      

verify : process (result)
                       begin
                         assert (result = current_test.Rd) report "Error for input " & to_string(current_test.Op) severity error;
                       end process;
                      

----  Component instantiations  ----

uut : ALU
  port map(
       Op => current_test.Op,
       rs1 => current_test.rs1,
       rs2 => current_test.rs2,
       rs3 => current_test.rs3,
       Rd => result
  );


end ALU_tb;
