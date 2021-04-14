-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
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
-- Description : 25 Opcode ALU
--
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library SIMD;
use SIMD.ALU_functions.all;

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
	constant max16: signed := x"7FFF";									 								-- max 16 bit signed number
	constant min16: signed := x"8000";									 								-- min 16 bit signed number
begin  		
	process(all) 
		variable count: unsigned (31 downto 0);
	begin
		case? (Op) is
			when "0------------------------" =>		-- LI
				case (op(23 downto 21)) is
					when "000" => Rd(15 downto 0) <= Op(20 downto 5);			   						-- set the specied range of r to immediate
					when "001" => Rd(31 downto 16) <= Op(20 downto 5);
					when "010" => Rd(47 downto 32) <= Op(20 downto 5);
					when "011" => Rd(63 downto 48) <= Op(20 downto 5);
					when "100" => Rd(79 downto 64) <= Op(20 downto 5);
					when "101" => Rd(95 downto 80) <= Op(20 downto 5);
					when "110" => Rd(111 downto 96) <= Op(20 downto 5);
					when "111" => Rd(127 downto 112) <= Op(20 downto 5);
					when others => null;
			end case;
			when "10000--------------------" =>		-- SIMALS
				Rd(31 downto 0) <= MULT_ADD_I(rs3(15 downto 0), rs2(15 downto 0), rs1(31 downto 0));
				Rd(63 downto 32) <= MULT_ADD_I(rs3(47 downto 32), rs2(47 downto 32), rs1(63 downto 32));
				Rd(95 downto 64) <= MULT_ADD_I(rs3(79 downto 64), rs2(79 downto 64), rs1(95 downto 64));
				Rd(127 downto 96) <= MULT_ADD_I(rs3(111 downto 96), rs2(111 downto 96), rs1(127 downto 96));
			when "10001--------------------" =>		-- SIMAHS
				Rd(31 downto 0) <= MULT_ADD_I(rs3(31 downto 16), rs2(31 downto 16), rs1(31 downto 0));
				Rd(63 downto 32) <= MULT_ADD_I(rs3(63 downto 48), rs2(63 downto 48), rs1(63 downto 32));
				Rd(95 downto 64) <= MULT_ADD_I(rs3(95 downto 80), rs2(95 downto 80), rs1(95 downto 64));
				Rd(127 downto 96) <= MULT_ADD_I(rs3(127 downto 112), rs2(127 downto 112), rs1(127 downto 96));
			when "10010--------------------" => 	-- SIMSLS
				Rd(31 downto 0) <= MULT_SUB_I(rs3(15 downto 0), rs2(15 downto 0), rs1(31 downto 0));
				Rd(63 downto 32) <= MULT_SUB_I(rs3(47 downto 32), rs2(47 downto 32), rs1(63 downto 32));
				Rd(95 downto 64) <= MULT_SUB_I(rs3(79 downto 64), rs2(79 downto 64), rs1(95 downto 64));
				Rd(127 downto 96) <= MULT_SUB_I(rs3(111 downto 96), rs2(111 downto 96), rs1(127 downto 96));
			when "10011--------------------" => 	-- SIMSHS
				Rd(31 downto 0) <= MULT_SUB_I(rs3(31 downto 16), rs2(31 downto 16), rs1(31 downto 0));
				Rd(63 downto 32) <= MULT_SUB_I(rs3(63 downto 48), rs2(63 downto 48), rs1(63 downto 32));
				Rd(95 downto 64) <= MULT_SUB_I(rs3(95 downto 80), rs2(95 downto 80), rs1(95 downto 64));
				Rd(127 downto 96) <= MULT_SUB_I(rs3(127 downto 112), rs2(127 downto 112), rs1(127 downto 96));
			when "10100--------------------" => 	-- SLIMALS
				Rd(31 downto 0) <= MULT_ADD_L(rs3(31 downto 0), rs2(31 downto 0), rs1(63 downto 0));
				Rd(63 downto 32) <= MULT_ADD_L(rs3(95 downto 64), rs2(95 downto 64), rs1(127 downto 64));
			when "10101--------------------" => 	-- SLIMAHS
				Rd(31 downto 0) <= MULT_ADD_L(rs3(63 downto 32), rs2(63 downto 32), rs1(63 downto 0));
				Rd(63 downto 32) <= MULT_ADD_L(rs3(127 downto 96), rs2(127 downto 96), rs1(127 downto 64));
			when "10110--------------------" => 	-- SLIMSLS
				Rd(31 downto 0) <= MULT_SUB_L(rs3(31 downto 0), rs2(31 downto 0), rs1(63 downto 0));
				Rd(63 downto 32) <= MULT_SUB_L(rs3(95 downto 64), rs2(95 downto 64), rs1(127 downto 64));
			when "10111--------------------" =>  	-- SLIMSHS
				Rd(31 downto 0) <= MULT_SUB_L(rs3(63 downto 32), rs2(63 downto 32), rs1(63 downto 0));
				Rd(63 downto 32) <= MULT_SUB_L(rs3(127 downto 96), rs2(127 downto 96), rs1(127 downto 64));
			when "11----0000---------------" => 	-- NOP
				null;
			when "11----0001---------------" =>   	-- AU
				Rd(31 downto 0) <= std_logic_vector(unsigned(rs1(31 downto 0)) + unsigned(rs2(31 downto 0)));
				Rd(63 downto 32) <= std_logic_vector(unsigned(rs1(63 downto 32)) + unsigned(rs2(63 downto 32)));
				Rd(95 downto 64) <= std_logic_vector(unsigned(rs1(95 downto 64)) + unsigned(rs2(95 downto 64)));
				Rd(127 downto 96) <= std_logic_vector(unsigned(rs1(127 downto 96)) + unsigned(rs2(127 downto 96)));	
			when "11----0010---------------" =>		-- ABSDB
				Rd(7 downto 0) <= std_logic_vector(abs(signed(rs2(7 downto 0)) - signed(rs1(7 downto 0))));					  -- compute absolute difference between rs1 and rs2 bytes 
				Rd(15 downto 8) <= std_logic_vector(abs(signed(rs2(15 downto 8)) - signed(rs1(15 downto 8))));	
				Rd(23 downto 16) <= std_logic_vector(abs(signed(rs2(23 downto 16)) - signed(rs1(23 downto 16))));
				Rd(31 downto 24) <= std_logic_vector(abs(signed(rs2(31 downto 24)) - signed(rs1(31 downto 24))));
				Rd(39 downto 32) <= std_logic_vector(abs(signed(rs2(39 downto 32)) - signed(rs1(39 downto 32))));
				Rd(47 downto 40) <= std_logic_vector(abs(signed(rs2(47 downto 40)) - signed(rs1(47 downto 40))));
				Rd(55 downto 48) <= std_logic_vector(abs(signed(rs2(55 downto 48)) - signed(rs1(55 downto 48))));
				Rd(63 downto 56) <= std_logic_vector(abs(signed(rs2(63 downto 56)) - signed(rs1(63 downto 56))));
				Rd(71 downto 64) <= std_logic_vector(abs(signed(rs2(71 downto 64)) - signed(rs1(71 downto 64))));
				Rd(79 downto 72) <= std_logic_vector(abs(signed(rs2(79 downto 72)) - signed(rs1(79 downto 72))));
				Rd(87 downto 80) <= std_logic_vector(abs(signed(rs2(87 downto 80)) - signed(rs1(87 downto 80))));
				Rd(95 downto 88) <= std_logic_vector(abs(signed(rs2(95 downto 88)) - signed(rs1(95 downto 88))));
				Rd(103 downto 96) <= std_logic_vector(abs(signed(rs2(103 downto 96)) - signed(rs1(103 downto 96))));
				Rd(111 downto 104) <= std_logic_vector(abs(signed(rs2(111 downto 104)) - signed(rs1(111 downto 104))));
				Rd(119 downto 112) <= std_logic_vector(abs(signed(rs2(119 downto 112)) - signed(rs1(119 downto 112))));
				Rd(127 downto 120) <= std_logic_vector(abs(signed(rs2(127 downto 120)) - signed(rs1(127 downto 120))));
			when "11----0011---------------" =>		-- AHU   
				Rd(15 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) + unsigned(rs2(15 downto 0)));
				Rd(31 downto 16) <= std_logic_vector(unsigned(rs1(31 downto 16)) + unsigned(rs2(31 downto 16)));
				Rd(47 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) + unsigned(rs2(47 downto 32)));
				Rd(63 downto 48) <= std_logic_vector(unsigned(rs1(63 downto 48)) + unsigned(rs2(63 downto 48)));
				Rd(79 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) + unsigned(rs2(79 downto 64)));
				Rd(95 downto 80) <= std_logic_vector(unsigned(rs1(95 downto 80)) + unsigned(rs2(95 downto 80)));
				Rd(111 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) + unsigned(rs2(111 downto 96)));
				Rd(127 downto 112) <= std_logic_vector(unsigned(rs1(127 downto 112)) + unsigned(rs2(127 downto 112)));
			when "11----0100---------------" =>		-- AHS 
				Rd(15 downto 0) <= std_logic_vector(signed(rs1(15 downto 0)) + signed(rs2(15 downto 0)));
				Rd(31 downto 16) <= std_logic_vector(signed(rs1(31 downto 16)) + signed(rs2(31 downto 16)));
				Rd(47 downto 32) <= std_logic_vector(signed(rs1(47 downto 32)) + signed(rs2(47 downto 32)));
				Rd(63 downto 48) <= std_logic_vector(signed(rs1(63 downto 48)) + signed(rs2(63 downto 48)));
				Rd(79 downto 64) <= std_logic_vector(signed(rs1(79 downto 64)) + signed(rs2(79 downto 64)));
				Rd(95 downto 80) <= std_logic_vector(signed(rs1(95 downto 80)) + signed(rs2(95 downto 80)));
				Rd(111 downto 96) <= std_logic_vector(signed(rs1(111 downto 96)) + signed(rs2(111 downto 96)));
				Rd(127 downto 112) <= std_logic_vector(signed(rs1(127 downto 112)) + signed(rs2(127 downto 112))); 
				
				if (rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '1') then								   	 -- check for overflow
					Rd(15 downto 0) <= std_logic_vector(max16);
				elsif (rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '0')	then							   	-- check for underflow
					Rd(15 downto 0) <= std_logic_vector(min16);
				end if;
				if (rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '1') then								   	-- check for overflow
					Rd(31 downto 16) <= std_logic_vector(max16);
				elsif (rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '0')	then							   	-- check for underflow
					Rd(31 downto 16) <= std_logic_vector(min16);
				end if;
				if (rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '1') then								   	-- check for overflow
					Rd(47 downto 32) <= std_logic_vector(max16);
				elsif (rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '0')	then							   	-- check for underflow
					Rd(47 downto 32) <= std_logic_vector(min16);
				end if;
				if (rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '1') then								   	-- check for overflow
					Rd(63 downto 48) <= std_logic_vector(max16);
				elsif (rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '0')	then							   	-- check for underflow
					Rd(63 downto 48) <= std_logic_vector(min16);
				end if;
				if (rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '1') then								  	-- check for overflow
					Rd(79 downto 64) <= std_logic_vector(max16);
				elsif (rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '0')	then							  	-- check for underflow
					Rd(79 downto 64) <= std_logic_vector(min16);
				end if;
				if (rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '1') then								   	-- check for overflow
					Rd(95 downto 80) <= std_logic_vector(max16);
				elsif (rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '0')	then							   	-- check for underflow
					Rd(95 downto 80) <= std_logic_vector(min16);																	   
				end if;
				if (rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '1') then							   	-- check for overflow
					Rd(111 downto 96) <= std_logic_vector(max16);
				elsif (rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '0')	then					   	-- check for underflow
					Rd(111 downto 96) <= std_logic_vector(min16);
				end if;
				if (rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '1') then							   -- check for overflow
					Rd(127 downto 112) <= std_logic_vector(max16);
				elsif (rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '0')	then					   -- check for underflow
					Rd(127 downto 112) <= std_logic_vector(min16);
			end if;
			when "11----0101---------------" =>		-- AND  
				Rd <= rs1 and rs2;											-- compute i and j
			when "11----0110---------------" =>		-- BCW  
				Rd(31 downto 0) <= rs1(31 downto 0);
				Rd(63 downto 32) <= rs1(31 downto 0);
				Rd(95 downto 64) <= rs1(31 downto 0);
				Rd(127 downto 96) <= rs1(31 downto 0); 
			when "11----0111---------------" =>		-- MAXWS
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
			when "11----1000---------------" =>		-- MINWS
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
			when "11----1001---------------" =>		-- MLHU
				Rd(31 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) * unsigned(rs2(15 downto 0)));
				Rd(63 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) * unsigned(rs2(47 downto 32)));
				Rd(95 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) * unsigned(rs2(79 downto 64)));
				Rd(127 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) * unsigned(rs2(111 downto 96)));
			when "11----1010---------------" =>		-- MLHCU
				Rd(31 downto 0) <= b"00000000000" & std_logic_vector(unsigned(rs2(15 downto 0)) * unsigned(op(14 downto 10)));
				Rd(63 downto 32) <= b"00000000000" & std_logic_vector(unsigned(rs2(47 downto 32)) * unsigned(op(14 downto 10)));
				Rd(95 downto 64) <= b"00000000000" & std_logic_vector(unsigned(rs2(79 downto 64)) * unsigned(op(14 downto 10)));
				Rd(127 downto 96) <= b"00000000000" & std_logic_vector(unsigned(rs2(111 downto 96)) * unsigned(op(14 downto 10)));
			when "11----1011---------------" =>		-- OR
				Rd <= rs1 or rs2;										    -- compute rs1 or rs2
			when "11----1100---------------" =>		-- PCNTW
				count := x"00000000";
				for i in 0 to 31 loop
					count := count + ("0000000000000000000000000000000" & rs1(i));
				end loop;
				Rd(31 downto 0) <= std_logic_vector(count);
				
				count := x"00000000";
				for i in 32 to 63 loop
					count := count + ("0000000000000000000000000000000" & rs1(i));
				end loop;
				Rd(63 downto 32) <= std_logic_vector(count);
				
				count := x"00000000";
				for i in 64 to 95 loop
					count := count + ("0000000000000000000000000000000" & rs1(i));
				end loop;
				Rd(95 downto 64) <= std_logic_vector(count);
				
				count := x"00000000";
				for i in 96 to 127 loop
					count := count + ("0000000000000000000000000000000" & rs1(i));
				end loop;
				Rd(127 downto 96) <= std_logic_vector(count);
			when "11----1101---------------" =>		-- ROTW
				Rd(31 downto 0) <= std_logic_vector(rotate_right(unsigned(rs1(31 downto 0)), to_integer(unsigned(rs2(4 downto 0)))));
				Rd(63 downto 32) <= std_logic_vector(rotate_right(unsigned(rs1(63 downto 32)), to_integer(unsigned(rs2(4 downto 0)))));
				Rd(95 downto 64) <= std_logic_vector(rotate_right(unsigned(rs1(95 downto 64)), to_integer(unsigned(rs2(4 downto 0)))));
				Rd(127 downto 96) <= std_logic_vector(rotate_right(unsigned(rs1(127 downto 96)), to_integer(unsigned(rs2(4 downto 0)))));
			when "11----1110---------------" =>		-- SFHS
				Rd(15 downto 0) <= std_logic_vector(signed(rs2(15 downto 0)) - signed(rs1(15 downto 0)));
				Rd(31 downto 16) <= std_logic_vector(signed(rs2(31 downto 16)) - signed(rs1(31 downto 16)));
				Rd(47 downto 32) <= std_logic_vector(signed(rs2(47 downto 32)) - signed(rs1(47 downto 32)));
				Rd(63 downto 48) <= std_logic_vector(signed(rs2(63 downto 48)) - signed(rs1(63 downto 48)));
				Rd(79 downto 64) <= std_logic_vector(signed(rs2(79 downto 64)) - signed(rs1(79 downto 64)));
				Rd(95 downto 80) <= std_logic_vector(signed(rs2(95 downto 80)) - signed(rs1(95 downto 80)));
				Rd(111 downto 96) <= std_logic_vector(signed(rs2(111 downto 96)) - signed(rs1(111 downto 96)));
				Rd(127 downto 112) <= std_logic_vector(signed(rs2(127 downto 112)) - signed(rs1(127 downto 112)));
				
				if (not rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '1') then							   	-- check for overflow
					Rd(15 downto 0) <= std_logic_vector(max16);
				elsif (not rs1(15) = rs2(15) and not rs1(15) = Rd(15) and Rd(15) = '0')	then							-- check for underflow
					Rd(15 downto 0) <= std_logic_vector(min16);
				end if;	
				if (not rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '1') then							   	-- check for overflow
					Rd(31 downto 16) <= std_logic_vector(max16);
				elsif (not rs1(31) = rs2(31) and not rs1(31) = Rd(31) and Rd(31) = '0')	then							-- check for underflow
					Rd(31 downto 16) <= std_logic_vector(min16);
				end if;
				if (not rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '1') then							   	-- check for overflow
					Rd(47 downto 32) <= std_logic_vector(max16);
				elsif (not rs1(47) = rs2(47) and not rs1(47) = Rd(47) and Rd(47) = '0')	then							-- check for underflow
					Rd(47 downto 32) <= std_logic_vector(min16);
				end if;
				if (not rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '1') then							    -- check for overflow
					Rd(63 downto 48) <= std_logic_vector(max16);
				elsif (not rs1(63) = rs2(63) and not rs1(63) = Rd(63) and Rd(63) = '0')	then							-- check for underflow
					Rd(63 downto 48) <= std_logic_vector(min16);
				end if;	
				if (not rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '1') then								-- check for overflow
					Rd(79 downto 64) <= std_logic_vector(max16);
				elsif (not rs1(79) = rs2(79) and not rs1(79) = Rd(79) and Rd(79) = '0')	then							-- check for underflow
					Rd(79 downto 64) <= std_logic_vector(min16);
				end if;
				if (not rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '1') then								-- check for overflow
					Rd(95 downto 80) <= std_logic_vector(max16);
				elsif (not rs1(95) = rs2(95) and not rs1(95) = Rd(95) and Rd(95) = '0')	then							-- check for underflow
					Rd(95 downto 80) <= std_logic_vector(min16);
				end if;	
				if (not rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '1') then							-- check for overflow
					Rd(111 downto 96) <= std_logic_vector(max16);
				elsif (not rs1(111) = rs2(111) and not rs1(111) = Rd(111) and Rd(111) = '0') then					 	-- check for underflow
					Rd(111 downto 96) <= std_logic_vector(min16);
				end if;	
				if (not rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '1') then							-- check for overflow
					Rd(127 downto 112) <= std_logic_vector(max16);
				elsif (not rs1(127) = rs2(127) and not rs1(127) = Rd(127) and Rd(127) = '0') then					 	-- check for underflow
					Rd(127 downto 112) <= std_logic_vector(min16);
				end if;
			when "11----1111---------------" =>		-- SFW
				Rd(31 downto 0) <= std_logic_vector(unsigned(rs2(31 downto 0)) - unsigned(rs1(31 downto 0)));
				Rd(63 downto 32) <= std_logic_vector(unsigned(rs2(63 downto 32)) - unsigned(rs1(63 downto 32)));
				Rd(95 downto 64) <= std_logic_vector(unsigned(rs2(95 downto 64)) - unsigned(rs1(95 downto 64)));
				Rd(127 downto 96) <= std_logic_vector(unsigned(rs2(127 downto 96)) - unsigned(rs1(127 downto 96))); 
			when others => null;
		end case?;
	end process;
end behavioral;
