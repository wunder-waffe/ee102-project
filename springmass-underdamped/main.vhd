library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    port(clk        : IN STD_LOGIC;
         rst        : IN STD_LOGIC;
         DAC        : OUT STD_LOGIC_VECTOR (15 downto 0)
         );
end main;

architecture Behavioral of main is
signal IC_signal      : STD_LOGIC := '0';
signal result         : STD_LOGIC_VECTOR (26 downto 0);
signal slow           : STD_LOGIC;
begin

analog: entity work.analog(Behavioral)
port map (clock => clk, compres => rst, output => result);

kilohertz: entity work.counter(Behavioral)
port map (clock => clk, clk18 => slow);

DAC <= result(26 downto 11);

end Behavioral;
