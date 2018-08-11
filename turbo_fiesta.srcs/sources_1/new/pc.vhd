library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

-- TODO Define generics for width and height
-- Width  = 80
-- Height = 25

entity pc is
  port(clk      : in  std_logic; -- Clock
       reset    : in  std_logic; -- '1' to reset to top-left moving left
       stall    : in  std_logic; -- '1' to prevent PC advancement
       chng_dir : in  std_logic; -- '1' if direction is changed
       bridge   : in  std_logic; -- for the '#' instructions
       dx       : in    signed( 1 downto 0); -- dPCx/dt
       dy       : in    signed( 1 downto 0); -- dPCy/dt
       o_PC_x   : out unsigned( 7 downto 0); -- PC x output
       o_PC_y   : out unsigned( 7 downto 0); -- PC y output
       o_addr   : out std_logic_vector(15 downto 0));-- 1D mem address
end pc;

architecture behavioral of pc is
  component pc_1d
    port(clk      : in  std_logic; -- Clock
         reset    : in  std_logic; -- Reset pin
         stall    : in  std_logic; -- Stall the pc
         chng_dir : in  std_logic; -- '1' if direction is changed
         bridge   : in  std_logic; -- for the '#' instructions
         max      : in    signed(7 downto 0); -- Max+1. Wraps to 0
         i_dPC    : in    signed(1 downto 0); -- dPC/dt
         i_PC      : in  unsigned(7 downto 0); -- reset value for PC
         o_PC     : out unsigned(7 downto 0));-- PC output
  end component;

  -- Internal signals
  signal width  :   signed(7 downto 0) := x"50"; -- Width is 80
  signal height :   signed(7 downto 0) := x"19"; -- Height is 25
  signal s_PC_x : unsigned(7 downto 0);
  signal s_rPC_x: unsigned(7 downto 0);
  signal s_PC_y : unsigned(7 downto 0);
  signal s_dx   :   signed(1 downto 0);
  signal s_dy   :   signed(1 downto 0);

begin
  -- Outputs
  o_PC_x <= s_PC_x;
  o_PC_y <= s_PC_y;
  o_addr <= std_logic_vector(unsigned(width)*s_PC_y + (x"00" & s_PC_x));

  -- X PC
  s_dx <= dx when (reset = '0') else "01";
  s_rPC_x <= unsigned(width) - to_unsigned(1, 8);
  pc_x: pc_1d
  port map(
    clk      => clk,
    reset    => reset,
    stall    => stall,
    chng_dir => chng_dir,
    bridge   => bridge,
    max      => width,
    i_dPC    => s_dx,
    i_PC     => s_rPC_x,
    o_PC     => s_PC_x);

  -- Y PC
  s_dy <= dy when (reset = '0') else "00";
  pc_y: pc_1d
  port map(
    clk      => clk,
    reset    => reset,
    stall    => stall,
    chng_dir => chng_dir,
    bridge   => bridge,
    max      => height,
    i_dPC    => s_dy,
    i_PC     => x"00",
    o_PC     => s_PC_y);

end behavioral;
