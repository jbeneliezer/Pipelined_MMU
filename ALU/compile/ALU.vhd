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
-- Generated   : Mon Apr  5 18:52:13 2021
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
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       Rd : out STD_LOGIC_VECTOR(127 downto 0)
  );
end ALU;

architecture behavioral of ALU is

---- Architecture declarations -----
constant max16 : signed := "0111111111111111";
constant min16 : signed := "1000000000000000";
constant max32 : signed := "01111111111111111111111111111111";
constant min32 : signed := "10000000000000000000000000000000";
constant max64 : signed := "0111111111111111111111111111111111111111111111111111111111111111";
constant min64 : signed := "1000000000000000000000000000000000000000000000000000000000000000";
function MULT_ADD_I (x : std_logic_vector(15 downto 0);y : std_logic_vector(15 downto 0);z : std_logic_vector(31 downto 0)) return STD_LOGIC_VECTOR is 
                       variable product : signed(31 downto 0);
                       variable sum : signed(31 downto 0);
                     begin
                       product := signed(x) * signed(y);
                       sum := product + signed(z);
                       if (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '1') then
                          sum := max32;
                       elsif (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '0') then
                          sum := min32;
                       end if;
                       return std_logic_vector(sum);
                     end function MULT_ADD_I;
function MULT_SUB_I (x : std_logic_vector(15 downto 0);y : std_logic_vector(15 downto 0);z : std_logic_vector(31 downto 0)) return STD_LOGIC_VECTOR is 
                       variable product : signed(31 downto 0);
                       variable dif : signed(31 downto 0);
                     begin
                       product := signed(x) * signed(y);
                       dif := signed(z) - product;
                       if (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '1') then
                          dif := max32;
                       elsif (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '0') then
                          dif := min32;
                       end if;
                       return std_logic_vector(dif);
                     end function MULT_SUB_I;
function MULT_ADD_L (x : std_logic_vector(31 downto 0);y : std_logic_vector(31 downto 0);z : std_logic_vector(63 downto 0)) return STD_LOGIC_VECTOR is 
                       variable product : signed(63 downto 0);
                       variable sum : signed(63 downto 0);
                     begin
                       product := signed(x) * signed(y);
                       sum := product + signed(z);
                       if (product(63) = z(63) and not z(63) = sum(63) and sum(63) = '1') then
                          sum := max64;
                       elsif (product(63) = z(63) and not z(63) = sum(63) and sum(63) = '0') then
                          sum := min64;
                       end if;
                       return std_logic_vector(sum);
                     end function MULT_ADD_L;
function MULT_SUB_L (x : std_logic_vector(31 downto 0);y : std_logic_vector(31 downto 0);z : std_logic_vector(63 downto 0)) return STD_LOGIC_VECTOR is 
                       variable product : signed(63 downto 0);
                       variable dif : signed(63 downto 0);
                     begin
                       product := signed(x) * signed(y);
                       dif := signed(z) - product;
                       if (not product(63) = z(63) and not z(63) = dif(63) and dif(63) = '1') then
                          dif := max64;
                       elsif (not product(63) = z(63) and not z(63) = dif(63) and dif(63) = '0') then
                          dif := min64;
                       end if;
                       return std_logic_vector(dif);
                     end function MULT_SUB_L;



begin

---- Processes ----

