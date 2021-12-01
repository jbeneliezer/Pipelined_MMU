-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\ID_EX.vhd
-- Generated   : Tue Nov 30 01:06:48 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\ID_EX.bde
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

entity ID_EX is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       D : in idex;
       Q : out idex
  );
end ID_EX;

architecture behavioral of ID_EX is

begin

---- Processes ----

process (rst,clk)
                       begin
                         if rst = '1' then
                            Q <= idex_clr;
                         elsif clk = '1' then
                            Q <= D;
                         end if;
                       end process;
                      

end behavioral;
