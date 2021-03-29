-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\SIMD\ALU\src\ALU.vhd
-- Generated   : Tue Mar 23 15:35:33 2021
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

entity ALU is
	port(					
		 Op : in STD_LOGIC_VECTOR(24 downto 0);
		 A : in STD_LOGIC_VECTOR(127 downto 0);
		 B : in STD_LOGIC_VECTOR(127 downto 0);
		 C : in STD_LOGIC_VECTOR(127 downto 0);
		 Rd : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;									   

architecture behavioral of ALU is	
	
	constant max16: signed := "0111111111111111";									 					-- max 16 bit signed number
	constant min16: signed := "1000000000000000";									 					-- min 16 bit signed number
	constant max32: signed := "01111111111111111111111111111111";		  								-- max 32 bit signed number
	constant min32: signed := "10000000000000000000000000000000";		  								-- min 32 bit signed number
	constant max64 : signed := "0111111111111111111111111111111111111111111111111111111111111111";		-- max 64 bit signed number
	constant min64 : signed := "1000000000000000000000000000000000000000000000000000000000000000";		-- min 64 bit signed number

	function MULT_ADD_I(x: std_logic_vector(15 downto 0);
						y: std_logic_vector(15 downto 0);
						z: std_logic_vector(31 downto 0)) return std_logic_vector is					   			
		variable product: signed (31 downto 0);
		variable sum: signed (31 downto 0);
	begin 
		product := signed(x) * signed(y);											-- compute x * y
		sum := product + signed(z);													-- compute product + z
					   												
		if (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '1') then		-- check for overflow
			sum := max32;															
		elsif (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '0') then	-- check for underflow
			sum := min32;															
		end if;		
		return std_logic_vector(sum);
	end function;	 
	
	function MULT_SUB_I(x: std_logic_vector(15 downto 0);
						y: std_logic_vector(15 downto 0);
						z: std_logic_vector(31 downto 0)) return std_logic_vector is									   
		variable product: signed (31 downto 0);
		variable dif: signed (31 downto 0);
	begin	  		  
		product := signed(x) * signed(y);													-- compute x * y
		dif := signed(z) - product;							  
		if (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '1') then			-- check for overflow
			dif := max32;
		elsif (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '0') then		-- check for underflow
			dif := min32;
		end if;		
		return std_logic_vector(dif);
	end MULT_SUB_I;
	
	function MULT_ADD_L(x: std_logic_vector(31 downto 0);
						y: std_logic_vector(31 downto 0);
						z: std_logic_vector(63 downto 0)) return std_logic_vector is													   
		variable product: signed (63 downto 0);
		variable sum: signed (63 downto 0);
	begin	
		product := signed(x) * signed(y);																-- compute x * y
		sum := product + signed(z);												
		if (product(63) = z(63) and not z(63) = sum(63) and sum(63) = '1') then							-- check for overflow
			sum := max64;															
		elsif (product(63) = z(63) and not z(63) = sum(63) and sum(63) = '0') then						-- check for underflow
			sum := min64;																
		end if;
		return std_logic_vector(sum);
	end MULT_ADD_L;
	
	function MULT_SUB_L(x: std_logic_vector(31 downto 0);
						y: std_logic_vector(31 downto 0);
						z: std_logic_vector(63 downto 0)) return std_logic_vector is 													   
		variable product: signed (63 downto 0);
		variable dif: signed (63 downto 0);
	begin	
		product := signed(x) * signed(y);																-- compute x * y
		dif := signed(z) - product;	 
		if (not product(63) = z(63) and not z(63) = dif(63) and dif(63) = '1') then						-- check for overflow
			dif := max64;
		elsif (not product(63) = z(63) and not z(63) = dif(63) and dif(63) = '0') then					-- check for underflow
			dif := min64;
		end if;
		return std_logic_vector(dif);
	end MULT_SUB_L;

begin  		
	process(all) 
		variable count: unsigned (31 downto 0);
	begin
		case? (Op) is
			when "0------------------------" =>		-- LI
				case (op(23 downto 21)) is
					when "000" => Rd(15 downto 0) <= Op(20 downto 5);			   -- set the specied range of r to immediate
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
				Rd(31 downto 0) <= MULT_ADD_I(A(15 downto 0), B(15 downto 0), C(31 downto 0));
				Rd(63 downto 32) <= MULT_ADD_I(A(47 downto 32), B(47 downto 32), C(63 downto 32));
				Rd(95 downto 64) <= MULT_ADD_I(A(79 downto 64), B(79 downto 64), C(95 downto 64));
				Rd(127 downto 96) <= MULT_ADD_I(A(111 downto 96), B(111 downto 96), C(127 downto 96));												
			when "10001--------------------" =>		-- SIMAHS 	
				Rd(31 downto 0) <= MULT_ADD_I(A(31 downto 16), B(31 downto 16), C(31 downto 0));
				Rd(63 downto 32) <= MULT_ADD_I(A(63 downto 48), B(63 downto 48), C(63 downto 32));
				Rd(95 downto 64) <= MULT_ADD_I(A(95 downto 80), B(95 downto 80), C(95 downto 64));
				Rd(127 downto 96) <= MULT_ADD_I(A(127 downto 112), B(127 downto 112), C(127 downto 96));
			when "10010--------------------" => 	-- SIMSLS	 
				Rd(31 downto 0) <= MULT_SUB_I(A(15 downto 0), B(15 downto 0), C(31 downto 0));
				Rd(63 downto 32) <= MULT_SUB_I(A(47 downto 32), B(47 downto 32), C(63 downto 32));
				Rd(95 downto 64) <= MULT_SUB_I(A(79 downto 64), B(79 downto 64), C(95 downto 64));
				Rd(127 downto 96) <= MULT_SUB_I(A(111 downto 96), B(111 downto 96), C(127 downto 96));
			when "10011--------------------" => 	-- SIMSHS 										 							 
				Rd(31 downto 0) <= MULT_SUB_I(A(31 downto 16), B(31 downto 16), C(31 downto 0));
				Rd(63 downto 32) <= MULT_SUB_I(A(63 downto 48), B(63 downto 48), C(63 downto 32));
				Rd(95 downto 64) <= MULT_SUB_I(A(95 downto 80), B(95 downto 80), C(95 downto 64));
				Rd(127 downto 96) <= MULT_SUB_I(A(127 downto 112), B(127 downto 112), C(127 downto 96));
			when "10100--------------------" => 	-- SLIMALS
				Rd(31 downto 0) <= MULT_ADD_L(A(31 downto 0), B(31 downto 0), C(63 downto 0));
				Rd(63 downto 32) <= MULT_ADD_L(A(95 downto 64), B(95 downto 64), C(127 downto 64));	  
			when "10101--------------------" => 	-- SLIMAHS									  	  						
				Rd(31 downto 0) <= MULT_ADD_L(A(63 downto 32), B(63 downto 32), C(63 downto 0));
				Rd(63 downto 32) <= MULT_ADD_L(A(127 downto 96), B(127 downto 96), C(127 downto 64));
			when "10110--------------------" => 	-- SLIMSLS 
				Rd(31 downto 0) <= MULT_SUB_L(A(31 downto 0), B(31 downto 0), C(63 downto 0));
				Rd(63 downto 32) <= MULT_SUB_L(A(95 downto 64), B(95 downto 64), C(127 downto 64));	  
			when "10111--------------------" =>  	-- SLIMSHS									  	  						
				Rd(31 downto 0) <= MULT_SUB_L(A(63 downto 32), B(63 downto 32), C(63 downto 0));
				Rd(63 downto 32) <= MULT_SUB_L(A(127 downto 96), B(127 downto 96), C(127 downto 64));	
			when "11----0000---------------" => 	-- NOP
				null;
			when "11----0001---------------" =>   	-- AU
				Rd(31 downto 0) <= std_logic_vector(unsigned(A(31 downto 0)) + unsigned(B(31 downto 0)));
				Rd(63 downto 32) <= std_logic_vector(unsigned(A(63 downto 32)) + unsigned(B(63 downto 32)));
				Rd(95 downto 64) <= std_logic_vector(unsigned(A(95 downto 64)) + unsigned(B(95 downto 64)));
				Rd(127 downto 96) <= std_logic_vector(unsigned(A(127 downto 96)) + unsigned(B(127 downto 96)));	
			when "11----0010---------------" =>		-- ABSDB  															   
				Rd <= std_logic_vector(abs(signed(B) - signed(A)));					  -- compute absolute difference between A and B
			when "11----0011---------------" =>		-- AHU   
				 	Rd(15 downto 0) <= std_logic_vector(unsigned(A(15 downto 0)) + unsigned(B(15 downto 0)));
					Rd(31 downto 16) <= std_logic_vector(unsigned(A(31 downto 16)) + unsigned(B(31 downto 16)));
					Rd(47 downto 32) <= std_logic_vector(unsigned(A(47 downto 32)) + unsigned(B(47 downto 32)));
					Rd(63 downto 48) <= std_logic_vector(unsigned(A(63 downto 48)) + unsigned(B(63 downto 48)));
					Rd(79 downto 64) <= std_logic_vector(unsigned(A(79 downto 64)) + unsigned(B(79 downto 64)));
					Rd(95 downto 80) <= std_logic_vector(unsigned(A(95 downto 80)) + unsigned(B(95 downto 80)));
					Rd(111 downto 96) <= std_logic_vector(unsigned(A(111 downto 96)) + unsigned(B(111 downto 96)));
					Rd(127 downto 112) <= std_logic_vector(unsigned(A(127 downto 112)) + unsigned(B(127 downto 112)));	  
			when "11----0100---------------" =>		-- AHS 
				Rd(15 downto 0) <= std_logic_vector(signed(A(15 downto 0)) + signed(B(15 downto 0)));
				Rd(31 downto 16) <= std_logic_vector(signed(A(31 downto 16)) + signed(B(31 downto 16)));
				Rd(47 downto 32) <= std_logic_vector(signed(A(47 downto 32)) + signed(B(47 downto 32)));
				Rd(63 downto 48) <= std_logic_vector(signed(A(63 downto 48)) + signed(B(63 downto 48)));
				Rd(79 downto 64) <= std_logic_vector(signed(A(79 downto 64)) + signed(B(79 downto 64)));
				Rd(95 downto 80) <= std_logic_vector(signed(A(95 downto 80)) + signed(B(95 downto 80)));
				Rd(111 downto 96) <= std_logic_vector(signed(A(111 downto 96)) + signed(B(111 downto 96)));
				Rd(127 downto 112) <= std_logic_vector(signed(A(127 downto 112)) + signed(B(127 downto 112))); 
		
				if (A(15) = B(15) and not A(15) = Rd(15) and Rd(15) = '1') then								   -- check for overflow
					Rd(15 downto 0) <= std_logic_vector(max16);
				elsif (A(15) = B(15) and not A(15) = Rd(15) and Rd(15) = '0')	then							   -- check for underflow
					Rd(15 downto 0) <= std_logic_vector(min16);
				end if;
				if (A(31) = B(31) and not A(31) = Rd(31) and Rd(31) = '1') then								   -- check for overflow
					Rd(31 downto 16) <= std_logic_vector(max16);
				elsif (A(31) = B(31) and not A(31) = Rd(31) and Rd(31) = '0')	then							   -- check for underflow
					Rd(31 downto 16) <= std_logic_vector(min16);
				end if;
				if (A(47) = B(47) and not A(47) = Rd(47) and Rd(47) = '1') then								   -- check for overflow
					Rd(47 downto 32) <= std_logic_vector(max16);
				elsif (A(47) = B(47) and not A(47) = Rd(47) and Rd(47) = '0')	then							   -- check for underflow
					Rd(47 downto 32) <= std_logic_vector(min16);
				end if;
				if (A(63) = B(63) and not A(63) = Rd(63) and Rd(63) = '1') then								   -- check for overflow
					Rd(63 downto 48) <= std_logic_vector(max16);
				elsif (A(63) = B(63) and not A(63) = Rd(63) and Rd(63) = '0')	then							   -- check for underflow
					Rd(63 downto 48) <= std_logic_vector(min16);
				end if;
				if (A(79) = B(79) and not A(79) = Rd(79) and Rd(79) = '1') then								  -- check for overflow
					Rd(79 downto 64) <= std_logic_vector(max16);
				elsif (A(79) = B(79) and not A(79) = Rd(79) and Rd(79) = '0')	then							  -- check for underflow
					Rd(79 downto 64) <= std_logic_vector(min16);
				end if;
				if (A(95) = B(95) and not A(95) = Rd(95) and Rd(95) = '1') then								   -- check for overflow
					Rd(95 downto 80) <= std_logic_vector(max16);
				elsif (A(95) = B(95) and not A(95) = Rd(95) and Rd(95) = '0')	then							   -- check for underflow
					Rd(95 downto 80) <= std_logic_vector(min16);																	   
				end if;
				if (A(111) = B(111) and not A(111) = Rd(111) and Rd(111) = '1') then							   -- check for overflow
					Rd(111 downto 96) <= std_logic_vector(max16);
				elsif (A(111) = B(111) and not A(111) = Rd(111) and Rd(111) = '0')	then					   -- check for underflow
					Rd(111 downto 96) <= std_logic_vector(min16);
				end if;
				if (A(127) = B(127) and not A(127) = Rd(127) and Rd(127) = '1') then							   -- check for overflow
					Rd(127 downto 112) <= std_logic_vector(max16);
				elsif (A(127) = B(127) and not A(127) = Rd(127) and Rd(127) = '0')	then					   -- check for underflow
					Rd(127 downto 112) <= std_logic_vector(min16);
				end if;
			when "11----0101---------------" =>		-- AND  
				Rd <= A and B;											-- compute i and j
			when "11----0110---------------" =>		-- BCW  
				Rd(31 downto 0) <= B(31 downto 0);
				Rd(63 downto 32) <= B(31 downto 0);
				Rd(95 downto 64) <= B(31 downto 0);
				Rd(127 downto 96) <= B(31 downto 0); 
			when "11----0111---------------" =>		-- MAXWS  			 
				if (signed(A(31 downto 0)) > signed(B(31 downto 0))) then
					Rd(31 downto 0) <= A(31 downto 0);
				else
					Rd(31 downto 0) <= B(31 downto 0);  
				end if;
				if (signed(A(63 downto 32)) > signed(B(63 downto 32))) then
					Rd(63 downto 32) <= A(63 downto 32);
				else
					Rd(63 downto 32) <= B(63 downto 32);  
				end if;
				if (signed(A(95 downto 64)) > signed(B(95 downto 64))) then
					Rd(95 downto 64) <= A(95 downto 64);
				else
					Rd(95 downto 64) <= B(95 downto 64);  
				end if;
				if (signed(A(127 downto 96)) > signed(B(127 downto 96))) then
					Rd(127 downto 96) <= A(127 downto 96);
				else
					Rd(127 downto 96) <= B(127 downto 96);  
				end if;	
			when "11----1000---------------" =>		-- MINWS  		 
				if (signed(A(31 downto 0)) < signed(B(31 downto 0))) then
					Rd(31 downto 0) <= A(31 downto 0);
				else
					Rd(31 downto 0) <= B(31 downto 0);  
				end if;	 
				if (signed(A(63 downto 32)) < signed(B(63 downto 32))) then
					Rd(63 downto 32) <= A(63 downto 32);
				else
					Rd(63 downto 32) <= B(63 downto 32);  
				end if;
				if (signed(A(95 downto 64)) < signed(B(95 downto 64))) then
					Rd(95 downto 64) <= A(95 downto 64);
				else
					Rd(95 downto 64) <= B(95 downto 64);  
				end if;	
				if (signed(A(127 downto 96)) < signed(B(127 downto 96))) then
					Rd(127 downto 96) <= A(127 downto 96);
				else
					Rd(127 downto 96) <= B(127 downto 96);  
				end if;	
			when "11----1001---------------" =>		-- MLHU  
				Rd(31 downto 0) <= std_logic_vector(unsigned(A(15 downto 0)) * unsigned(B(15 downto 0)));				
				Rd(63 downto 32) <= std_logic_vector(unsigned(A(47 downto 32)) * unsigned(B(47 downto 32)));				
				Rd(95 downto 64) <= std_logic_vector(unsigned(A(79 downto 64)) * unsigned(B(79 downto 64)));				
				Rd(127 downto 96) <= std_logic_vector(unsigned(A(111 downto 96)) * unsigned(B(111 downto 96)));   
			when "11----1010---------------" =>		-- MLHCU  	 
				Rd(31 downto 0) <= "00000000000" & std_logic_vector(unsigned(B(15 downto 0)) * unsigned(op(14 downto 10)));	 
				Rd(63 downto 32) <= "00000000000" & std_logic_vector(unsigned(B(47 downto 32)) * unsigned(op(14 downto 10)));
				Rd(95 downto 64) <= "00000000000" & std_logic_vector(unsigned(B(79 downto 64)) * unsigned(op(14 downto 10)));
				Rd(127 downto 96) <= "00000000000" & std_logic_vector(unsigned(B(111 downto 96)) * unsigned(op(14 downto 10)));
			when "11----1011---------------" =>		-- OR 	 		
				Rd <= A or B;										    -- compute A or B
			when "11----1100---------------" =>		-- PCNTW 		 
				count := "00000000000000000000000000000000";					
				for a in 0 to 31 loop
					count := count + unsigned("0000000000000000000000000000000" & B(a));
				end loop;
				Rd(31 downto 0) <= std_logic_vector(count);  
				
				count := "00000000000000000000000000000000";		  
				for a in 32 to 63 loop
					count := count + unsigned("0000000000000000000000000000000" & B(a));
				end loop;
				Rd(63 downto 32) <= std_logic_vector(count); 
				
				count := "00000000000000000000000000000000";		
				for a in 64 to 95 loop
					count := count + unsigned("0000000000000000000000000000000" & B(a));
				end loop;
				Rd(95 downto 64) <= std_logic_vector(count); 
				
				count := "00000000000000000000000000000000";	
				for a in 96 to 127 loop
					count := count + unsigned("0000000000000000000000000000000" & B(a));
				end loop;
				Rd(127 downto 96) <= std_logic_vector(count); 	  
			when "11----1101---------------" =>		-- ROTW  
				Rd(31 downto 0) <= std_logic_vector(rotate_right(unsigned(B(31 downto 0)), to_integer(unsigned(A(4 downto 0)))));  
				Rd(63 downto 32) <= std_logic_vector(rotate_right(unsigned(B(63 downto 32)), to_integer(unsigned(A(4 downto 0)))));
				Rd(95 downto 64) <= std_logic_vector(rotate_right(unsigned(B(95 downto 64)), to_integer(unsigned(A(4 downto 0)))));
				Rd(127 downto 96) <= std_logic_vector(rotate_right(unsigned(B(127 downto 96)), to_integer(unsigned(A(4 downto 0)))));
			when "11----1110---------------" =>		-- SFHS   
				Rd(15 downto 0) <= std_logic_vector(signed(A(15 downto 0)) - signed(B(15 downto 0)));
				Rd(31 downto 16) <= std_logic_vector(signed(A(31 downto 16)) - signed(B(31 downto 16)));
				Rd(47 downto 32) <= std_logic_vector(signed(A(47 downto 32)) - signed(B(47 downto 32)));
				Rd(63 downto 48) <= std_logic_vector(signed(A(63 downto 48)) - signed(B(63 downto 48)));
				Rd(79 downto 64) <= std_logic_vector(signed(A(79 downto 64)) - signed(B(79 downto 64)));
				Rd(95 downto 80) <= std_logic_vector(signed(A(95 downto 80)) - signed(B(95 downto 80)));
				Rd(111 downto 96) <= std_logic_vector(signed(A(111 downto 96)) - signed(B(111 downto 96)));
				Rd(127 downto 112) <= std_logic_vector(signed(A(127 downto 112)) - signed(B(127 downto 112))); 
						 
				if (not A(15) = B(15) and not A(15) = Rd(15) and Rd(15) = '1') then							   	-- check for overflow
					Rd(15 downto 0) <= std_logic_vector(max16);
				elsif (not A(15) = B(15) and not A(15) = Rd(15) and Rd(15) = '0')	then						-- check for underflow                                                      
					Rd(15 downto 0) <= std_logic_vector(min16);
				end if;	
				if (not A(31) = B(31) and not A(31) = Rd(31) and Rd(31) = '1') then							   	-- check for overflow
					Rd(31 downto 16) <= std_logic_vector(max16);
				elsif (not A(31) = B(31) and not A(31) = Rd(31) and Rd(31) = '0')	then						-- check for underflow
					Rd(31 downto 16) <= std_logic_vector(min16);
				end if;
				if (not A(47) = B(47) and not A(47) = Rd(47) and Rd(47) = '1') then							   	-- check for overflow
					Rd(47 downto 32) <= std_logic_vector(max16);
				elsif (not A(47) = B(47) and not A(47) = Rd(47) and Rd(47) = '0')	then						-- check for underflow
					Rd(47 downto 32) <= std_logic_vector(min16);
				end if;
				if (not A(63) = B(63) and not A(63) = Rd(63) and Rd(63) = '1') then							    -- check for overflow
					Rd(63 downto 48) <= std_logic_vector(max16);
				elsif (not A(63) = B(63) and not A(63) = Rd(63) and Rd(63) = '0')	then						-- check for underflow
					Rd(63 downto 48) <= std_logic_vector(min16);
				end if;	
				if (not A(79) = B(79) and not A(79) = Rd(79) and Rd(79) = '1') then								-- check for overflow
					Rd(79 downto 64) <= std_logic_vector(max16);
				elsif (not A(79) = B(79) and not A(79) = Rd(79) and Rd(79) = '0')	then						-- check for underflow
					Rd(79 downto 64) <= std_logic_vector(min16);
				end if;
				if (not A(95) = B(95) and not A(95) = Rd(95) and Rd(95) = '1') then								-- check for overflow
					Rd(95 downto 80) <= std_logic_vector(max16);
				elsif (not A(95) = B(95) and not A(95) = Rd(95) and Rd(95) = '0')	then						-- check for underflow
					Rd(95 downto 80) <= std_logic_vector(min16);
				end if;	
				if (not A(111) = B(111) and not A(111) = Rd(111) and Rd(111) = '1') then						-- check for overflow
					Rd(111 downto 96) <= std_logic_vector(max16);
				elsif (not A(111) = B(111) and not A(111) = Rd(111) and Rd(111) = '0') then					 	-- check for underflow
					Rd(111 downto 96) <= std_logic_vector(min16);
				end if;	
				if (not A(127) = B(127) and not A(127) = Rd(127) and Rd(127) = '1') then						-- check for overflow
					Rd(127 downto 112) <= std_logic_vector(max16);
				elsif (not A(127) = B(127) and not A(127) = Rd(127) and Rd(127) = '0') then					 	-- check for underflow
					Rd(127 downto 112) <= std_logic_vector(min16);
				end if;
			when "11----1111---------------" =>		-- SFW    
				Rd(31 downto 0) <= std_logic_vector(unsigned(A(31 downto 0)) - unsigned(B(31 downto 0)));		 
				Rd(63 downto 32) <= std_logic_vector(unsigned(A(63 downto 32)) - unsigned(B(63 downto 32)));
				Rd(95 downto 64) <= std_logic_vector(unsigned(A(95 downto 64)) - unsigned(B(95 downto 64)));
				Rd(127 downto 96) <= std_logic_vector(unsigned(A(127 downto 96)) - unsigned(B(127 downto 96))); 
			when others => null;
		end case?;
	end process;   
end behavioral;
