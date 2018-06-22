library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity pc_1d is
  port(clk      : in  std_logic; -- Clock
       reset    : in  std_logic; -- '1' to reset to top-left moving left
       stall    : in  std_logic; -- '1' to prevent PC advancement
       bridge   : in  std_logic; -- for the '#' instructions
       chng_dir : in  std_logic; -- '1' if direction is changed
       max      : in    signed(7 downto 0); -- Max+1. Wraps to 0
       i_dPC    : in    signed(1 downto 0); -- dPC/dt
       i_PC     : in  unsigned(7 downto 0); -- reset value for PC
       o_PC     : out unsigned(7 downto 0));-- PC output
end pc_1d;

architecture behavioral of pc_1d is
  -- Register signals
  signal r_PC   : unsigned(7 downto 0); -- PC value
  signal r_dPC  :   signed(1 downto 0); -- direction
  -- Other internal signals
  signal     mux_PC :   signed(7 downto 0);
  signal unbound_PC :   signed(7 downto 0);
  signal   bound_PC :   signed(7 downto 0);
  signal    mux_dPC :   signed(1 downto 0);

begin
  -- Output value
  o_PC <= r_PC;

  -- Mux input with current value
  mux_PC <= signed(i_PC) when (reset = '1') else signed(r_PC);
  
  -- Mux input direction with current
  mux_dPC <= i_dPC when (reset = '1') or (chng_dir = '1') else
             r_dPC;

  -- Compute tenative next PC
  unbound_PC <= mux_PC when (stall = '1') else
                mux_PC + mux_dPC + mux_dPC when (bridge = '1') else
                mux_PC + mux_dPC;
  
  -- Wrap the PC within the program area
  bound_PC <= unbound_PC - max when (unbound_PC >= max)  else
              unbound_PC + max when (unbound_PC < x"00") else
              unbound_PC;
  
  -- Update PC
  pc_proc: process(clk, reset)
  begin
    if (reset = '1')
    then
      r_PC  <= unsigned((signed(i_PC) + i_dPC) rem max);
      r_dPC <= i_dPC;
    elsif (rising_edge(clk))
    then
      r_PC  <= unsigned(bound_PC);
      r_dPC <= mux_dPC;
    end if;
  end process pc_proc;

end behavioral;
