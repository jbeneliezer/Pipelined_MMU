-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\EX_WB.vhd
-- Generated   : Tue Nov 30 01:06:47 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\EX_WB.bde
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

entity EX_WB is
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       Op : in STD_LOGIC_VECTOR(24 downto 0);
       Rd : in STD_LOGIC_VECTOR(127 downto 0);
       write_en : out STD_LOGIC;
       li : out STD_LOGIC;
       addr : out STD_LOGIC_VECTOR(4 downto 0);
       data : out STD_LOGIC_VECTOR(127 downto 0)
  );
end EX_WB;

architecture behavioral of EX_WB is

begin

---- Processes ----

process (rst,clk)
                       begin
                         if rst = '1' then
                            write_en <= '0';
                            addr <= "00000";
                            data <= z128;
                         elsif clk = '1' then
                            if Op = nop then
                               write_en <= '0';
                            else 
                               write_en <= '1';
                            end if;
                            if Op(24) = '0' then
                               li <= '1';
                            else 
                               li <= '0';
                            end if;
                            addr <= Op(4 downto 0);
                            data <= Rd;
                         end if;
                       end process;
                      

end behavioral;
