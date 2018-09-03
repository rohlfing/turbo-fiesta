library IEEE;
library xil_defaultlib;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use xil_defaultlib.array2D.ALL;

entity uart_in is
    generic( N : integer := 1024);
    Port ( clk        : in  std_logic; -- Fast clock (for shifting and timing)
           r_clk      : in  std_logic; -- Shared with the stack push clock
           pop_en     : in  std_logic;
           uart       : in  std_logic;
           data       : out std_logic_vector (7 downto 0);
           stall_rqst : out std_logic);
end uart_in;

architecture Behavioral of uart_in is

COMPONENT shift_single
  port(
    clk      : in  std_logic;
    w_en_nxt : in  std_logic;
    Q_prev   : in  std_logic_vector(7 downto 0);
    w_en     : out std_logic;
    Q        : out std_logic_vector(7 downto 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
--                  State machine type and signals                            --
--------------------------------------------------------------------------------
type uart_in_state is (IDLE, WAIT_T, WAIT_T_2, SAMPLE);

signal curr_state : uart_in_state := IDLE;
signal prev_state : uart_in_state := IDLE;
signal next_state : uart_in_state := IDLE;
signal sample_num : integer := 0;
signal s_sam_num  : integer;
signal incoming   : std_logic_vector(7 downto 0);
signal s_inc      : std_logic_vector(7 downto 0);

signal period      : signed(15 downto 0) := x"0363"; -- Bit period for 115200
signal half_period : signed(15 downto 0) := x"01B1"; -- Half period
signal zero        : signed(15 downto 0) := x"0000"; -- Zero
signal one         : signed(15 downto 0) := x"0001"; -- One
signal wait_count  : signed(15 downto 0) := x"0000";
signal s_wait_cnt  : signed(15 downto 0);

--------------------------------------------------------------------------------
--                  Signals for input                                         --
--------------------------------------------------------------------------------
signal r_prev_r_clk : std_logic := '0'; -- For only writing to UART register once
signal r_Q_first    : std_logic_vector(7 downto 0) := x"00"; -- first reg in fifo

--------------------------------------------------------------------------------
--                  Signals for the shift register                            --
--------------------------------------------------------------------------------
signal s_Q    : array8_bit(N-1 downto 0);
signal s_w_en : std_logic_vector(N downto 0);

begin

--------------------------------------------------------------------------------
--                  UART input state machine                                  --
--------------------------------------------------------------------------------
s_sam_num  <= sample_num;
s_wait_cnt <= wait_count;
s_inc      <= incoming;
uart_states: process(clk)
begin
  if(rising_edge(clk)) then
    incoming <= s_inc;
    case curr_state is
      -- IDLE while waiting for next incoming byte
      when IDLE     =>
        sample_num <= 0;
        -- VHDL pre-2008 doesn't support when/else in processes
        if uart = '0' then
          curr_state <= WAIT_T;
        else
          curr_state <= IDLe;
        end if;
        wait_count <= zero;
      -- Wait for one bit period between samples
      when WAIT_T   =>
        sample_num <= s_sam_num;
        if wait_count < period then
          curr_state <= WAIT_T;
          wait_count <= s_wait_cnt + one;
        elsif s_sam_num = 0 then
          curr_state <= WAIT_T_2;
          wait_count <= zero;
        elsif s_sam_num = 8 then
          curr_state <= IDLE;
          wait_count <= zero;
        else
          curr_state <= SAMPLE;
          wait_count <= zero;
        end if;
      -- Wait for half a bit period to sample bit 0
      when WAIT_T_2 =>
        sample_num <= 0;
        if wait_count < half_period then
          curr_state <= WAIT_T_2;
        else
          curr_state <= SAMPLE;
        end if;
        wait_count <= s_wait_cnt + one;
        incoming   <= x"00";
      -- Sapmle the UART input once and assume it's good
      when SAMPLE   =>
        sample_num <= s_sam_num + 1;
        wait_count <= x"0000";
        curr_state <= WAIT_T;
        incoming(s_sam_num) <= uart;
    end case;

    prev_state <= curr_state;
    --curr_state <= next_state;
  end if;
end process uart_states;

-- Pop data from the last register
last_reg: process(clk)
begin
  if(rising_edge(clk)) then
    if (pop_en = '1' and r_clk = '1' and r_prev_r_clk = '0') then
      s_w_en(N) <= '1';
    else
      s_w_en(N) <= '0';
    end if;
    -- Update previous read clock value
    r_prev_r_clk <= r_clk;
  end if;
end process last_reg;

data <= s_Q(N-1);
stall_rqst <= '1' when s_Q(N-1) = x"00" else '0';

--------------------------------------------------------------------------------
--                  Shift Register! (Note: Shifts bytes, not bits)            --
--------------------------------------------------------------------------------
-- Register 0
s_Q(0)     <= r_Q_first;

-- Write data to the first register when re-entering idle state
first_reg: process(clk)
begin
  if(rising_edge(clk)) then
    if (curr_state = IDLE and prev_state = WAIT_T) then
      r_Q_first <= s_inc;
    else
      r_Q_first <= x"00";
    end if;
  end if;
end process first_reg;

-- Registers 1 through N-1
gen_shift_reg:
for i in 1 to N-1 generate
  single_reg: shift_single
    port map (
      clk      => clk,
      w_en_nxt => s_w_en(i+1),
      Q_prev   => s_Q(i-1),
      w_en     => s_w_en(i),
      Q        => s_Q(i));
end generate;

end Behavioral;
