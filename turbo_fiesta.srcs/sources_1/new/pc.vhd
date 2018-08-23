library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

-- TODO Define generics for width and height
-- Width  = 80
-- Height = 25

-- TODO ADR replace all 'next' with 'curr'
entity pc is
  port(prev_PC_x : in  signed(7 downto 0);
       prev_PC_y : in  signed(7 downto 0);
       prev_dx   : in  signed(1 downto 0);
       prev_dy   : in  signed(1 downto 0);
       alu_flags : in  std_logic_vector(15 downto 0); -- See ALU for bitfield definition
       next_PC_x : out signed(7 downto 0); -- PC x output
       next_PC_y : out signed(7 downto 0); -- PC y output
       next_dx   : out signed(1 downto 0);
       next_dy   : out signed(1 downto 0);
       o_addr    : out std_logic_vector(10 downto 0));-- 1D mem address
end pc;

architecture behavioral of pc is

component pc_1d 
  port(bridge   : in  std_logic; -- for the '#' instructions
       low      : in  signed(7 downto 0); -- Min PC value
       high     : in  signed(7 downto 0); -- Max+1. Wraps to min
       dPC      : in  signed(1 downto 0); -- dPC/dt
       prev_PC  : in  signed(7 downto 0); -- current PC
       curr_PC  : out signed(7 downto 0));-- PC output
end component;

-- Internal signals
signal s_width  : signed( 7 downto 0) := x"50"; -- Width is 80
signal s_height : signed( 7 downto 0) := x"19"; -- Height is 25
signal s_zero   : signed( 7 downto 0) := x"00"; -- Zero is min for both x and y
signal s_addr   : signed(15 downto 0);
signal s_PC_x   : signed( 7 downto 0);
signal s_PC_y   : signed( 7 downto 0);
signal s_dx     : signed( 1 downto 0);
signal s_dy     : signed( 1 downto 0);
signal s_bridge : std_logic;

begin
  -- Outputs
  next_PC_x <= s_PC_x;
  next_PC_y <= s_PC_y;
  next_dx   <= s_dx;
  next_dy   <= s_dy;
  s_addr    <= (s_width*s_PC_y) + (x"00" & s_PC_x);
  o_addr    <= std_logic_vector(s_addr(10 downto 0));

  -- Determine bridge signal
  s_bridge <= alu_flags(2);

  -- X PC
  s_dx <= prev_dx when (alu_flags(0) = '0') else
          signed(alu_flags(15 downto 14));
  pc_x: pc_1d
  port map(
    bridge   => s_bridge,
    low      => s_zero,
    high     => s_width,
    dPC      => s_dx,
    prev_PC  => prev_PC_x,
    curr_PC  => s_PC_x);

  -- Y PC
  s_dy <= prev_dy when (alu_flags(0) = '0') else
          signed(alu_flags(13 downto 12));
  pc_y: pc_1d
  port map(
    bridge   => s_bridge,
    low      => s_zero,
    high     => s_height,
    dPC      => s_dy,
    prev_PC  => prev_PC_y,
    curr_PC  => s_PC_y);

end behavioral;
