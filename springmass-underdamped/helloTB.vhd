library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_bench is
end test_bench;

architecture Behavioral of test_bench is

signal clk, reset       : STD_LOGIC;
signal output           : STD_LOGIC_VECTOR (15 downto 0);

begin

dut: entity work.main(Behavioral)
port map (clk       => clk,
         rst        => reset,
         DAC        => output);

clock_process: process begin
clk <= '0';
wait for 10ns;
clk <= '1';
wait for 10ns;
end process;

reset_process: process begin
reset <= '1';
wait for 10us;
reset <= '0';
wait for 50ms;

end process;
end Behavioral;