process (Op,rs1,rs2,rs3(127 downto 96),rs3(63 downto 32),rs3(95 downto 64),rs3(31 downto 0),rs3(127 downto 112),rs3(95 downto 80),rs3(63 downto 48),rs3(31 downto 16),rs3(111 downto 96),rs3(79 downto 64),rs3(47 downto 32),rs3(15 downto 0),Rd(127),Rd(111),Rd(95),Rd(79),Rd(63),Rd(47),Rd(31),Rd(15))
                         variable count : unsigned(31 downto 0);
                       begin
                         case (Op) is 
                           when "0------------------------" => 
                              case (op(23 downto 21)) is 
                                when "000" => 
                                   Rd(15 downto 0) <= Op(20 downto 5);
                                when "001" => 
                                   Rd(31 downto 16) <= Op(20 downto 5);
                                when "010" => 
                                   Rd(47 downto 32) <= Op(20 downto 5);
                                when "011" => 
                                   Rd(63 downto 48) <= Op(20 downto 5);
                                when "100" => 
                                   Rd(79 downto 64) <= Op(20 downto 5);
                                when "101" => 
                                   Rd(95 downto 80) <= Op(20 downto 5);
                                when "110" => 
                                   Rd(111 downto 96) <= Op(20 downto 5);
                                when "111" => 
                                   Rd(127 downto 112) <= Op(20 downto 5);
                                when others => 
                                   null;
                              end case;
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
                              Rd(31 downto 0) <= MULT_ADD_L(rs3(31 downto 0),rs2(31 downto 0),rs1(63 downto 0));
                              Rd(63 downto 32) <= MULT_ADD_L(rs3(95 downto 64),rs2(95 downto 64),rs1(127 downto 64));
                           when "10101--------------------" => 
                              Rd(31 downto 0) <= MULT_ADD_L(rs3(63 downto 32),rs2(63 downto 32),rs1(63 downto 0));
                              Rd(63 downto 32) <= MULT_ADD_L(rs3(127 downto 96),rs2(127 downto 96),rs1(127 downto 64));
                           when "10110--------------------" => 
                              Rd(31 downto 0) <= MULT_SUB_L(rs3(31 downto 0),rs2(31 downto 0),rs1(63 downto 0));
                              Rd(63 downto 32) <= MULT_SUB_L(rs3(95 downto 64),rs2(95 downto 64),rs1(127 downto 64));
                           when "10111--------------------" => 
                              Rd(31 downto 0) <= MULT_SUB_L(rs3(63 downto 32),rs2(63 downto 32),rs1(63 downto 0));
                              Rd(63 downto 32) <= MULT_SUB_L(rs3(127 downto 96),rs2(127 downto 96),rs1(127 downto 64));
                           when "11----0000---------------" => 
                              null;
                           when "11----0001---------------" => 
                              Rd(31 downto 0) <= std_logic_vector(unsigned(rs1(31 downto 0)) + unsigned(rs2(31 downto 0)));
                              Rd(63 downto 32) <= std_logic_vector(unsigned(rs1(63 downto 32)) + unsigned(rs2(63 downto 32)));
                              Rd(95 downto 64) <= std_logic_vector(unsigned(rs1(95 downto 64)) + unsigned(rs2(95 downto 64)));
                              Rd(127 downto 96) <= std_logic_vector(unsigned(rs1(127 downto 96)) + unsigned(rs2(127 downto 96)));
                           when "11----0010---------------" => 
                              Rd <= std_logic_vector(abs (signed(rs2) - signed(rs1)));
                           when "11----0011---------------" => 
                              Rd(15 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) + unsigned(rs2(15 downto 0)));
                              Rd(31 downto 16) <= std_logic_vector(unsigned(rs1(31 downto 16)) + unsigned(rs2(31 downto 16)));
                              Rd(47 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) + unsigned(rs2(47 downto 32)));
                              Rd(63 downto 48) <= std_logic_vector(unsigned(rs1(63 downto 48)) + unsigned(rs2(63 downto 48)));
                              Rd(79 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) + unsigned(rs2(79 downto 64)));
                              Rd(95 downto 80) <= std_logic_vector(unsigned(rs1(95 downto 80)) + unsigned(rs2(95 downto 80)));
                              Rd(111 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) + unsigned(rs2(111 downto 96)));
                              Rd(127 downto 112) <= std_logic_vector(unsigned(rs1(127 downto 112)) + unsigned(rs2(127 downto 112)));
                           when "11----0100---------------" => 
                              Rd(15 downto 0) <= std_logic_vector(signed(rs1(15 downto 0)) + signed(rs2(15 downto 0)));
                              Rd(31 downto 16) <= std_logic_vector(signed(rs1(31 downto 16)) + signed(rs2(31 downto 16)));
                              Rd(47 downto 32) <= std_logic_vector(signed(rs1(47 downto 32)) + signed(rs2(47 downto 32)));
                              Rd(63 downto 48) <= std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48)));
                              Rd(79 downto 64) <= std_logic_vector(signed(rs1(79 downto 64)) + signed(rs2(79 downto 64)));
                              Rd(95 downto 80) <= std_logic_vector(signed(rs1(95 downto 80)) + signed(rs2(95 downto 80)));
                              Rd(111 downto 96) <= std_logic_vector(signed(rs1(111 downto 96)) + signed(rs2(111 downto 96)));
                              Rd(127 downto 112) <= std_logic_vector(signed(rs1(127 downto 112)) + signed(rs2(127 downto 112)));
                              if (rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '1') then
                                 Rd(15 downto 0) <= std_logic_vector(max16);
                              elsif (rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '0') then
                                 Rd(15 downto 0) <= std_logic_vector(min16);
                              end if;
                              if (rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '1') then
                                 Rd(31 downto 16) <= std_logic_vector(max16);
                              elsif (rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '0') then
                                 Rd(31 downto 16) <= std_logic_vector(min16);
                              end if;
                              if (rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '1') then
                                 Rd(47 downto 32) <= std_logic_vector(max16);
                              elsif (rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '0') then
                                 Rd(47 downto 32) <= std_logic_vector(min16);
                              end if;
                              if (rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '1') then
                                 Rd(63 downto 48) <= std_logic_vector(max16);
                              elsif (rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '0') then
                                 Rd(63 downto 48) <= std_logic_vector(min16);
                              end if;
                              if (rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '1') then
                                 Rd(79 downto 64) <= std_logic_vector(max16);
                              elsif (rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '0') then
                                 Rd(79 downto 64) <= std_logic_vector(min16);
                              end if;
                              if (rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '1') then
                                 Rd(95 downto 80) <= std_logic_vector(max16);
                              elsif (rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '0') then
                                 Rd(95 downto 80) <= std_logic_vector(min16);
                              end if;
                              if (rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '1') then
                                 Rd(111 downto 96) <= std_logic_vector(max16);
                              elsif (rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '0') then
                                 Rd(111 downto 96) <= std_logic_vector(min16);
                              end if;
                              if (rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '1') then
                                 Rd(127 downto 112) <= std_logic_vector(max16);
                              elsif (rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '0') then
                                 Rd(127 downto 112) <= std_logic_vector(min16);
                              end if;
                           when "11----0101---------------" => 
                              Rd <= rs1 and rs2;
                           when "11----0110---------------" => 
                              Rd(31 downto 0) <= rs2(31 downto 0);
                              Rd(63 downto 32) <= rs2(31 downto 0);
                              Rd(95 downto 64) <= rs2(31 downto 0);
                              Rd(127 downto 96) <= rs2(31 downto 0);
                           when "11----0111---------------" => 
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
                           when "11----1000---------------" => 
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
                           when "11----1001---------------" => 
                              Rd(31 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) * unsigned(rs2(15 downto 0)));
                              Rd(63 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) * unsigned(rs2(47 downto 32)));
                              Rd(95 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) * unsigned(rs2(79 downto 64)));
                              Rd(127 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) * unsigned(rs2(111 downto 96)));
                           when "11----1010---------------" => 
                              Rd(31 downto 0) <= "00000000000" & std_logic_vector(unsigned(rs2(15 downto 0)) * unsigned(op(14 downto 10)));
                              Rd(63 downto 32) <= "00000000000" & std_logic_vector(unsigned(rs2(47 downto 32)) * unsigned(op(14 downto 10)));
                              Rd(95 downto 64) <= "00000000000" & std_logic_vector(unsigned(rs2(79 downto 64)) * unsigned(op(14 downto 10)));
                              Rd(127 downto 96) <= "00000000000" & std_logic_vector(unsigned(rs2(111 downto 96)) * unsigned(op(14 downto 10)));
                           when "11----1011---------------" => 
                              Rd <= rs1 or rs2;
                           when "11----1100---------------" => 
                              count := "00000000000000000000000000000000";
                              for a in 0 to 31 loop
                                  count := count + unsigned("0000000000000000000000000000000" & rs2(a));
                              end loop;
                              Rd(31 downto 0) <= std_logic_vector(count);
                              count := "00000000000000000000000000000000";
                              for a in 32 to 63 loop
                                  count := count + unsigned("0000000000000000000000000000000" & rs2(a));
                              end loop;
                              Rd(63 downto 32) <= std_logic_vector(count);
                              count := "00000000000000000000000000000000";
                              for a in 64 to 95 loop
                                  count := count + unsigned("0000000000000000000000000000000" & rs2(a));
                              end loop;
                              Rd(95 downto 64) <= std_logic_vector(count);
                              count := "00000000000000000000000000000000";
                              for a in 96 to 127 loop
                                  count := count + unsigned("0000000000000000000000000000000" & rs2(a));
                              end loop;
                              Rd(127 downto 96) <= std_logic_vector(count);
                           when "11----1101---------------" => 
                              Rd(31 downto 0) <= std_logic_vector(rotate_right(unsigned(rs2(31 downto 0)),to_integer(unsigned(rs1(4 downto 0)))));
                              Rd(63 downto 32) <= std_logic_vector(rotate_right(unsigned(rs2(63 downto 32)),to_integer(unsigned(rs1(4 downto 0)))));
                              Rd(95 downto 64) <= std_logic_vector(rotate_right(unsigned(rs2(95 downto 64)),to_integer(unsigned(rs1(4 downto 0)))));
                              Rd(127 downto 96) <= std_logic_vector(rotate_right(unsigned(rs2(127 downto 96)),to_integer(unsigned(rs1(4 downto 0)))));
                           when "11----1110---------------" => 
                              Rd(15 downto 0) <= std_logic_vector(signed(rs1(15 downto 0)) - signed(rs2(15 downto 0)));
                              Rd(31 downto 16) <= std_logic_vector(signed(rs1(31 downto 16)) - signed(rs2(31 downto 16)));
                              Rd(47 downto 32) <= std_logic_vector(signed(rs1(47 downto 32)) - signed(rs2(47 downto 32)));
                              Rd(63 downto 48) <= std_logic_vector(signed(rs1(63 downto 48)) - signed(rs2(63 downto 48)));
                              Rd(79 downto 64) <= std_logic_vector(signed(rs1(79 downto 64)) - signed(rs2(79 downto 64)));
                              Rd(95 downto 80) <= std_logic_vector(signed(rs1(95 downto 80)) - signed(rs2(95 downto 80)));
                              Rd(111 downto 96) <= std_logic_vector(signed(rs1(111 downto 96)) - signed(rs2(111 downto 96)));
                              Rd(127 downto 112) <= std_logic_vector(signed(rs1(127 downto 112)) - signed(rs2(127 downto 112)));
                              if (not rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '1') then
                                 Rd(15 downto 0) <= std_logic_vector(max16);
                              elsif (not rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '0') then
                                 Rd(15 downto 0) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '1') then
                                 Rd(31 downto 16) <= std_logic_vector(max16);
                              elsif (not rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '0') then
                                 Rd(31 downto 16) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '1') then
                                 Rd(47 downto 32) <= std_logic_vector(max16);
                              elsif (not rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '0') then
                                 Rd(47 downto 32) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '1') then
                                 Rd(63 downto 48) <= std_logic_vector(max16);
                              elsif (not rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '0') then
                                 Rd(63 downto 48) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '1') then
                                 Rd(79 downto 64) <= std_logic_vector(max16);
                              elsif (not rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '0') then
                                 Rd(79 downto 64) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '1') then
                                 Rd(95 downto 80) <= std_logic_vector(max16);
                              elsif (not rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '0') then
                                 Rd(95 downto 80) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '1') then
                                 Rd(111 downto 96) <= std_logic_vector(max16);
                              elsif (not rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '0') then
                                 Rd(111 downto 96) <= std_logic_vector(min16);
                              end if;
                              if (not rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '1') then
                                 Rd(127 downto 112) <= std_logic_vector(max16);
                              elsif (not rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '0') then
                                 Rd(127 downto 112) <= std_logic_vector(min16);
                              end if;
                           when "11----1111---------------" => 
                              Rd(31 downto 0) <= std_logic_vector(unsigned(rs1(31 downto 0)) - unsigned(rs2(31 downto 0)));
                              Rd(63 downto 32) <= std_logic_vector(unsigned(rs1(63 downto 32)) - unsigned(rs2(63 downto 32)));
                              Rd(95 downto 64) <= std_logic_vector(unsigned(rs1(95 downto 64)) - unsigned(rs2(95 downto 64)));
                              Rd(127 downto 96) <= std_logic_vector(unsigned(rs1(127 downto 96)) - unsigned(rs2(127 downto 96)));
                           when others => 
                              null;
                         end case;
                       end process;
                      

end behavioral;
