library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

-- Note: 8-bit signed PC means usable range is 0 to 127
-- Could theoretically use all 8, but would need better bounds-checking
entity pc_1d is
  port(bridge   : in  std_logic; -- for the '#' instructions
       low      : in  signed(7 downto 0); -- Min PC value
       high     : in  signed(7 downto 0); -- Max+1. Wraps to min
       dPC      : in  signed(1 downto 0); -- dPC/dt
       prev_PC  : in  signed(7 downto 0); -- previous PC
       curr_PC  : out signed(7 downto 0));-- PC output
end pc_1d;

architecture behavioral of pc_1d is
  -- Intermediate signals for calculation
  signal s_range : signed(7 downto 0);
  signal s_PC    : signed(7 downto 0);

begin

-- Compute range of possible values
s_range <= high - low;

-- s_PC is next value before bounds checking
s_PC <= prev_PC + dPC when bridge = '0' else
        prev_PC + dPC + dPC;

-- Shouldn't be an issue, but s_range must be greater than 1
curr_PC <= s_PC - s_range when s_PC >= high else
           s_PC + s_range when s_PC <  low  else
           s_PC;

end behavioral;
