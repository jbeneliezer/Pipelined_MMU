-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\ALU.vhd
-- Generated   : Tue Nov 30 01:06:47 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\ALU.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library simd;
use simd.ALU_functions.all;
use simd.data_types.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity ALU is
  port(
       Op : in STD_LOGIC_VECTOR(24 downto 0);
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       Rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end ALU;

architecture behavioral of ALU is

begin

---- Processes ----

process (Op,rs1,rs2,rs3(127 downto 96),rs3(63 downto 32),rs3(95 downto 64),rs3(31 downto 0),rs3(127 downto 112),rs3(95 downto 80),rs3(63 downto 48),rs3(31 downto 16),rs3(111 downto 96),rs3(79 downto 64),rs3(47 downto 32),rs3(15 downto 0))
                         variable l_tmp : std_logic_vector(127 downto 0) := z128;
                       begin
                         case (Op) is 
                           when "0------------------------" => 
                              l_tmp := z128;
                              case (op(23 downto 21)) is 
                                when "000" => 
                                   l_tmp(15 downto 0) := Op(20 downto 5);
                                when "001" => 
                                   l_tmp(31 downto 16) := Op(20 downto 5);
                                when "010" => 
                                   l_tmp(47 downto 32) := Op(20 downto 5);
                                when "011" => 
                                   l_tmp(63 downto 48) := Op(20 downto 5);
                                when "100" => 
                                   l_tmp(79 downto 64) := Op(20 downto 5);
                                when "101" => 
                                   l_tmp(95 downto 80) := Op(20 downto 5);
                                when "110" => 
                                   l_tmp(111 downto 96) := Op(20 downto 5);
                                when "111" => 
                                   l_tmp(127 downto 112) := Op(20 downto 5);
                                when others => 
                                   null;
                              end case;
                              Rd <= l_tmp;
                           when "10000--------------------" => 
                              Rd(31 downto 0) <= MULT_ADD_I(rs3(15 downto 0),rs2(15 downto 0),rs1(31 downto 0));
                              Rd(63 downto 32) <= MULT_ADD_I(rs3(47 downto 32),rs2(47 downto 32),rs1(63 downto 32));
                              Rd(95 downto 64) <= MULT_ADD_I(rs3(79 downto 64),rs2(79 downto 64),rs1(95 downto 64));
                              Rd(127 downto 96) <= MULT_ADD_I(rs3(111 downto 96),rs2(111 downto 96),rs1(127 downto 96));
                           when "10001--------------------" => 
                              Rd(31 downto 0) <= MULT_ADD_I(rs3(31 downto 16),rs2(31 downto 16),rs1(31 downto 0));
                              Rd(63 downto 32) <= MULT_ADD_I(rs3(63 downto 48),rs2(63 downto 48),rs1(63 downto 32));
                              Rd(95 downto 64) <= MULT_ADD_I(rs3(95 downto 80),rs2(95 downto 80),rs1(95 downto 64));
                              Rd(127 downto 96) <= MULT_ADD_I(rs3(127 downto 112),rs2(127 downto 112),rs1(127 downto 96));
                           when "10010--------------------" => 
                              Rd(31 downto 0) <= MULT_SUB_I(rs3(15 downto 0),rs2(15 downto 0),rs1(31 downto 0));
                              Rd(63 downto 32) <= MULT_SUB_I(rs3(47 downto 32),rs2(47 downto 32),rs1(63 downto 32));
                              Rd(95 downto 64) <= MULT_SUB_I(rs3(79 downto 64),rs2(79 downto 64),rs1(95 downto 64));
                              Rd(127 downto 96) <= MULT_SUB_I(rs3(111 downto 96),rs2(111 downto 96),rs1(127 downto 96));
                           when "10011--------------------" => 
                              Rd(31 downto 0) <= MULT_SUB_I(rs3(31 downto 16),rs2(31 downto 16),rs1(31 downto 0));
                              Rd(63 downto 32) <= MULT_SUB_I(rs3(63 downto 48),rs2(63 downto 48),rs1(63 downto 32));
                              Rd(95 downto 64) <= MULT_SUB_I(rs3(95 downto 80),rs2(95 downto 80),rs1(95 downto 64));
                              Rd(127 downto 96) <= MULT_SUB_I(rs3(127 downto 112),rs2(127 downto 112),rs1(127 downto 96));
                           when "10100--------------------" => 
                              Rd(63 downto 0) <= MULT_ADD_L(rs3(31 downto 0),rs2(31 downto 0),rs1(63 downto 0));
                              Rd(127 downto 64) <= MULT_ADD_L(rs3(95 downto 64),rs2(95 downto 64),rs1(127 downto 64));
                           when "10101--------------------" => 
                              Rd(63 downto 0) <= MULT_ADD_L(rs3(63 downto 32),rs2(63 downto 32),rs1(63 downto 0));
                              Rd(127 downto 64) <= MULT_ADD_L(rs3(127 downto 96),rs2(127 downto 96),rs1(127 downto 64));
                           when "10110--------------------" => 
                              Rd(63 downto 0) <= MULT_SUB_L(rs3(31 downto 0),rs2(31 downto 0),rs1(63 downto 0));
                              Rd(127 downto 64) <= MULT_SUB_L(rs3(95 downto 64),rs2(95 downto 64),rs1(127 downto 64));
                           when "10111--------------------" => 
                              Rd(63 downto 0) <= MULT_SUB_L(rs3(63 downto 32),rs2(63 downto 32),rs1(63 downto 0));
                              Rd(127 downto 64) <= MULT_SUB_L(rs3(127 downto 96),rs2(127 downto 96),rs1(127 downto 64));
                           when "11----0000---------------" => 
                              Rd <= z128;
                           when "11----0001---------------" => 
                              Rd(15 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) + unsigned(rs2(15 downto 0)));
                              Rd(31 downto 16) <= std_logic_vector(unsigned(rs1(31 downto 16)) + unsigned(rs2(31 downto 16)));
                              Rd(47 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) + unsigned(rs2(47 downto 32)));
                              Rd(63 downto 48) <= std_logic_vector(unsigned(rs1(63 downto 48)) + unsigned(rs2(63 downto 48)));
                              Rd(79 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) + unsigned(rs2(79 downto 64)));
                              Rd(95 downto 80) <= std_logic_vector(unsigned(rs1(95 downto 80)) + unsigned(rs2(95 downto 80)));
                              Rd(111 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) + unsigned(rs2(111 downto 96)));
                              Rd(127 downto 112) <= std_logic_vector(unsigned(rs1(127 downto 112)) + unsigned(rs2(127 downto 112)));
                           when "11----0010---------------" => 
                              Rd(15 downto 0) <= SAT(rs1(15),rs2(15),std_logic_vector(signed(rs1(15 downto 0)) + signed(rs2(15 downto 0))));
                              Rd(31 downto 16) <= SAT(rs1(31),rs2(31),std_logic_vector(signed(rs1(31 downto 16)) + signed(rs2(31 downto 16))));
                              Rd(47 downto 32) <= SAT(rs1(47),rs2(47),std_logic_vector(signed(rs1(47 downto 32)) + signed(rs2(47 downto 32))));
                              Rd(63 downto 48) <= SAT(rs1(63),rs2(63),std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48))));
                              Rd(79 downto 64) <= SAT(rs1(79),rs2(79),std_logic_vector(signed(rs1(79 downto 64)) + signed(rs2(79 downto 64))));
                              Rd(95 downto 80) <= SAT(rs1(95),rs2(95),std_logic_vector(signed(rs1(95 downto 80)) + signed(rs2(95 downto 80))));
                              Rd(111 downto 96) <= SAT(rs1(111),rs2(111),std_logic_vector(signed(rs1(111 downto 96)) + signed(rs2(111 downto 96))));
                              Rd(127 downto 112) <= SAT(rs1(127),rs2(127),std_logic_vector(signed(rs1(127 downto 112)) + signed(rs2(127 downto 112))));
                           when "11----0011---------------" => 
                              Rd(31 downto 0) <= rs1(31 downto 0);
                              Rd(63 downto 32) <= rs1(31 downto 0);
                              Rd(95 downto 64) <= rs1(31 downto 0);
                              Rd(127 downto 96) <= rs1(31 downto 0);
                           when "11----0100---------------" => 
                              Rd(15 downto 0) <= CGH(rs1(15 downto 0),rs2(15 downto 0));
                              Rd(31 downto 16) <= CGH(rs1(31 downto 16),rs2(31 downto 16));
                              Rd(47 downto 32) <= CGH(rs1(47 downto 32),rs2(47 downto 32));
                              Rd(63 downto 48) <= CGH(rs1(63 downto 48),rs2(63 downto 48));
                              Rd(79 downto 64) <= CGH(rs1(79 downto 64),rs2(79 downto 64));
                              Rd(95 downto 80) <= CGH(rs1(95 downto 80),rs2(95 downto 80));
                              Rd(111 downto 96) <= CGH(rs1(111 downto 96),rs2(111 downto 96));
                              Rd(127 downto 112) <= CGH(rs1(127 downto 112),rs2(127 downto 112));
                           when "11----0101---------------" => 
                              Rd(31 downto 0) <= CLZ(rs1(31 downto 0));
                              Rd(63 downto 32) <= CLZ(rs1(63 downto 32));
                              Rd(95 downto 64) <= CLZ(rs1(95 downto 64));
                              Rd(127 downto 96) <= CLZ(rs1(127 downto 96));
                           when "11----0110---------------" => 
                              if (signed(rs1(31 downto 0)) > signed(rs2(31 downto 0))) then
                                 Rd(31 downto 0) <= rs1(31 downto 0);
                              else 
                                 Rd(31 downto 0) <= rs2(31 downto 0);
                              end if;
                              if (signed(rs1(63 downto 32)) > signed(rs2(63 downto 32))) then
                                 Rd(63 downto 32) <= rs1(63 downto 32);
                              else 
                                 Rd(63 downto 32) <= rs2(63 downto 32);
                              end if;
                              if (signed(rs1(95 downto 64)) > signed(rs2(95 downto 64))) then
                                 Rd(95 downto 64) <= rs1(95 downto 64);
                              else 
                                 Rd(95 downto 64) <= rs2(95 downto 64);
                              end if;
                              if (signed(rs1(127 downto 96)) > signed(rs2(127 downto 96))) then
                                 Rd(127 downto 96) <= rs1(127 downto 96);
                              else 
                                 Rd(127 downto 96) <= rs2(127 downto 96);
                              end if;
                           when "11----0111---------------" => 
                              if (signed(rs1(31 downto 0)) < signed(rs2(31 downto 0))) then
                                 Rd(31 downto 0) <= rs1(31 downto 0);
                              else 
                                 Rd(31 downto 0) <= rs2(31 downto 0);
                              end if;
                              if (signed(rs1(63 downto 32)) < signed(rs2(63 downto 32))) then
                                 Rd(63 downto 32) <= rs1(63 downto 32);
                              else 
                                 Rd(63 downto 32) <= rs2(63 downto 32);
                              end if;
                              if (signed(rs1(95 downto 64)) < signed(rs2(95 downto 64))) then
                                 Rd(95 downto 64) <= rs1(95 downto 64);
                              else 
                                 Rd(95 downto 64) <= rs2(95 downto 64);
                              end if;
                              if (signed(rs1(127 downto 96)) < signed(rs2(127 downto 96))) then
                                 Rd(127 downto 96) <= rs1(127 downto 96);
                              else 
                                 Rd(127 downto 96) <= rs2(127 downto 96);
                              end if;
                           when "11----1000---------------" => 
                              Rd(31 downto 0) <= MSGN(rs1(31 downto 0),rs2(31 downto 0));
                              Rd(63 downto 32) <= MSGN(rs1(63 downto 32),rs2(63 downto 32));
                              Rd(95 downto 64) <= MSGN(rs1(95 downto 64),rs2(95 downto 64));
                              Rd(127 downto 96) <= MSGN(rs1(127 downto 96),rs2(127 downto 96));
                           when "11----1001---------------" => 
                              Rd(15 downto 0) <= COUNT_ONES(rs1(15 downto 0));
                              Rd(31 downto 16) <= COUNT_ONES(rs1(31 downto 16));
                              Rd(47 downto 32) <= COUNT_ONES(rs1(47 downto 32));
                              Rd(63 downto 48) <= COUNT_ONES(rs1(63 downto 48));
                              Rd(79 downto 64) <= COUNT_ONES(rs1(79 downto 64));
                              Rd(95 downto 80) <= COUNT_ONES(rs1(95 downto 80));
                              Rd(111 downto 96) <= COUNT_ONES(rs1(111 downto 96));
                              Rd(127 downto 112) <= COUNT_ONES(rs1(127 downto 112));
                           when "11----1010---------------" => 
                              Rd <= std_logic_vector(rotate_right(unsigned(rs1),to_integer(unsigned(rs2(6 downto 0)))));
                           when "11----1011---------------" => 
                              Rd(31 downto 0) <= std_logic_vector(rotate_right(unsigned(rs1(31 downto 0)),to_integer(unsigned(rs2(4 downto 0)))));
                              Rd(63 downto 32) <= std_logic_vector(rotate_right(unsigned(rs1(63 downto 32)),to_integer(unsigned(rs2(36 downto 32)))));
                              Rd(95 downto 64) <= std_logic_vector(rotate_right(unsigned(rs1(95 downto 64)),to_integer(unsigned(rs2(68 downto 64)))));
                              Rd(127 downto 96) <= std_logic_vector(rotate_right(unsigned(rs1(127 downto 96)),to_integer(unsigned(rs2(100 downto 96)))));
                           when "11----1100---------------" => 
                              Rd(15 downto 0) <= std_logic_vector(shift_left(unsigned(rs1(15 downto 0)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(31 downto 16) <= std_logic_vector(shift_left(unsigned(rs1(31 downto 16)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(47 downto 32) <= std_logic_vector(shift_left(unsigned(rs1(47 downto 32)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(63 downto 48) <= std_logic_vector(shift_left(unsigned(rs1(63 downto 48)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(79 downto 64) <= std_logic_vector(shift_left(unsigned(rs1(79 downto 64)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(95 downto 80) <= std_logic_vector(shift_left(unsigned(rs1(95 downto 80)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(111 downto 96) <= std_logic_vector(shift_left(unsigned(rs1(111 downto 96)),to_integer(unsigned(Op(13 downto 10)))));
                              Rd(127 downto 112) <= std_logic_vector(shift_left(unsigned(rs1(127 downto 112)),to_integer(unsigned(Op(13 downto 10)))));
                           when "11----1101---------------" => 
                              Rd(15 downto 0) <= std_logic_vector(unsigned(rs2(15 downto 0)) - unsigned(rs1(15 downto 0)));
                              Rd(31 downto 16) <= std_logic_vector(unsigned(rs2(31 downto 16)) - unsigned(rs1(31 downto 16)));
                              Rd(47 downto 32) <= std_logic_vector(unsigned(rs2(47 downto 32)) - unsigned(rs1(47 downto 32)));
                              Rd(63 downto 48) <= std_logic_vector(unsigned(rs2(63 downto 48)) - unsigned(rs1(63 downto 48)));
                              Rd(79 downto 64) <= std_logic_vector(unsigned(rs2(79 downto 64)) - unsigned(rs1(79 downto 64)));
                              Rd(95 downto 80) <= std_logic_vector(unsigned(rs2(95 downto 80)) - unsigned(rs1(95 downto 80)));
                              Rd(111 downto 96) <= std_logic_vector(unsigned(rs2(111 downto 96)) - unsigned(rs1(111 downto 96)));
                              Rd(127 downto 112) <= std_logic_vector(unsigned(rs2(127 downto 112)) - unsigned(rs1(127 downto 112)));
                           when "11----1110---------------" => 
                              Rd(15 downto 0) <= SAT(not rs1(15),rs2(15),std_logic_vector(signed(rs2(15 downto 0)) - signed(rs1(15 downto 0))));
                              Rd(31 downto 16) <= SAT(not rs1(31),rs2(31),std_logic_vector(signed(rs2(31 downto 16)) - signed(rs1(31 downto 16))));
                              Rd(47 downto 32) <= SAT(not rs1(47),rs2(47),std_logic_vector(signed(rs2(47 downto 32)) - signed(rs1(47 downto 32))));
                              Rd(63 downto 48) <= SAT(not rs1(63),rs2(63),std_logic_vector(signed(rs2(63 downto 48)) - signed(rs1(63 downto 48))));
                              Rd(79 downto 64) <= SAT(not rs1(79),rs2(79),std_logic_vector(signed(rs2(79 downto 64)) - signed(rs1(79 downto 64))));
                              Rd(95 downto 80) <= SAT(not rs1(95),rs2(95),std_logic_vector(signed(rs2(95 downto 80)) - signed(rs1(95 downto 80))));
                              Rd(111 downto 96) <= SAT(not rs1(111),rs2(111),std_logic_vector(signed(rs2(111 downto 96)) - signed(rs1(111 downto 96))));
                              Rd(127 downto 112) <= SAT(not rs1(127),rs2(127),std_logic_vector(signed(rs2(127 downto 112)) - signed(rs1(127 downto 112))));
                           when "11----1111---------------" => 
                              Rd <= rs1 xor rs2;
                           when others => 
                              Rd <= z128;
                         end case;
                       end process;
                      

end behavioral;
