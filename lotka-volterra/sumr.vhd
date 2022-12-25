library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sumr is
PORT(    A      : IN Signed (26 downto 0);
         B      : IN Signed (26 downto 0);
         output  : OUT signed (26 downto 0)); -- output
end sumr;

architecture Behavioral of sumr is

begin

output <= A + B;

end Behavioral;
