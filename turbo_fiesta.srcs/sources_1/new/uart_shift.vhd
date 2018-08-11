library IEEE;
library xil_defaultlib;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use xil_defaultlib.array2D.ALL;

entity uart_shift is
    generic( LOGN : integer := 10;
                N : integer := 1024);
    Port ( clk   : in STD_LOGIC; -- Fast clock (for shifting and timing)
           w_clk : in STD_LOGIC; -- Shared with IM write-back clock
           data  : in STD_LOGIC_VECTOR (7 downto 0);
           w_en  : in STD_LOGIC;
           uart  : out STD_LOGIC);
end uart_shift;

architecture Behavioral of uart_shift is

COMPONENT uart_clk_div
  PORT (
    CLK : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT uart_bit_ctr
  PORT (
    CLK : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT;

COMPONENT shift_single
  port(
    clk      : in  std_logic;
    w_en_nxt : in  std_logic;
    Q_prev   : in  std_logic_vector(7 downto 0);
    w_en     : out std_logic;
    Q        : out std_logic_vector(7 downto 0)
  );
END COMPONENT;

signal send     : std_logic;
--------------------------------------------------------------------------------
--                  Signals for input                                         --
--------------------------------------------------------------------------------
signal r_prev_w_clk : std_logic := '0'; -- For only writing to UART register once
signal r_Q_first    : std_logic_vector(7 downto 0) := x"00"; -- first reg in fifo

--------------------------------------------------------------------------------
--                  Signals for the shift register                            --
--------------------------------------------------------------------------------
signal s_Q    : array8_bit(N-1 downto 0);
signal s_w_en : std_logic_vector(N downto 0);

--------------------------------------------------------------------------------
--                  Signals for serializer storage register                   --
--------------------------------------------------------------------------------
signal s_Q_f  : std_logic_vector(7 downto 0);
signal r_Q_f  : std_logic_vector(7 downto 0) := x"00";

--------------------------------------------------------------------------------
--                  Signals for the UART serializataion                       --
--------------------------------------------------------------------------------
signal r_uart     : std_logic := '1'; -- UART output register
signal baud_clk   : std_logic; -- Clock at 115200 Hz
signal byte_clk   : std_logic; -- Oscillates at byte transmission rate
signal srlzr_done : std_logic; -- Hight when serializer is enabled and finished
signal r_w_en_f   : std_logic := '0'; -- High once to clear final register
signal s_srlzr_en : std_logic := '0'; -- Enable the serializer (wire)
signal r_srlzr_en : std_logic := '0'; -- Enable the serializer (register)
signal bit_count  : std_logic_vector(3 downto 0); -- index of current bit
signal s_prv_bt_n : std_logic_vector(3 downto 0) := x"0"; -- Previous bit count (wire)
signal r_prv_bt_n : std_logic_vector(3 downto 0) := x"0"; -- Previous bit count (register)

begin

--------------------------------------------------------------------------------
--                  Shift Register! (Note: Shifts bytes, not bits)            --
--------------------------------------------------------------------------------
-- Register 0
s_Q(0) <= r_Q_first;

-- Set the data ready flag

-- Write data to the first register 
-- TODO ADR Stall if queueue is full
first_reg: process(clk)
begin
  if(rising_edge(clk)) then
    -- TODO ADR work through possible cases (and stall)
    if (w_en = '1' and w_clk = '1' and r_prev_w_clk = '0') then
      r_Q_first <= data;
    else
      r_Q_first <= x"00";
    end if;
    -- Update previous write clock value
    r_prev_w_clk <= w_clk;
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

s_w_en(N)  <= r_w_en_f;
s_prv_bt_n <= r_prv_bt_n;
s_srlzr_en <= r_srlzr_en;
-- Serializer Process
srlzr: process(clk)
begin
  if (rising_edge(clk)) then
    r_w_en_f <= '0';
    r_srlzr_en <= s_srlzr_en;

    -- Bit #8
    if (bit_count = x"8") then
      -- Stop bit
      r_uart <= '1';
      -- Load new byte (if byte is sent or null)
      if (s_prv_bt_n = x"7") then
        if (s_srlzr_en = '1' or s_Q(N-1) = x"00") then
          r_w_en_f <= '1';
        end if;
      end if;

    -- Bit #9
    elsif (bit_count = x"9") then 
      -- Second stop bit
      r_uart <= '1';
      -- Enable/disable serializer
      if (s_Q(N-1) /= x"00") then
        r_srlzr_en <= '1';
      else
        r_srlzr_en <= '0';
      end if;

    -- Bit #10 === -1 mod 11
    elsif (bit_count = x"A") then
      -- Start bit, if enabled
      if (s_srlzr_en = '1') then
        r_uart <= '0';
      else
        r_uart <= '1';
      end if;

    -- Data bits #0 through #7 (when enabled)
    else
      if (s_srlzr_en = '1') then
        r_uart <= s_Q(N-1)(to_integer(unsigned(bit_count)));
      else
        r_uart <= '1';
      end if;
    end if;

    -- Update previous bit count
    r_prv_bt_n <= bit_count;
  end if;
end process srlzr;

uart <= r_uart;

bit_ctr: uart_bit_ctr
  PORT MAP (
    CLK => baud_clk,
    THRESH0 => byte_clk,
    Q => bit_count);

-- Count to 0x364 for 115200 baud UART
-- Count to 0x28B0 for 9600 baud
-- Count to 0x2fae400 for real-time debug
baud_clk_dvdr: uart_clk_div
  PORT MAP (
    CLK => clk,
    THRESH0 => baud_clk,
    Q => open);

end Behavioral;
