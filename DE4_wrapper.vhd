--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
--Date        : Sat Apr 23 19:36:51 2022
--Host        : DESKTOP-LOGAN running 64-bit major release  (build 9200)
--Command     : generate_target DE4_wrapper.bd
--Design      : DE4_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity DE4_wrapper is
  port (
    addra : in STD_LOGIC_VECTOR ( 3 downto 0 );
    annode : out STD_LOGIC_VECTOR ( 3 downto 0 );
    cathode : out STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    dina : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ena : in STD_LOGIC;
    reset : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end DE4_wrapper;

architecture STRUCTURE of DE4_wrapper is
  component DE4 is
  port (
    cathode : out STD_LOGIC_VECTOR ( 6 downto 0 );
    annode : out STD_LOGIC_VECTOR ( 3 downto 0 );
    reset : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC
  );
  end component DE4;
begin
DE4_i: component DE4
     port map (
      addra(3 downto 0) => addra(3 downto 0),
      annode(3 downto 0) => annode(3 downto 0),
      cathode(6 downto 0) => cathode(6 downto 0),
      clk => clk,
      dina(3 downto 0) => dina(3 downto 0),
      ena => ena,
      reset => reset,
      wea(0) => wea(0)
    );
end STRUCTURE;
