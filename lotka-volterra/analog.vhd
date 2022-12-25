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

constant intIC1 : integer := 29331480;
constant intIC2 : integer := 35331480;
constant intA   : integer := 22331480;
constant intB   : integer := 80023424;
constant intD   : integer := 25338911;
constant intG   : integer := 120023424;

constant intoffset1 : integer := 2876467;
constant intoffset2 : integer := 52876467;


signal X, Y, ou1,ou2            : signed (26 downto 0);
signal XxSUM1                   : signed (26 downto 0);
signal YxSUM2                   : signed (26 downto 0);
signal SUM1                     : signed (26 downto 0);
signal SUM2                     : signed (26 downto 0);
signal BxY, DxX                 : signed (26 downto 0);
signal offset1, offset2         : signed (26 downto 0);
signal IC1, IC2, A, B, D, G     : signed (26 downto 0);
signal dt                       : integer := 16;

begin

IC1         <= to_signed(intIC1,        IC1     'length);
IC2         <= to_signed(intIC2,        IC2     'length);
A           <= to_signed(intA,          A       'length);
B           <= to_signed(intB,          B       'length);
D           <= to_signed(intD,          D       'length);
G           <= to_signed(intG,          G       'length);
offset1      <= to_signed(intoffset1,   offset1 'length);
offset2      <= to_signed(intoffset2,   offset2 'length);


integrator1: entity work.dda(Behavioral)
port map (clock => clock, reset => compres, funct => XxSUM1, initial => IC1, dt => dt, output => X);

mult1: entity work.coef(Behavioral)
port map (A => X, B => SUM1, output => XxSUM1);

summ1: entity work.sumr(Behavioral)
port map (A => A, B => BxY, output => SUM1);

coefB: entity work.coef(Behavioral)
port map (A => Y, B => B, output => BxY);

integrator2: entity work.dda(Behavioral)
port map (clock => clock, reset => compres, funct => YxSUM2, initial => IC2, dt => dt, output => Y);

mult2: entity work.coef(Behavioral)
port map (A => Y, B => SUM2, output => YxSUM2);

summ2: entity work.sumr(Behavioral)
port map (A => DxX, B => G, output => SUM2);

coefD: entity work.coef(Behavioral)
port map (A => D, B => X, output => DxX);

summoff: entity work.sumr(Behavioral)
port map (A => X, B => offset1, output => ou1);

output <= std_logic_vector(unsigned(ou1));

end Behavioral;
