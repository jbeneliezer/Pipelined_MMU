-------------------------------------------------------------------------------
--
-- Title       : SFHS
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\src\SFHS.vhd
-- Generated   : Thu Mar 25 11:49:24 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------				

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SFHS is
	 port(
		 op : in STD_LOGIC_VECTOR(24 downto 0);
		 i : in STD_LOGIC_VECTOR(127 downto 0);
		 j : in STD_LOGIC_VECTOR(127 downto 0);
		 r : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end SFHS;									 

architecture behavioral of SFHS is
	signal res: std_logic_vector(127 downto 0);	 
	constant max16: std_logic_vector(15 downto 0) := "0111111111111111";								  	-- max 16 bit signed number
	constant min16: std_logic_vector(15 downto 0) := "1000000000000000";								  	-- min 16 bit signed number
begin			-- compute signed subtraction for each halfword	in i an j
	res(15 downto 0) <= std_logic_vector(signed(i(15 downto 0)) - signed(j(15 downto 0)));
	res(31 downto 16) <= std_logic_vector(signed(i(31 downto 16)) - signed(j(31 downto 16)));
	res(47 downto 32) <= std_logic_vector(signed(i(47 downto 32)) - signed(j(47 downto 32)));
	res(63 downto 48) <= std_logic_vector(signed(i(63 downto 48)) - signed(j(63 downto 48)));
	res(79 downto 64) <= std_logic_vector(signed(i(79 downto 64)) - signed(j(79 downto 64)));
	res(95 downto 80) <= std_logic_vector(signed(i(95 downto 80)) - signed(j(95 downto 80)));
	res(111 downto 96) <= std_logic_vector(signed(i(111 downto 96)) - signed(j(111 downto 96)));
	res(127 downto 112) <= std_logic_vector(signed(i(127 downto 112)) - signed(j(127 downto 112))); 
	
	dif0: process (i(15), j(15), res(15))
	begin
		if (not i(15) = j(15) and not i(15) = res(15) and res(15) = '1') then							   	-- check for overflow
			res(15 downto 0) <= max16;
		elsif (not i(15) = j(15) and not i(15) = res(15) and res(15) = '0')	then							-- check for underflow
			res(15 downto 0) <= min16;
		end if;
	end process;
	
	dif1: process (i(31), j(31), res(31))
	begin
		if (not i(31) = j(31) and not i(31) = res(31) and res(31) = '1') then							   	-- check for overflow
			res(31 downto 16) <= max16;
		elsif (not i(31) = j(31) and not i(31) = res(31) and res(31) = '0')	then							-- check for underflow
			res(31 downto 16) <= min16;
		end if;
	end process;
	
	dif2: process (i(47), j(47), res(47))
	begin
		if (not i(47) = j(47) and not i(47) = res(47) and res(47) = '1') then							   	-- check for overflow
			res(47 downto 32) <= max16;
		elsif (not i(47) = j(47) and not i(47) = res(47) and res(47) = '0')	then							-- check for underflow
			res(47 downto 32) <= min16;
		end if;
	end process;
	
	dif3: process (i(63), j(63), res(63))
	begin
		if (not i(63) = j(63) and not i(63) = res(63) and res(63) = '1') then							    -- check for overflow
			res(63 downto 48) <= max16;
		elsif (not i(63) = j(63) and not i(63) = res(63) and res(63) = '0')	then							-- check for underflow
			res(63 downto 48) <= min16;
		end if;
	end process;
	
	dif4: process (i(79), j(79), res(79))
	begin
		if (not i(79) = j(79) and not i(79) = res(79) and res(79) = '1') then								 -- check for overflow
			res(79 downto 64) <= max16;
		elsif (not i(79) = j(79) and not i(79) = res(79) and res(79) = '0')	then							 -- check for underflow
			res(79 downto 64) <= min16;
		end if;
	end process;
	
	dif5: process (i(95), j(95), res(95))
	begin
		if (not i(95) = j(95) and not i(95) = res(95) and res(95) = '1') then								 -- check for overflow
			res(95 downto 80) <= max16;
		elsif (not i(95) = j(95) and not i(95) = res(95) and res(95) = '0')	then							 -- check for underflow
			res(95 downto 80) <= min16;
		end if;
	end process;
	
	dif6: process (i(111), j(111), res(111))
	begin
		if (not i(111) = j(111) and not i(111) = res(111) and res(111) = '1') then							 -- check for overflow
			res(111 downto 96) <= max16;
		elsif (not i(111) = j(111) and not i(111) = res(111) and res(111) = '0') then					 	 -- check for underflow
			res(111 downto 96) <= min16;
		end if;
	end process;
	
	dif7: process (i(127), j(127), res(127))
	begin
		if (not i(127) = j(127) and not i(127) = res(127) and res(127) = '1') then							 -- check for overflow
			res(127 downto 112) <= max16;
		elsif (not i(127) = j(127) and not i(127) = res(127) and res(127) = '0') then					 	 -- check for underflow
			res(127 downto 112) <= min16;
		end if;
	end process;
	
	process (op) 
	begin
		if (op = "11----1110---------------") then		-- check for right opcode
			r <= res;
		end if;
	end process;
end behavioral;
