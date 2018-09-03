library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_alu is
  port ( clk       : in  std_logic;
         reset     : in  std_logic;
         program   : in  std_logic;
         -- Register inputs
         i_state   : in  std_logic_vector (19 downto 0);
         i_flags   : in  std_logic_vector (15 downto 0);
         i_restop  : in  std_logic_vector (31 downto 0);
         i_resbot  : in  std_logic_vector (31 downto 0);
         i_im_addr : in  std_logic_vector (11 downto 0);
         i_sp      : in  std_logic_vector (15 downto 0);
         -- Register outputs
         o_state   : out std_logic_vector (19 downto 0);
         o_flags   : out std_logic_vector (15 downto 0);
         o_restop  : out std_logic_vector (31 downto 0);
         o_resbot  : out std_logic_vector (31 downto 0);
         o_im_addr : out std_logic_vector (11 downto 0);
         o_sp      : out std_logic_vector (15 downto 0));
end reg_alu;

architecture Behavioral of reg_alu is
  signal r_state   : std_logic_vector (19 downto 0) := x"1004F"; --x"00000";
  signal r_flags   : std_logic_vector (15 downto 0) := x"0000";
  signal r_restop  : std_logic_vector (31 downto 0) := x"00000000";
  signal r_resbot  : std_logic_vector (31 downto 0) := x"00000000";
  signal r_im_addr : std_logic_vector (11 downto 0) := x"000";
  signal r_sp      : std_logic_vector (15 downto 0) := x"0000";
  -- Reset state at top-right to wrap and start at (0, 0)
  signal s_rstate  : std_logic_vector (19 downto 0) := x"1004F";
  -- Program load state is at row 35, col 0
  signal s_pstate  : std_logic_vector (19 downto 0) := x"02300";
begin

-- Set outputs
o_state   <= r_state;
o_flags   <= r_flags;
o_restop  <= r_restop;
o_resbot  <= r_resbot;
o_im_addr <= r_im_addr;
o_sp      <= r_sp;

-- Register process    
reg_process: process(clk)
begin
  if (rising_edge(clk)) then
    if (reset = '0') then
      r_state   <= i_state;
      r_flags   <= i_flags;
      r_restop  <= i_restop;
      r_resbot  <= i_resbot;
      r_im_addr <= i_im_addr;
      r_sp      <= i_sp;
    else
      if (program = '0') then
        r_state   <= s_rstate;
      else
        r_state   <= s_pstate;
      end if;
      r_flags   <= x"0000";
      r_restop  <= x"00000000";
      r_resbot  <= x"00000000";
      r_im_addr <= x"000";
      r_sp      <= x"0000";
    end if;
  end if;
end process;

end Behavioral;
