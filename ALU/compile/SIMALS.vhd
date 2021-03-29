-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : Judah Ben-Eliezer
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\SIMD\ALU\compile\SIMALS.vhd
-- Generated   : Sun Mar 28 22:23:33 2021
-- From        : C:\My_Designs\SIMD\ALU\..\blocks\SIMALS.bde
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

entity SIMALS is
  port(
       op : in STD_LOGIC_VECTOR(24 downto 0);
       i : in STD_LOGIC_VECTOR(127 downto 0);
       j : in STD_LOGIC_VECTOR(127 downto 0);
       k : in STD_LOGIC_VECTOR(127 downto 0);
       r : out STD_LOGIC_VECTOR(127 downto 0)
  );
end SIMALS;

architecture behavioral of SIMALS is

---- Component declarations -----

component MULT_ADD_I
  port(
       x : in STD_LOGIC_VECTOR(15 downto 0);
       y : in STD_LOGIC_VECTOR(15 downto 0);
       z : in STD_LOGIC_VECTOR(31 downto 0);
       result : out STD_LOGIC_VECTOR(31 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal res0 : STD_LOGIC_VECTOR(31 downto 0);
signal res1 : STD_LOGIC_VECTOR(31 downto 0);
signal res2 : STD_LOGIC_VECTOR(31 downto 0);
signal res3 : STD_LOGIC_VECTOR(31 downto 0);

begin

---- Processes ----

process (op)
                       begin
                         if (op(24 downto 20) = "10000") then
                            r <= res3 & res2 & res1 & res0;
                         end if;
                       end process;
                      

----  Component instantiations  ----

SIMALS_0 : MULT_ADD_I
  port map(
       x(15) => i(15),
       x(14) => i(14),
       x(13) => i(13),
       x(12) => i(12),
       x(11) => i(11),
       x(10) => i(10),
       x(9) => i(9),
       x(8) => i(8),
       x(7) => i(7),
       x(6) => i(6),
       x(5) => i(5),
       x(4) => i(4),
       x(3) => i(3),
       x(2) => i(2),
       x(1) => i(1),
       x(0) => i(0),
       y(15) => j(15),
       y(14) => j(14),
       y(13) => j(13),
       y(12) => j(12),
       y(11) => j(11),
       y(10) => j(10),
       y(9) => j(9),
       y(8) => j(8),
       y(7) => j(7),
       y(6) => j(6),
       y(5) => j(5),
       y(4) => j(4),
       y(3) => j(3),
       y(2) => j(2),
       y(1) => j(1),
       y(0) => j(0),
       z(31) => k(31),
       z(30) => k(30),
       z(29) => k(29),
       z(28) => k(28),
       z(27) => k(27),
       z(26) => k(26),
       z(25) => k(25),
       z(24) => k(24),
       z(23) => k(23),
       z(22) => k(22),
       z(21) => k(21),
       z(20) => k(20),
       z(19) => k(19),
       z(18) => k(18),
       z(17) => k(17),
       z(16) => k(16),
       z(15) => k(15),
       z(14) => k(14),
       z(13) => k(13),
       z(12) => k(12),
       z(11) => k(11),
       z(10) => k(10),
       z(9) => k(9),
       z(8) => k(8),
       z(7) => k(7),
       z(6) => k(6),
       z(5) => k(5),
       z(4) => k(4),
       z(3) => k(3),
       z(2) => k(2),
       z(1) => k(1),
       z(0) => k(0),
       result => res0
  );

SIMALS_1 : MULT_ADD_I
  port map(
       x(15) => i(47),
       x(14) => i(46),
       x(13) => i(45),
       x(12) => i(44),
       x(11) => i(43),
       x(10) => i(42),
       x(9) => i(41),
       x(8) => i(40),
       x(7) => i(39),
       x(6) => i(38),
       x(5) => i(37),
       x(4) => i(36),
       x(3) => i(35),
       x(2) => i(34),
       x(1) => i(33),
       x(0) => i(32),
       y(15) => j(47),
       y(14) => j(46),
       y(13) => j(45),
       y(12) => j(44),
       y(11) => j(43),
       y(10) => j(42),
       y(9) => j(41),
       y(8) => j(40),
       y(7) => j(39),
       y(6) => j(38),
       y(5) => j(37),
       y(4) => j(36),
       y(3) => j(35),
       y(2) => j(34),
       y(1) => j(33),
       y(0) => j(32),
       z(31) => k(63),
       z(30) => k(62),
       z(29) => k(61),
       z(28) => k(60),
       z(27) => k(59),
       z(26) => k(58),
       z(25) => k(57),
       z(24) => k(56),
       z(23) => k(55),
       z(22) => k(54),
       z(21) => k(53),
       z(20) => k(52),
       z(19) => k(51),
       z(18) => k(50),
       z(17) => k(49),
       z(16) => k(48),
       z(15) => k(47),
       z(14) => k(46),
       z(13) => k(45),
       z(12) => k(44),
       z(11) => k(43),
       z(10) => k(42),
       z(9) => k(41),
       z(8) => k(40),
       z(7) => k(39),
       z(6) => k(38),
       z(5) => k(37),
       z(4) => k(36),
       z(3) => k(35),
       z(2) => k(34),
       z(1) => k(33),
       z(0) => k(32),
       result => res1
  );

SIMALS_2 : MULT_ADD_I
  port map(
       x(15) => i(79),
       x(14) => i(78),
       x(13) => i(77),
       x(12) => i(76),
       x(11) => i(75),
       x(10) => i(74),
       x(9) => i(73),
       x(8) => i(72),
       x(7) => i(71),
       x(6) => i(70),
       x(5) => i(69),
       x(4) => i(68),
       x(3) => i(67),
       x(2) => i(66),
       x(1) => i(65),
       x(0) => i(64),
       y(15) => j(79),
       y(14) => j(78),
       y(13) => j(77),
       y(12) => j(76),
       y(11) => j(75),
       y(10) => j(74),
       y(9) => j(73),
       y(8) => j(72),
       y(7) => j(71),
       y(6) => j(70),
       y(5) => j(69),
       y(4) => j(68),
       y(3) => j(67),
       y(2) => j(66),
       y(1) => j(65),
       y(0) => j(64),
       z(31) => k(95),
       z(30) => k(94),
       z(29) => k(93),
       z(28) => k(92),
       z(27) => k(91),
       z(26) => k(90),
       z(25) => k(89),
       z(24) => k(88),
       z(23) => k(87),
       z(22) => k(86),
       z(21) => k(85),
       z(20) => k(84),
       z(19) => k(83),
       z(18) => k(82),
       z(17) => k(81),
       z(16) => k(80),
       z(15) => k(79),
       z(14) => k(78),
       z(13) => k(77),
       z(12) => k(76),
       z(11) => k(75),
       z(10) => k(74),
       z(9) => k(73),
       z(8) => k(72),
       z(7) => k(71),
       z(6) => k(70),
       z(5) => k(69),
       z(4) => k(68),
       z(3) => k(67),
       z(2) => k(66),
       z(1) => k(65),
       z(0) => k(64),
       result => res2
  );

SIMALS_3 : MULT_ADD_I
  port map(
       x(15) => i(111),
       x(14) => i(110),
       x(13) => i(109),
       x(12) => i(108),
       x(11) => i(107),
       x(10) => i(106),
       x(9) => i(105),
       x(8) => i(104),
       x(7) => i(103),
       x(6) => i(102),
       x(5) => i(101),
       x(4) => i(100),
       x(3) => i(99),
       x(2) => i(98),
       x(1) => i(97),
       x(0) => i(96),
       y(15) => j(111),
       y(14) => j(110),
       y(13) => j(109),
       y(12) => j(108),
       y(11) => j(107),
       y(10) => j(106),
       y(9) => j(105),
       y(8) => j(104),
       y(7) => j(103),
       y(6) => j(102),
       y(5) => j(101),
       y(4) => j(100),
       y(3) => j(99),
       y(2) => j(98),
       y(1) => j(97),
       y(0) => j(96),
       z(31) => k(127),
       z(30) => k(126),
       z(29) => k(125),
       z(28) => k(124),
       z(27) => k(123),
       z(26) => k(122),
       z(25) => k(121),
       z(24) => k(120),
       z(23) => k(119),
       z(22) => k(118),
       z(21) => k(117),
       z(20) => k(116),
       z(19) => k(115),
       z(18) => k(114),
       z(17) => k(113),
       z(16) => k(112),
       z(15) => k(111),
       z(14) => k(110),
       z(13) => k(109),
       z(12) => k(108),
       z(11) => k(107),
       z(10) => k(106),
       z(9) => k(105),
       z(8) => k(104),
       z(7) => k(103),
       z(6) => k(102),
       z(5) => k(101),
       z(4) => k(100),
       z(3) => k(99),
       z(2) => k(98),
       z(1) => k(97),
       z(0) => k(96),
       result => res3
  );


end behavioral;
