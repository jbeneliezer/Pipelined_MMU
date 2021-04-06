-------------------------------------------------------------------------------
--
-- Title       : ALU_functions
-- Design      : ALU_functions
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\SIMD\SIMD\src\ALU_functions.vhd
-- Generated   : Tue Mar 23 15:35:33 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : package of functions to be used by ALU
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package ALU_functions is 
	
	function MULT_ADD_I(x: std_logic_vector(15 downto 0);
		y: std_logic_vector(15 downto 0);
		z: std_logic_vector(31 downto 0)) return std_logic_vector;
	
	function MULT_SUB_I(x: std_logic_vector(15 downto 0);
		y: std_logic_vector(15 downto 0);
		z: std_logic_vector(31 downto 0)) return std_logic_vector; 
		
	function MULT_ADD_L(x: std_logic_vector(31 downto 0);
		y: std_logic_vector(31 downto 0);
		z: std_logic_vector(63 downto 0)) return std_logic_vector;
		
	function MULT_SUB_L(x: std_logic_vector(31 downto 0);
		y: std_logic_vector(31 downto 0);
		z: std_logic_vector(63 downto 0)) return std_logic_vector;
	
end package ALU_functions;	  


package body ALU_functions is	
	
	function MULT_ADD_I(x: std_logic_vector(15 downto 0);
		y: std_logic_vector(15 downto 0);
		z: std_logic_vector(31 downto 0)) return std_logic_vector is
		constant max32: signed := x"7FFFFFFF";		  													-- max 32 bit signed number
		constant min32: signed := x"80000000";		  													-- min 32 bit signed number
		variable product: signed (31 downto 0);
		variable sum: signed (31 downto 0);
	begin 
		product := signed(x) * signed(y);																-- compute x * y
		sum := product + signed(z);																		-- compute product + z
		
		if (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '1') then							-- check for overflow
			sum := max32;															
		elsif (product(31) = z(31) and not z(31) = sum(31) and sum(31) = '0') then						-- check for underflow
			sum := min32;															
		end if;		
		return std_logic_vector(sum);
	end function MULT_ADD_I;	 
	
	function MULT_SUB_I(x: std_logic_vector(15 downto 0);
		y: std_logic_vector(15 downto 0);
		z: std_logic_vector(31 downto 0)) return std_logic_vector is
		constant max32: signed := x"7FFFFFFF";		  													-- max 32 bit signed number
		constant min32: signed := x"80000000";		  													-- min 32 bit signed number
		variable product: signed (31 downto 0);
		variable dif: signed (31 downto 0);
	begin	  		  
		product := signed(x) * signed(y);																-- compute x * y
		dif := signed(z) - product;							  
		if (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '1') then						-- check for overflow
			dif := max32;
		elsif (not product(31) = z(31) and not z(31) = dif(31) and dif(31) = '0') then					-- check for underflow
			dif := min32;
		end if;		
		return std_logic_vector(dif);
	end function MULT_SUB_I;
	
	function MULT_ADD_L(x: std_logic_vector(31 downto 0);
		y: std_logic_vector(31 downto 0);
		z: std_logic_vector(63 downto 0)) return std_logic_vector is
		constant max64 : signed := x"7FFFFFFFFFFFFFFF";													-- max 64 bit signed number
		constant min64 : signed := x"8000000000000000";													-- min 64 bit signed number
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
	end function MULT_ADD_L;
	
	function MULT_SUB_L(x: std_logic_vector(31 downto 0);
		y: std_logic_vector(31 downto 0);
		z: std_logic_vector(63 downto 0)) return std_logic_vector is
		constant max64 : signed := x"7FFFFFFFFFFFFFFF";													-- max 64 bit signed number
		constant min64 : signed := x"8000000000000000";													-- min 64 bit signed number
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
	end function MULT_SUB_L;
end package body ALU_functions;