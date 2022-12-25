-- eulers method for integration

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dda is 
    PORT(clock   : IN STD_LOGIC             ; -- rising edge trigger
         reset   : IN STD_LOGIC             ; -- active high
         funct   : IN signed (26 downto 0)  ; -- dx/dt function 
         initial : IN signed (26 downto 0)  ; -- initial condition of DDA
         dt      : IN integer               ; -- dT value 4 bit
         output  : OUT signed (26 downto 0)); -- output
    
end dda;

architecture Behavioral of dda is

signal x1, x1new : signed (26 downto 0);
begin

process(clock, reset)
begin
if rising_edge(clock) then
    if reset = '1' then
        x1 <= initial; -- integrator resets back to IC
    else
        x1 <= x1new;
    end if;
end if;
end process;
    
x1new <= x1 + shift_right(funct,dt); -- shift_right is for multiplication
output <= x1;

end Behavioral;
