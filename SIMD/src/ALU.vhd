-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\SIMD\SIMD\src\ALU.vhd
-- Generated   : Tue Mar 23 15:35:33 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 25 input Opcode ALU
--
-------------------------------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ALU_functions.all;
use work.data_types.all;

entity ALU is
	port(					
		input: in idex;								-- input.opcode and three source registers
		rd : out std_logic_vector(127 downto 0)		-- Destination Register
		);
end ALU;

architecture behavioral of ALU is							  
begin  		
	process(all)		
		variable l_tmp : std_logic_vector(127 downto 0) := (others => '0');
	begin
		case? (input.op) is
			
			-- li format:
			--  24  23		  21 20		   5 4	0
			-- -----------------------------------
			-- | 0 | Load Index | Immediate | rd |
			-- -----------------------------------
			
			when "0------------------------" =>		-- LI  
				l_tmp := input.rs1;
				case (input.op(23 downto 21)) is									-- set the specied range of rd to immediate
					when "000" => l_tmp(15 downto 0) := input.op(20 downto 5);			 
					when "001" => l_tmp(31 downto 16) := input.op(20 downto 5);
					when "010" => l_tmp(47 downto 32) := input.op(20 downto 5);
					when "011" => l_tmp(63 downto 48) := input.op(20 downto 5);
					when "100" => l_tmp(79 downto 64) := input.op(20 downto 5);
					when "101" => l_tmp(95 downto 80) := input.op(20 downto 5);
					when "110" => l_tmp(111 downto 96) := input.op(20 downto 5);
					when "111" => l_tmp(127 downto 112) := input.op(20 downto 5);
					when others => null;
			    end case;
				rd <= l_tmp;
			
			-- R4 format:
			--  24  23	    22	         21           20     19 15 14 10 9   5 4  0
			-- ---------------------------------------------------------------------
			-- | 1 | 0 | Long/Int | Subtract/Add | High/Low | input.rs3 | input.rs2 | input.rs1 | rd |
			-- ---------------------------------------------------------------------
			
			when "10000--------------------" =>		-- SIMALS:
			
				-- Signed Integer Multiply-Add Low with Saturation: Multiply low 16-bit-fields of
				-- each 32-bit field of registers input.rs3 and input.rs2, then add 32-bit products to 32-bit fields of
				-- register input.rs1, and save result in register rd.
				
				rd(31 downto 0) <= MULT_ADD_I(input.rs3(15 downto 0), input.rs2(15 downto 0), input.rs1(31 downto 0));
				rd(63 downto 32) <= MULT_ADD_I(input.rs3(47 downto 32), input.rs2(47 downto 32), input.rs1(63 downto 32));
				rd(95 downto 64) <= MULT_ADD_I(input.rs3(79 downto 64), input.rs2(79 downto 64), input.rs1(95 downto 64));
			    rd(127 downto 96) <= MULT_ADD_I(input.rs3(111 downto 96), input.rs2(111 downto 96), input.rs1(127 downto 96));
				
			when "10001--------------------" =>		-- SIMAHS:
			
				-- Signed Integer Multiply-Add High with Saturation: Multiply high 16-bit-fields
				-- of each 32-bit field of registers input.rs3 and input.rs2, then add 32-bit products to 32-bit fields of
				-- register input.rs1, and save result in register rd.
				
				rd(31 downto 0) <= MULT_ADD_I(input.rs3(31 downto 16), input.rs2(31 downto 16), input.rs1(31 downto 0));
				rd(63 downto 32) <= MULT_ADD_I(input.rs3(63 downto 48), input.rs2(63 downto 48), input.rs1(63 downto 32));
				rd(95 downto 64) <= MULT_ADD_I(input.rs3(95 downto 80), input.rs2(95 downto 80), input.rs1(95 downto 64));
			    rd(127 downto 96) <= MULT_ADD_I(input.rs3(127 downto 112), input.rs2(127 downto 112), input.rs1(127 downto 96));
				
			when "10010--------------------" => 	-- SIMSLS:
			
				-- Signed Integer Multiply-Subtract Low with Saturation: Multiply low 16-bit-fields
				-- of each 32-bit field of registers input.rs3 and input.rs2, then subtract 32-bit products from 32-bit
				-- fields of register input.rs1, and save result in register rd.
				
				rd(31 downto 0) <= MULT_SUB_I(input.rs3(15 downto 0), input.rs2(15 downto 0), input.rs1(31 downto 0));
				rd(63 downto 32) <= MULT_SUB_I(input.rs3(47 downto 32), input.rs2(47 downto 32), input.rs1(63 downto 32));
				rd(95 downto 64) <= MULT_SUB_I(input.rs3(79 downto 64), input.rs2(79 downto 64), input.rs1(95 downto 64));
			    rd(127 downto 96) <= MULT_SUB_I(input.rs3(111 downto 96), input.rs2(111 downto 96), input.rs1(127 downto 96));
				
			when "10011--------------------" => 	-- SIMSHS:
			
				-- Signed Integer Multiply-Subtract High with Saturation: Multiply high 16-bitfields
				-- of each 32-bit field of registers input.rs3 and input.rs2, then subtract 32-bit products from
				-- 32-bit fields of register input.rs1, and save result in register rd.
				
				rd(31 downto 0) <= MULT_SUB_I(input.rs3(31 downto 16), input.rs2(31 downto 16), input.rs1(31 downto 0));
				rd(63 downto 32) <= MULT_SUB_I(input.rs3(63 downto 48), input.rs2(63 downto 48), input.rs1(63 downto 32));
				rd(95 downto 64) <= MULT_SUB_I(input.rs3(95 downto 80), input.rs2(95 downto 80), input.rs1(95 downto 64));
			    rd(127 downto 96) <= MULT_SUB_I(input.rs3(127 downto 112), input.rs2(127 downto 112), input.rs1(127 downto 96));
				
			when "10100--------------------" => 	-- SLIMALS:
			
				-- Signed Long Integer Multiply-Add Low with Saturation: Multiply low 32-bitfields
				-- of each 64-bit field of registers input.rs3 and input.rs2, then add 64-bit products to 64-bit fields
				-- of register input.rs1, and save result in register rd.
				
				rd(63 downto 0) <= MULT_ADD_L(input.rs3(31 downto 0), input.rs2(31 downto 0), input.rs1(63 downto 0));
			    rd(127 downto 64) <= MULT_ADD_L(input.rs3(95 downto 64), input.rs2(95 downto 64), input.rs1(127 downto 64));
				
			when "10101--------------------" => 	-- SLIMAHS:
			
				-- Signed Long Integer Multiply-Add High with Saturation: Multiply high 32-bitfields
				-- of each 64-bit field of registers input.rs3 and input.rs2, then add 64-bit products to 64-bit fields
				-- of register input.rs1, and save result in register rd.

				rd(63 downto 0) <= MULT_ADD_L(input.rs3(63 downto 32), input.rs2(63 downto 32), input.rs1(63 downto 0));
			    rd(127 downto 64) <= MULT_ADD_L(input.rs3(127 downto 96), input.rs2(127 downto 96), input.rs1(127 downto 64));
				
			when "10110--------------------" => 	-- SLIMSLS:
			
				-- Signed Long Integer Multiply-Subtract Low with Saturation: Multiply low 32-
				-- bit-fields of each 64-bit field of registers input.rs3 and input.rs2, then subtract 64-bit products from
				-- 64-bit fields of register input.rs1, and save result in register rd.

				rd(63 downto 0) <= MULT_SUB_L(input.rs3(31 downto 0), input.rs2(31 downto 0), input.rs1(63 downto 0));
			    rd(127 downto 64) <= MULT_SUB_L(input.rs3(95 downto 64), input.rs2(95 downto 64), input.rs1(127 downto 64));
				
			when "10111--------------------" =>  	-- SLIMSHS:
			
				-- Signed Long Integer Multiply-Subtract High with Saturation: Multiply high 32-
				-- bit-fields of each 64-bit field of registers input.rs3 and input.rs2, then subtract 64-bit products from
				-- 64-bit fields of register input.rs1, and save result in register rd.

				rd(63 downto 0) <= MULT_SUB_L(input.rs3(63 downto 32), input.rs2(63 downto 32), input.rs1(63 downto 0));
			    rd(127 downto 64) <= MULT_SUB_L(input.rs3(127 downto 96), input.rs2(127 downto 96), input.rs1(127 downto 64));
				
			-- R3 format:
			--  24  23	22	  15 14 10 9   5 4  0
			-- -----------------------------------
			-- | 1 | 1 | input.opcode | input.rs2 | input.rs1 | rd |
			-- ----------------------------------- 
			
			when "11----0000---------------" => 	-- NOP
				rd <= (others => '0');
			when "11----0001---------------" =>   	-- AH:
			
				-- add halfword: packed 16-bit halfword unsigned addition of the contents of registers
				-- input.rs1 and input.rs2.

				rd(15 downto 0) <= std_logic_vector(unsigned(input.rs1(15 downto 0)) + unsigned(input.rs2(15 downto 0)));
				rd(31 downto 16) <= std_logic_vector(unsigned(input.rs1(31 downto 16)) + unsigned(input.rs2(31 downto 16)));
				rd(47 downto 32) <= std_logic_vector(unsigned(input.rs1(47 downto 32)) + unsigned(input.rs2(47 downto 32)));
				rd(63 downto 48) <= std_logic_vector(unsigned(input.rs1(63 downto 48)) + unsigned(input.rs2(63 downto 48)));
				rd(79 downto 64) <= std_logic_vector(unsigned(input.rs1(79 downto 64)) + unsigned(input.rs2(79 downto 64)));
				rd(95 downto 80) <= std_logic_vector(unsigned(input.rs1(95 downto 80)) + unsigned(input.rs2(95 downto 80)));
				rd(111 downto 96) <= std_logic_vector(unsigned(input.rs1(111 downto 96)) + unsigned(input.rs2(111 downto 96)));
				rd(127 downto 112) <= std_logic_vector(unsigned(input.rs1(127 downto 112)) + unsigned(input.rs2(127 downto 112)));
				
			when "11----0010---------------" =>		-- AHS:
			
				-- add halfword saturated: packed 16-bit halfword signed addition with saturation
				-- of the contents of registers input.rs1 and input.rs2.

				rd(15 downto 0) <= SAT(input.rs1(15), input.rs2(15), std_logic_vector(signed(input.rs1(15 downto 0)) + signed(input.rs2(15 downto 0))));
				rd(31 downto 16) <= SAT(input.rs1(31), input.rs2(31), std_logic_vector(signed(input.rs1(31 downto 16)) + signed(input.rs2(31 downto 16))));
				rd(47 downto 32) <= SAT(input.rs1(47), input.rs2(47), std_logic_vector(signed(input.rs1(47 downto 32)) + signed(input.rs2(47 downto 32))));
				rd(63 downto 48) <= SAT(input.rs1(63), input.rs2(63), std_logic_vector(signed(input.rs1(63 downto 48)) + signed(input.rs2(63 downto 48))));
				rd(79 downto 64) <= SAT(input.rs1(79), input.rs2(79), std_logic_vector(signed(input.rs1(79 downto 64)) + signed(input.rs2(79 downto 64))));
				rd(95 downto 80) <= SAT(input.rs1(95), input.rs2(95), std_logic_vector(signed(input.rs1(95 downto 80)) + signed(input.rs2(95 downto 80))));
				rd(111 downto 96) <= SAT(input.rs1(111), input.rs2(111), std_logic_vector(signed(input.rs1(111 downto 96)) + signed(input.rs2(111 downto 96))));
				rd(127 downto 112) <= SAT(input.rs1(127), input.rs2(127), std_logic_vector(signed(input.rs1(127 downto 112)) + signed(input.rs2(127 downto 112))));
				
			when "11----0011---------------" =>		-- BCW:
			
				-- broadcast word: broadcast the rightmost 32-bit word of register input.rs1 to each of the
				-- four 32-bit words of register rd.

				rd(31 downto 0) <= input.rs1(31 downto 0);
				rd(63 downto 32) <= input.rs1(31 downto 0);
				rd(95 downto 64) <= input.rs1(31 downto 0);
			    rd(127 downto 96) <= input.rs1(31 downto 0);
				
			when "11----0100---------------" =>		-- CGH:
			
				-- carry generate halfword: for each of the eight 16-bit halfword slots, the unsigned
				-- value of register input.rs1 is added to the unsigned value of register input.rs2, and the carry out bit
				-- placed in register rd. 

				rd(15 downto 0) <= CGH(input.rs1(15 downto 0), input.rs2(15 downto 0));
				rd(31 downto 16) <= CGH(input.rs1(31 downto 16), input.rs2(31 downto 16));
				rd(47 downto 32) <= CGH(input.rs1(47 downto 32), input.rs2(47 downto 32));
				rd(63 downto 48) <= CGH(input.rs1(63 downto 48), input.rs2(63 downto 48));
				rd(79 downto 64) <= CGH(input.rs1(79 downto 64), input.rs2(79 downto 64));
				rd(95 downto 80) <= CGH(input.rs1(95 downto 80), input.rs2(95 downto 80));
				rd(111 downto 96) <= CGH(input.rs1(111 downto 96), input.rs2(111 downto 96));
				rd(127 downto 112) <= CGH(input.rs1(127 downto 112), input.rs2(127 downto 112));
				
			when "11----0101---------------" =>		-- CLZ:
			
				-- count leading zeros in words: for each of the four 32-bit word slots in register input.rs1
				-- the number of zero bits to the left of the first non-zero bit is computed. If the word slot
				-- in register input.rs1 is zero, the result is 32. The four results are placed into the corresponding
				-- 32-bit word slots in register rd. 

				rd(31 downto 0) <= CLZ(input.rs1(31 downto 0));
				rd(63 downto 32) <= CLZ(input.rs1(63 downto 32));
				rd(95 downto 64) <= CLZ(input.rs1(95 downto 64));
			    rd(127 downto 96) <= CLZ(input.rs1(127 downto 96));
				
			when "11----0110---------------" =>		-- MAX:
			
				-- max signed word: for each of the four 32-bit word slots, place the maximum signed
				-- value between input.rs1 and input.rs2 in register rd.

				if (signed(input.rs1(31 downto 0)) > signed(input.rs2(31 downto 0))) then
					rd(31 downto 0) <= input.rs1(31 downto 0);
				else
					rd(31 downto 0) <= input.rs2(31 downto 0);
				end if;
				if (signed(input.rs1(63 downto 32)) > signed(input.rs2(63 downto 32))) then
					rd(63 downto 32) <= input.rs1(63 downto 32);
				else
					rd(63 downto 32) <= input.rs2(63 downto 32);  
				end if;
				if (signed(input.rs1(95 downto 64)) > signed(input.rs2(95 downto 64))) then
					rd(95 downto 64) <= input.rs1(95 downto 64);
				else
					rd(95 downto 64) <= input.rs2(95 downto 64);  
				end if;
				if (signed(input.rs1(127 downto 96)) > signed(input.rs2(127 downto 96))) then
					rd(127 downto 96) <= input.rs1(127 downto 96);
				else
					rd(127 downto 96) <= input.rs2(127 downto 96);
			    end if;
				
			when "11----0111---------------" =>		-- MIN:
			
				-- min signed word: for each of the four 32-bit word slots, place the minimum signed
				-- value between input.rs1 and input.rs2 in register rd.

				if (signed(input.rs1(31 downto 0)) < signed(input.rs2(31 downto 0))) then
					rd(31 downto 0) <= input.rs1(31 downto 0);
				else
					rd(31 downto 0) <= input.rs2(31 downto 0);
				end if;	 
				if (signed(input.rs1(63 downto 32)) < signed(input.rs2(63 downto 32))) then
					rd(63 downto 32) <= input.rs1(63 downto 32);
				else
					rd(63 downto 32) <= input.rs2(63 downto 32);
				end if;
				if (signed(input.rs1(95 downto 64)) < signed(input.rs2(95 downto 64))) then
					rd(95 downto 64) <= input.rs1(95 downto 64);
				else
					rd(95 downto 64) <= input.rs2(95 downto 64);
				end if;	
				if (signed(input.rs1(127 downto 96)) < signed(input.rs2(127 downto 96))) then
					rd(127 downto 96) <= input.rs1(127 downto 96);
				else
					rd(127 downto 96) <= input.rs2(127 downto 96);
			    end if;
				
			when "11----1000---------------" =>		-- MSGN:
			
				-- multiply sign: for each of the four 32-bit word slots, the signed value in register
				-- input.rs1 is multiplied by the sign of the word in vector input.rs2 with saturation, and the result
				-- placed in register rd. If the value in register input.rs2 is zero, the corresponding 32-bit field in
				-- rd will also be zero.

				rd(31 downto 0) <= MSGN(input.rs1(31 downto 0), input.rs2(31 downto 0));
				rd(63 downto 32) <= MSGN(input.rs1(63 downto 32), input.rs2(63 downto 32));
				rd(95 downto 64) <= MSGN(input.rs1(95 downto 64), input.rs2(95 downto 64));
			    rd(127 downto 96) <= MSGN(input.rs1(127 downto 96), input.rs2(127 downto 96));
				
			when "11----1001---------------" =>		-- POPCNTH:
			
				-- count ones in halfwords: the number of ones in each of the eight halfword
				-- slots in register input.rs1 is computed. If the halfword slot in register input.rs1 is zero, the result
				-- is also 0. Each of the results is placed into corresponding 16-bit slots in register rd.

				rd(15 downto 0) <= COUNT_ONES(input.rs1(15 downto 0));
				rd(31 downto 16) <= COUNT_ONES(input.rs1(31 downto 16));
				rd(47 downto 32) <= COUNT_ONES(input.rs1(47 downto 32));
				rd(63 downto 48) <= COUNT_ONES(input.rs1(63 downto 48));
				rd(79 downto 64) <= COUNT_ONES(input.rs1(79 downto 64));
				rd(95 downto 80) <= COUNT_ONES(input.rs1(95 downto 80));
				rd(111 downto 96) <= COUNT_ONES(input.rs1(111 downto 96));
				rd(127 downto 112) <= COUNT_ONES(input.rs1(127 downto 112));
			when "11----1010---------------" =>		-- ROT:
			
				-- rotate bits right: the contents of register input.rs1 are rotated to the right according to
				-- the value of the 7 least significant bits (6 to 0) of input.rs2. The result is placed in register rd.
				-- Bits rotated out of the right end of the 128-bit contents of register input.rs1 are rotated in at
				-- the left end.

				rd <= std_logic_vector(rotate_right(unsigned(input.rs1), to_integer(unsigned(input.rs2(6 downto 0)))));
				
			when "11----1011---------------" =>		-- ROTW:
			
				-- rotate bits in word: the contents of each 32-bit field in register input.rs1 are rotated
				-- to the right according to the value of the 5 least significant bits of the corresponding 32-bit
				-- field in register input.rs2. The results are placed in register rd. Bits rotated out of the right
				-- end of each word are rotated in on the left end of the same 32-bit word field. 

				rd(31 downto 0) <= std_logic_vector(rotate_right(unsigned(input.rs1(31 downto 0)), to_integer(unsigned(input.rs2(4 downto 0)))));
				rd(63 downto 32) <= std_logic_vector(rotate_right(unsigned(input.rs1(63 downto 32)), to_integer(unsigned(input.rs2(36 downto 32)))));
				rd(95 downto 64) <= std_logic_vector(rotate_right(unsigned(input.rs1(95 downto 64)), to_integer(unsigned(input.rs2(68 downto 64)))));
			    rd(127 downto 96) <= std_logic_vector(rotate_right(unsigned(input.rs1(127 downto 96)), to_integer(unsigned(input.rs2(100 downto 96)))));
				
			when "11----1100---------------" =>		-- SHLHI: 
			
				-- shift left halfword immediate: packed 16-bit halfword shift left logical of the
				-- contents of register input.rs1 by the least significant 4-bit immediate value of instruction field
				-- input.rs2. Each of the results is placed into the corresponding 16-bit slot in register rd. Bits
				-- shifted out for each halfword are dropped, and bits shifted in to each halfword should be
				-- zeros. 

				rd(15 downto 0) <= std_logic_vector(shift_left(unsigned(input.rs1(15 downto 0)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(31 downto 16) <= std_logic_vector(shift_left(unsigned(input.rs1(31 downto 16)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(47 downto 32) <= std_logic_vector(shift_left(unsigned(input.rs1(47 downto 32)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(63 downto 48) <= std_logic_vector(shift_left(unsigned(input.rs1(63 downto 48)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(79 downto 64) <= std_logic_vector(shift_left(unsigned(input.rs1(79 downto 64)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(95 downto 80) <= std_logic_vector(shift_left(unsigned(input.rs1(95 downto 80)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(111 downto 96) <= std_logic_vector(shift_left(unsigned(input.rs1(111 downto 96)), to_integer(unsigned(input.op(13 downto 10)))));
				rd(127 downto 112) <= std_logic_vector(shift_left(unsigned(input.rs1(127 downto 112)), to_integer(unsigned(input.op(13 downto 10)))));	
				
			when "11----1101---------------" =>		-- SFH:
			
				-- subtract from halfword: packed 16-bit halfword unsigned subtract of the contents
				-- of input.rs1 from input.rs2 (rd = input.rs2 - input.rs1).

				rd(15 downto 0) <= std_logic_vector(unsigned(input.rs2(15 downto 0)) - unsigned(input.rs1(15 downto 0)));
				rd(31 downto 16) <= std_logic_vector(unsigned(input.rs2(31 downto 16)) - unsigned(input.rs1(31 downto 16)));
				rd(47 downto 32) <= std_logic_vector(unsigned(input.rs2(47 downto 32)) - unsigned(input.rs1(47 downto 32)));
				rd(63 downto 48) <= std_logic_vector(unsigned(input.rs2(63 downto 48)) - unsigned(input.rs1(63 downto 48)));
				rd(79 downto 64) <= std_logic_vector(unsigned(input.rs2(79 downto 64)) - unsigned(input.rs1(79 downto 64)));
				rd(95 downto 80) <= std_logic_vector(unsigned(input.rs2(95 downto 80)) - unsigned(input.rs1(95 downto 80)));
				rd(111 downto 96) <= std_logic_vector(unsigned(input.rs2(111 downto 96)) - unsigned(input.rs1(111 downto 96)));
				rd(127 downto 112) <= std_logic_vector(unsigned(input.rs2(127 downto 112)) - unsigned(input.rs1(127 downto 112)));
				
			when "11----1110---------------" =>		-- SFHS:
			
				-- subtract from halfword saturated: packed 16-bit signed subtraction with saturation of the contents of input.rs1 from input.rs2 (rd = input.rs2 - input.rs1).
	
				rd(15 downto 0) <= SAT(not input.rs1(15), input.rs2(15), std_logic_vector(signed(input.rs2(15 downto 0)) - signed(input.rs1(15 downto 0))));
				rd(31 downto 16) <= SAT(not input.rs1(31), input.rs2(31), std_logic_vector(signed(input.rs2(31 downto 16)) - signed(input.rs1(31 downto 16))));
				rd(47 downto 32) <= SAT(not input.rs1(47), input.rs2(47), std_logic_vector(signed(input.rs2(47 downto 32)) - signed(input.rs1(47 downto 32))));
				rd(63 downto 48) <= SAT(not input.rs1(63), input.rs2(63), std_logic_vector(signed(input.rs2(63 downto 48)) - signed(input.rs1(63 downto 48))));
				rd(79 downto 64) <= SAT(not input.rs1(79), input.rs2(79), std_logic_vector(signed(input.rs2(79 downto 64)) - signed(input.rs1(79 downto 64))));
				rd(95 downto 80) <= SAT(not input.rs1(95), input.rs2(95), std_logic_vector(signed(input.rs2(95 downto 80)) - signed(input.rs1(95 downto 80))));
				rd(111 downto 96) <= SAT(not input.rs1(111), input.rs2(111), std_logic_vector(signed(input.rs2(111 downto 96)) - signed(input.rs1(111 downto 96))));
				rd(127 downto 112) <= SAT(not input.rs1(127), input.rs2(127), std_logic_vector(signed(input.rs2(127 downto 112)) - signed(input.rs1(127 downto 112))));
				
			when "11----1111---------------" =>		-- XOR:
			
			-- bitwise logical exclusive-or of the contents of registers input.rs1 and input.rs2.
			
			rd <= input.rs1 xor input.rs2;
			
			when others => rd <= (others => '0');
		end case?;
	end process;
end behavioral;
