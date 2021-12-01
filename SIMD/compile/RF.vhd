-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\RF.vhd
-- Generated   : Tue Nov 30 01:06:48 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\RF.bde
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
use ieee.MATH_REAL.all;

entity RF is
  port(
       write_en : in STD_LOGIC;
       li : in STD_LOGIC;
       read_addr_0 : in STD_LOGIC_VECTOR(4 downto 0);
       read_addr_1 : in STD_LOGIC_VECTOR(4 downto 0);
       read_addr_2 : in STD_LOGIC_VECTOR(4 downto 0);
       write_addr : in STD_LOGIC_VECTOR(4 downto 0);
       write_data : in STD_LOGIC_VECTOR(127 downto 0);
       rs1 : out STD_LOGIC_VECTOR(127 downto 0);
       rs2 : out STD_LOGIC_VECTOR(127 downto 0);
       rs3 : out STD_LOGIC_VECTOR(127 downto 0)
  );
end RF;

architecture behavioral of RF is

begin

---- Processes ----

write : process
                         variable f : vec_array(0 to 31)(127 downto 0) := (others => z128);
                       begin
                         while true loop
                             wait until write_en = '1' or li = '1' or read_addr_0'event or read_addr_1'event or read_addr_2'event or write_addr'event or write_data'event;
                             rs1 <= f(to_integer(unsigned(read_addr_0)));
                             rs2 <= f(to_integer(unsigned(read_addr_1)));
                             rs3 <= f(to_integer(unsigned(read_addr_2)));
                             if write_en = '1' then
                                if li = '1' then
                                   f(to_integer(unsigned(write_addr))) := f(to_integer(unsigned(write_addr))) or write_data;
                                else 
                                   f(to_integer(unsigned(write_addr))) := write_data;
                                end if;
                             end if;
                         end loop;
                       end process;
                      

end behavioral;
