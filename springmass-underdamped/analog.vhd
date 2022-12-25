library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity analog is
    Port (clock         : IN  STD_LOGIC;
          compres       : IN  STD_LOGIC;
          output        : OUT STD_LOGIC_VECTOR(26 downto 0)
          );
end analog;

architecture Behavioral of analog is

constant intIC1 : integer := 0;
constant intIC2 : integer := 25331480;
constant intK : integer := 100023424;
constant intD : integer := 130023424;
constant intoffset : integer := 52876467;


signal v1,v2,ou             : signed (26 downto 0);
signal V2xK                 : signed (26 downto 0);
signal V1xD                 : signed (26 downto 0);
signal sum,offset           : signed (26 downto 0);
signal IC1, IC2, K, D       : signed (26 downto 0);
signal dt                   : integer := 8;

begin

IC1         <= to_signed(intIC1,     IC1'length);
IC2         <= to_signed(intIC2,     IC2'length);
K           <= to_signed(intK,       V2xK'length);
D           <= to_signed(intD,       V1xD'length);
offset      <= to_signed(intoffset,  offset'length);


integrator2: entity work.dda(Behavioral)
port map (clock => clock, reset => compres, funct => v1, initial => IC2, dt => dt, output => v2);

mult1: entity work.coef(Behavioral)
port map (A => v2, B => K, output => v2xK);

mult2: entity work.coef(Behavioral)
port map (A => v1, B => D, output => V1xD);

summ1: entity work.sumr(Behavioral)
port map (A => v2xK, B => v1xD, output => sum);

integrator1: entity work.dda(Behavioral)
port map (clock => clock, reset => compres, funct => sum, initial => IC1, dt => dt, output => v1);

summ2: entity work.sumr(Behavioral)
port map (A => v2, B => offset, output => ou);

output <= std_logic_vector(unsigned(ou));

end Behavioral;
