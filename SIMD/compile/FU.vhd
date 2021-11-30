-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\FU.vhd
-- Generated   : Tue Nov 30 01:06:47 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\FU.bde
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

entity FU is
  port(
       Op : in STD_LOGIC_VECTOR(24 downto 0);
       addr : in STD_LOGIC_VECTOR(4 downto 0);
       write_data : in STD_LOGIC_VECTOR(127 downto 0);
       rs_in : in vec_array(0 to 2);
       rs_out : out vec_array(0 to 2)
  );
end FU;

architecture behavioral of FU is

begin

---- Processes ----

process (Op,addr,write_data,rs_in)
                       begin
                         if Op(24) = '0' or Op = nop then
                            rs_out <= rs_in;
                         else 
                            if addr = Op(9 downto 5) then
                               rs_out(0) <= write_data;
                            else 
                               rs_out(0) <= rs_in(0);
                            end if;
                            if addr = Op(14 downto 10) then
                               rs_out(1) <= write_data;
                            else 
                               rs_out(1) <= rs_in(1);
                            end if;
                            if addr = Op(19 downto 15) then
                               rs_out(2) <= write_data;
                            else 
                               rs_out(2) <= rs_in(2);
                            end if;
                         end if;
                       end process;
                      

end behavioral;
