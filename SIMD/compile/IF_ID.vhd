-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\IF_ID.vhd
-- Generated   : Tue Nov 30 01:06:48 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\IF_ID.bde
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

entity IF_ID is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       D : in STD_LOGIC_VECTOR(24 downto 0);
       Q : out STD_LOGIC_VECTOR(24 downto 0)
  );
end IF_ID;

architecture behavioral of IF_ID is

---- Signal declarations used on the diagram ----

signal buf : STD_LOGIC_VECTOR(24 downto 0);

begin

---- Processes ----

process (rst,clk)
                       begin
                         if rst = '1' then
                            Q <= nop;
                         elsif clk = '1' then
                            Q <= D;
                         end if;
                       end process;
                      

end behavioral;
