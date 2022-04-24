----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2022 05:59:50 PM
-- Design Name: 
-- Module Name: DE4_7Segment - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


-- fpga4student.com: FPGA projects, Verilog projects, VHDL projects
-- VHDL code for seven-segment display on Basys 3 FPGA
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity seven_segment_display_VHDL is
    Port ( clk : in std_logic;
           reset : in std_logic;
           addra : in std_logic_vector(3 downto 0);
           douta : in std_logic_vector(3 downto 0);
           annode : out std_logic_vector(3 downto 0);
           cathode : out std_logic_vector(6 downto 0)
           );
end seven_segment_display_VHDL;

architecture Behavioral of seven_segment_display_VHDL is
signal scan_clk : std_logic;
signal hexAddra : std_logic_vector(3 downto 0);
signal hexDouta : std_logic_vector(3 downto 0);
signal segmentSel : std_logic_vector(1 downto 0):= "00";
signal hexDisplay : std_logic_vector(3 downto 0);

begin

    hexConcat : process(addra, douta) is
        begin
            hexAddra <= addra;
            hexDouta <= douta;
    end process;

    scan_clk_gen : process (clk) is                     --create clock with a slower clock for board
        --variable count : integer range 0 to 15000000;
        variable count : integer range 0 to 300000;
        begin
        if rising_edge(clk) then
            if(count = 300000) then                   --sets slow clock to 1 after so many cycles
                count := 0;
                scan_clk <= '1';
            else
                count := count + 1;
                scan_clk <= '0';
           end if;
        end if;                
    end process;                                        --code from professor moulic
    
    segment_counter : process (clk) is                  --process to pick which segment to display to 
    begin     
        if rising_edge(clk) then
            if (reset = '1') then
                segmentSel <= "00";
            elsif(scan_clk = '1') then                       --clk for sim, scan_clk for board
                segmentSel <= segmentSel + 1;
            end if;
       end if;
  end process;   
  
  process (scan_clk) is                                           --clk for sim, scan_clk for board
  begin
  
    case segmentSel is
        when "00" =>
            hexDisplay <= hexDouta;
        when "01" =>
            hexDisplay <= hexAddra;
        when others =>
            hexDisplay <= "0000";         
    end case;
    
    case segmentSel is                  --picks which segment annode is active
        when "00" =>
            annode <= "1110";
        when "01" =>
            annode <= "1101";
        when "10" =>
            annode <= "1011";
       when "11" =>
            annode <= "0111";
       when others =>
            annode <= "0000";                  
    end case; 
    
    case hexDisplay is
        when "0000" =>               --0
            cathode <= "0000001";
        when "0001" =>               --1
            cathode <= "1001111";
        when  "0010" =>              --2
            cathode <= "0010010";
        when "0011" =>               --3
            cathode <= "0000110";
        when "0100" =>               --4
            cathode <= "1001100";
        when "0101" =>               --5
            cathode <= "0100100";
        when "0110" =>               --6
            cathode <= "0100000";
        when "0111" =>               --7
            cathode <= "0001111";
        when "1000" =>               --8
            cathode <= "0000000";
        when "1001" =>               --9
            cathode <= "0001100";
        when "1010" =>               --A
            cathode <= "0001000";
        when "1011" =>               --B
            cathode <= "1100000";  
        when "1100" =>               --C
            cathode <= "0110001";
        when "1101" =>               --D
            cathode <= "1000010"; 
        when "1110" =>               --E
            cathode <= "0110000";
        when "1111" =>               --F
            cathode <=  "0111000";
       when others =>                --X for error
            cathode <=  "1001000";
     end case;                                        
  end process;
end Behavioral;