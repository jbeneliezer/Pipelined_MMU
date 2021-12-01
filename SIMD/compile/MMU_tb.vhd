-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : SIMD
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\jb\Documents\repos\SIMD\SIMD\compile\MMU_tb.vhd
-- Generated   : Tue Nov 30 01:06:48 2021
-- From        : C:\Users\jb\Documents\repos\SIMD\SIMD\..\blocks\MMU_tb.bde
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
use std.TEXTIO.all;
use std.ENV.FINISH;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity MMU_tb is 
end MMU_tb;

architecture bench of MMU_tb is

---- Component declarations -----

component MMU
  port(
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       input : in vec_array(0 to 63);
       output : out RESULT
  );
end component;

---- Architecture declarations -----
constant program_size : integer := 64;



---- Signal declarations used on the diagram ----

signal clk : STD_LOGIC;
signal output : result;
signal rst : STD_LOGIC;
signal input : vec_array(0 to 63);
signal outputs : results(0 to 63);

begin

---- Processes ----

clock : process
                       begin
                         rst <= '1';
                         wait for 10 ns;
                         rst <= '0';
                         wait for 10 ns;
                         for i in 0 to program_size - 1 loop
                             clk <= '1';
                             if (i < 64) then
                                outputs(i) <= output;
                             end if;
                             wait for 5 ns;
                             clk <= '0';
                             wait for 5 ns;
                         end loop;
                         rst <= '1';
                         wait;
                       end process;
                      

read_file : process
                         file file_in : text open read_mode is "stimulus.txt";
                         variable row : line;
                         variable test_input : vec_array(0 to 63)(24 downto 0);
                         variable i : integer := 0;
                       begin
                         while not endfile(file_in) and i < 64 loop
                             READLINE(file_in,row);
                             READ(row,test_input(i));
                             i := i + 1;
                         end loop;
                         FILE_CLOSE(file_in);
                         input <= test_input;
                         wait;
                       end process;
                      

write_file : process
                         file file_out : text open write_mode is "results.txt";
                         variable row : line;
                       begin
                         wait until rst = '0';
                         wait until rst = '1';
                         WRITE(row,"PC ",left,3);
                         WRITE(row,"instr0 ",left,8);
                         WRITE(row,"instr1 ",left,8);
                         WRITE(row,"instr2 ",left,8);
                         WRITE(row,"e ",left,2);
                         WRITE(row,"i ",left,2);
                         WRITE(row,"wa ",left,3);
                         WRITE(row,"write_data ",left,33);
                         WRITELINE(file_out,row);
                         WRITELINE(file_out,row);
                         for i in 0 to 63 loop
                             HWRITE(row,outputs(i).PC,left,2);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).instr0,left,7);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).instr1,left,7);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).instr2,left,7);
                             WRITE(row," ",left,1);
                             WRITE(row,outputs(i).write_en,left,1);
                             WRITE(row," ",left,1);
                             WRITE(row,outputs(i).li,left,1);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).write_addr,left,2);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).write_data,left,32);
                             WRITELINE(file_out,row);
                             WRITE(row," ",left,4);
                             WRITE(row,"rf_out ",right,7);
                             HWRITE(row,outputs(i).rf_out(0),left,32);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).rf_out(1),left,32);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).rf_out(2),left,32);
                             WRITELINE(file_out,row);
                             WRITE(row," ",left,4);
                             WRITE(row,"fu_in ",right,7);
                             HWRITE(row,outputs(i).fu_in(0),left,32);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).fu_in(1),left,32);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).fu_in(2),left,32);
                             WRITELINE(file_out,row);
                             WRITE(row," ",left,4);
                             WRITE(row,"alu_in ",right,7);
                             HWRITE(row,outputs(i).alu_in(0),left,32);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).alu_in(1),left,32);
                             WRITE(row," ",left,1);
                             HWRITE(row,outputs(i).alu_in(2),left,32);
                             WRITELINE(file_out,row);
                             WRITE(row," ",left,3);
                             WRITE(row,"alu_out ",right,8);
                             HWRITE(row,outputs(i).alu_out,left,32);
                             WRITELINE(file_out,row);
                             WRITELINE(file_out,row);
                         end loop;
                         FILE_CLOSE(file_out);
                         wait for 10 ns;
                         FINISH;
                       end process;
                      

----  Component instantiations  ----

uut : MMU
  port map(
       clk => clk,
       rst => rst,
       input => input,
       output => output
  );


end bench;
