library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity clk_control is
  port(clk       : in  std_logic; -- Clock
       reset     : in  std_logic; -- Reset pin
       stall     : in  std_logic; -- Stall if math isn't done
       pc_clk    : out std_logic; -- Clock for PC
       fetch_clk : out std_logic; -- Clock for instruction fetch
       alu_clk   : out std_logic; -- Clock for ALU computation
       im_clk    : out std_logic; -- Clock to enable instruction mem write
       st_clk    : out std_logic);-- Clock to enable stack push
end clk_control;

architecture behavioral of clk_control is
  -- Internal signals
  signal prev_reset  : std_logic := '0';
  -- Signal count Counts 0 through 7 to determine which sub-clock is high
  signal r_count     : unsigned(2 downto 0) := "000";
  signal s_count     : unsigned(2 downto 0);
  -- Once while reset is high, rst_clock is toggled to reset the PC 
  signal rst_count   : unsigned(2 downto 0) := "000";
  -- Internal copy of pc_clk to apply alt clock during reset
  signal s_pc_clk    : std_logic;
  -- Signal output of rst_count register
  signal s_rst_count : unsigned(2 downto 0);

begin
  -- Register outputs
  s_rst_count <= rst_count;
  s_count <= r_count;
  
  -- Latch PC after rising edge 0
  with s_count select s_pc_clk <=
    '1' when "000",
    '0' when others;

  -- If in reset mode, toggle PC once to return to top
  pc_clk <= s_pc_clk when   '0' = reset     else
            '1'      when "001" = rst_count else
            '0';

  -- Latch instruction fetch and stack outputs after rising edge of 3
  with s_count select fetch_clk <=
    '1' when "011",
    '0' when others;

  -- Latch ALU out after rising edge of 4
  with s_count select alu_clk <=
    '1' when "100",
    '0' when others;

  -- Write to IM on rising edge 5
  with s_count select im_clk <=
    '1' when "100",
    '0' when others;

  -- Push to stack on rising edge 7 to allow IM read
  with s_count select st_clk <=
    '1' when "110",
    '0' when others;

  counting_proc: process(clk)
  begin
    if(rising_edge(clk))
    then
      -- Make sure we immediately latch PC when leaving reset
      if (reset = '0' and prev_reset = '1')
      then
        r_count <= "000";
      elsif (stall = '1')
      then
        r_count <= s_count;
      else
        r_count <= s_count + to_unsigned(1, 3);
      end if;
    prev_reset <= reset;
    end if;
  end process;

end behavioral;
