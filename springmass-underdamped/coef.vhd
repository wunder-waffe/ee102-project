library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity coef is
    PORT(A     : IN signed (26 downto 0);
         B     : IN signed (26 downto 0);
         output : OUT signed (26 downto 0));
end coef;

architecture Behavioral of coef is
signal mult : signed (53 downto 0);
begin

mult <= A * B;
output <= mult(53) & mult(50 downto 25);
--output <= mult(35) & mult(32 downto 16);
end Behavioral;
