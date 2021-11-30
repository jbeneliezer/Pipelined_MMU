-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\IB.vhd
-- Generated   : Tue Nov 30 01:06:47 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\IB.bde
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity IB is
  port(
       rst : in STD_LOGIC;
       index : in STD_LOGIC_VECTOR(5 downto 0);
       program : in vec_array(0 to 63);
       instruction_out : out STD_LOGIC_VECTOR(24 downto 0)
  );
end IB;

architecture behavioral of IB is

---- Signal declarations used on the diagram ----

signal f : vec_array(0 to 63) := (others => nop);

begin

---- Processes ----

reset : process (rst)
                       begin
                         if rst = '1' then
                            f <= program;
                         end if;
                       end process;
                      

---- User Signal Assignments ----
instruction_out <= f(to_integer(unsigned(index)));

end behavioral;
