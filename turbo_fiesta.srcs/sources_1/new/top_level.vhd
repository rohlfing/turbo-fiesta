library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    -- Wait for 2/3 second to debounce and verify reset
    generic (cntdwn_max : unsigned(31 downto 0) := x"0000000A"; --:= x"04000000"; --
             cntdwn_min : unsigned(31 downto 0) := x"00000000");
    port (CLK100MHZ     : in  std_logic;
          reset_in      : in  std_logic;
          uart_rxd_out  : out std_logic;
          uart_dbg_out  : out std_logic;
          inst_dbg_out  : out std_logic_vector(7 downto 0);
          led           : out std_logic_vector(3 downto 0));
end top_level;

architecture Behavioral of top_level is

--------------------------------------------------------------------------------
-- Clocking Components
--------------------------------------------------------------------------------
component clk_control
  port(clk       : in  std_logic; -- Clock
       reset     : in  std_logic; -- Reset pin
       pc_clk    : out std_logic; -- Clock to latch PC output
       fetch_clk : out std_logic; -- Clock for instruction fetch
       alu_clk   : out std_logic; -- Clock for ALU computation
       im_clk    : out std_logic; -- Clock to enable instruction mem write
       st_clk    : out std_logic);-- Clock to enable stack push
end component;

--------------------------------------------------------------------------------
-- Logic Components
--------------------------------------------------------------------------------
component pc
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
end component;

COMPONENT im_blk_mem_gen_0
  PORT (
    clka  : IN STD_LOGIC;
    ena   : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb  : IN STD_LOGIC;
    enb   : IN STD_LOGIC;
    web   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dinb  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

component stack
  port(clk       : in  std_logic; -- Clock
       w_enable  : in  std_logic; -- Write enable (high for only one clock cycle)
       alu_flags : in  std_logic_vector(15 downto 0); -- Flags from ALU (bitfield in alu_ex.vhd)
       w_bot     : in    signed(31 downto 0);  -- Data to write onto stack
       w_top     : in    signed(31 downto 0);  -- Data to write higher onto stack (optional)
       prev_sp   : in  unsigned(15 downto 0);
       curr_sp   : out unsigned(15 downto 0);
       top       : out   signed(31 downto 0);  -- Data on top of stack
       mid       : out   signed(31 downto 0);  -- Data 1 below top value
       bot       : out   signed(31 downto 0)); -- Data 2 below top value
end component;

component alu_ex
    port (inst      : in  std_logic_vector(7 downto 0);
          strmode   : in  std_logic;
          bot       : in  signed(31 downto 0);
          mid       : in  signed(31 downto 0);
          top       : in  signed(31 downto 0);
          stdin     : in  signed(31 downto 0);
          alu_flags : out std_logic_vector(15 downto 0);
          restop    : out signed(31 downto 0);
          resbot    : out signed(31 downto 0);
          im_addr   : out std_logic_vector(10 downto 0));
end component;

component uart_shift
    generic( LOGN : integer := 8;
                N : integer := 256);
    port ( clk   : in STD_LOGIC;
           w_clk : in STD_LOGIC;
           data  : in STD_LOGIC_VECTOR (7 downto 0);
           w_en  : in STD_LOGIC;
           uart  : out STD_LOGIC);
end component;

--------------------------------------------------------------------------------
-- Register Components
--------------------------------------------------------------------------------
component reg_pc 
  port ( clk     : in  std_logic;
         reset   : in  std_logic;
         -- Register inputs
         i_state : in  std_logic_vector (19 downto 0);
         i_addr  : in  std_logic_vector (10 downto 0);
         i_flags : in  std_logic_vector (15 downto 0);
         i_sp    : in  std_logic_vector (15 downto 0);
         -- Register outputs
         o_state : out std_logic_vector (19 downto 0);
         o_addr  : out std_logic_vector (10 downto 0);
         o_flags : out std_logic_vector (15 downto 0);
         o_sp    : out std_logic_vector (15 downto 0));
end component;

component reg_fetch
  port ( clk       : in  std_logic;
         reset     : in  std_logic;
         -- Register inputs
         i_state   : in  std_logic_vector (19 downto 0);
         i_inst    : in  std_logic_vector ( 7 downto 0);
         i_top     : in  std_logic_vector (31 downto 0);
         i_mid     : in  std_logic_vector (31 downto 0);
         i_bot     : in  std_logic_vector (31 downto 0);
         i_flags   : in  std_logic_vector (15 downto 0);
         i_sp      : in  std_logic_vector (15 downto 0);
         -- Register outputs
         o_state   : out std_logic_vector (19 downto 0);
         o_inst    : out std_logic_vector ( 7 downto 0);
         o_top     : out std_logic_vector (31 downto 0);
         o_mid     : out std_logic_vector (31 downto 0);
         o_bot     : out std_logic_vector (31 downto 0);
         o_flags   : out std_logic_vector (15 downto 0);
         o_sp      : out std_logic_vector (15 downto 0));
end component;

component reg_alu
  port ( clk       : in  std_logic;
         reset     : in  std_logic;
         -- Register inputs
         i_state   : in  std_logic_vector (19 downto 0);
         i_flags   : in  std_logic_vector (15 downto 0);
         i_restop  : in  std_logic_vector (31 downto 0);
         i_resbot  : in  std_logic_vector (31 downto 0);
         i_im_addr : in  std_logic_vector (10 downto 0);
         i_sp      : in  std_logic_vector (15 downto 0);
         -- Register outputs
         o_state   : out std_logic_vector (19 downto 0);
         o_flags   : out std_logic_vector (15 downto 0);
         o_restop  : out std_logic_vector (31 downto 0);
         o_resbot  : out std_logic_vector (31 downto 0);
         o_im_addr : out std_logic_vector (10 downto 0);
         o_sp      : out std_logic_vector (15 downto 0));
end component;
--------------------------------------------------------------------------------
-- Signals (TODO ADR remove unused)
--------------------------------------------------------------------------------
signal s_stall   : std_logic := '0'; 
signal s_reset   : std_logic := '0';
signal r_cntdwn  : unsigned(31 downto 0) := x"00000000";
signal s_cntdwn  : unsigned(31 downto 0);

signal uart_tmp_out : std_logic := '0';

-- Clock Signals
signal s_pc_clk    : std_logic;
signal s_fetch_clk : std_logic;
signal s_alu_clk   : std_logic;
signal s_im_clk    : std_logic;
signal s_st_clk    : std_logic;

-- IM input signals
signal s_web     : std_logic_vector(0 downto 0);
-- IM output signals
signal s_get     : std_logic_vector(7 downto 0);

-- Stack input signals
signal s_botval  : signed(31 downto 0);

-- Register/stage input signals
-- PC Reg
signal pc_prev_state : std_logic_vector(19 downto 0);
signal pc_curr_state :           signed(19 downto 0);
signal pc_curr_addr  : std_logic_vector(10 downto 0);
signal pc_flags      : std_logic_vector(15 downto 0);
signal pc_sp         : std_logic_vector(15 downto 0);
-- Fetch Reg
signal fetch_state       : std_logic_vector(19 downto 0);
signal fetch_prev_addr   : std_logic_vector(10 downto 0);
signal fetch_curr_inst   : std_logic_vector( 7 downto 0);
signal fetch_curr_top    :           signed(31 downto 0);
signal fetch_curr_mid    :           signed(31 downto 0);
signal fetch_curr_bot    :           signed(31 downto 0);
signal fetch_flags       : std_logic_vector(15 downto 0);
signal fetch_curr_sp     :         unsigned(15 downto 0);
-- ALU Reg
signal alu_state        : std_logic_vector(19 downto 0);
signal alu_prev_inst    : std_logic_vector( 7 downto 0);
signal alu_prev_top     : std_logic_vector(31 downto 0);
signal alu_prev_mid     : std_logic_vector(31 downto 0);
signal alu_prev_bot     : std_logic_vector(31 downto 0);
signal alu_prev_flags   : std_logic_vector(15 downto 0);
signal alu_curr_flags   : std_logic_vector(15 downto 0);
signal alu_curr_restop  :           signed(31 downto 0);
signal alu_curr_resbot  :           signed(31 downto 0);
signal alu_curr_im_addr : std_logic_vector(10 downto 0);
signal alu_sp           : std_logic_vector(15 downto 0);
-- Write-back stage
signal wb_im_addr     : std_logic_vector(10 downto 0);
signal wb_flags       : std_logic_vector(15 downto 0);
signal wb_prev_sp     : std_logic_vector(15 downto 0);
signal wb_prev_restop : std_logic_vector(31 downto 0);
signal wb_prev_resbot : std_logic_vector(31 downto 0);

begin

-- UART outputs
uart_dbg_out <= '0'; --uart_tmp_out;
uart_rxd_out <= uart_tmp_out;

-- LED defs
led(3) <= '0'; -- uart_tmp_out;
led(2) <= '0';
led(1) <= '0';
led(0) <= s_reset;

-- Force instruction memory output to compile (PMOD JB)
inst_dbg_out <= x"00";

-- Reset countdown
s_cntdwn <= r_cntdwn;
s_reset  <= '0' when s_cntdwn = cntdwn_min else '1';
reset_cntdwn: process(CLK100MHZ)
begin
  if (rising_edge(CLK100MHZ)) then
    -- Reset timer when button is pressed
    if (reset_in = '1') then
      r_cntdwn <= cntdwn_max;
    -- Count down to debounce reset button
    elsif (s_cntdwn /= cntdwn_min) then
      r_cntdwn <= s_cntdwn - to_unsigned(1, 32);
    -- Hold at min when reset is not asserted
    else
      r_cntdwn <= cntdwn_min;
    end if;
  end if;
end process reset_cntdwn;

-- Clock signal generator
clk_impl: clk_control
  port map(clk       => CLK100MHZ,
           reset     => s_reset,
           pc_clk    => s_pc_clk,
           fetch_clk => s_fetch_clk,
           alu_clk   => s_alu_clk,
           im_clk    => s_im_clk,
           st_clk    => s_st_clk);

-- Program Counter
pc_impl: pc
  port map(prev_PC_x => signed(pc_prev_state( 7 downto  0)),
           prev_PC_y => signed(pc_prev_state(15 downto  8)),
           prev_dx   => signed(pc_prev_state(17 downto 16)),
           prev_dy   => signed(pc_prev_state(19 downto 18)),
           alu_flags => pc_flags,
           next_PC_x => pc_curr_state( 7 downto  0),
           next_PC_y => pc_curr_state(15 downto  8),
           next_dx   => pc_curr_state(17 downto 16),
           next_dy   => pc_curr_state(19 downto 18),
           o_addr    => pc_curr_addr);
           
-- Instruction Memory
s_web(0) <= s_im_clk and pc_flags(1); -- Enable write when correct cycle on 'p' instruction
im_impl : im_blk_mem_gen_0
  PORT MAP (
    clka  => CLK100MHZ,
    ena   => '1',
    wea   => "0",
    addra => fetch_prev_addr(10 downto 0),
    dina  => x"00",
    douta => fetch_curr_inst,
    clkb  => CLK100MHZ,
    enb   => '1',
    web   => s_web,
    addrb => wb_im_addr,
    dinb  => std_logic_vector(wb_prev_resbot(7 downto 0)),
    doutb => s_get);

-- Stack Memory
s_botval <= signed(x"000000" & s_get) when (wb_flags(5) = '1') else signed(alu_curr_resbot);--wb_prev_resbot);
stack_impl: stack
  port map(clk       => CLK100MHZ,
           w_enable  => s_st_clk,
           alu_flags => wb_flags,
           w_bot     => s_botval,
           w_top     => signed(wb_prev_restop),
           prev_sp   => unsigned(wb_prev_sp),
           curr_sp   => fetch_curr_sp,
           top       => fetch_curr_top,
           mid       => fetch_curr_mid,
           bot       => fetch_curr_bot);

-- ALU and instruction execution
alu_impl: alu_ex
    port map (inst      => alu_prev_inst,
              strmode   => alu_prev_flags(4),
              bot       => signed(alu_prev_bot),
              mid       => signed(alu_prev_mid),
              top       => signed(alu_prev_top),
              stdin     => x"00000000", -- TODO ADR stdin?
              alu_flags => alu_curr_flags,
              restop    => alu_curr_restop,
              resbot    => alu_curr_resbot,
              im_addr   => alu_curr_im_addr);

output_buff: uart_shift
    generic map(N  => 1024)
    port map(clk   => CLK100MHZ,
             w_clk => s_st_clk,
             data  => wb_prev_resbot(7 downto 0),
             w_en  => alu_curr_flags(3),
             uart  => uart_tmp_out);

--------------------------------------------------------------------------------
-- Register Implementations
--------------------------------------------------------------------------------
reg_pc_impl: reg_pc 
  port map (clk     => s_pc_clk,
            reset   => s_reset,
            -- Register inputs
            i_state => std_logic_vector(pc_curr_state),
            i_addr  => std_logic_vector(pc_curr_addr),
            i_flags => pc_flags,
            i_sp    => pc_sp,
            -- Register outputs
            o_state => fetch_state,
            o_addr  => fetch_prev_addr,
            o_flags => fetch_flags,
            o_sp    => open);

reg_fetch_impl: reg_fetch
  port map (clk     => s_fetch_clk,
            reset   => s_reset,
            -- Register inputs
            i_state => fetch_state,
            i_inst  => fetch_curr_inst,
            i_top   => std_logic_vector(fetch_curr_top),
            i_mid   => std_logic_vector(fetch_curr_mid),
            i_bot   => std_logic_vector(fetch_curr_bot),
            i_flags => fetch_flags,
            i_sp    => std_logic_vector(fetch_curr_sp),
            -- Register outputs
            o_state => alu_state,
            o_inst  => alu_prev_inst,
            o_top   => alu_prev_top,
            o_mid   => alu_prev_mid,
            o_bot   => alu_prev_bot,
            o_flags => alu_prev_flags,
            o_sp    => alu_sp);

reg_alu_impl: reg_alu
  port map (clk       => s_alu_clk,
            reset     => s_reset,
            -- Register inputs
            i_state   => alu_state,
            i_flags   => alu_curr_flags,
            i_restop  => std_logic_vector(alu_curr_restop),
            i_resbot  => std_logic_vector(alu_curr_resbot),
            i_im_addr => alu_curr_im_addr,
            i_sp      => alu_sp,
            -- Register outputs
            o_state   => pc_prev_state,
            o_flags   => pc_flags,
            o_restop  => wb_prev_restop,
            o_resbot  => wb_prev_resbot,
            o_im_addr => wb_im_addr,
            o_sp      => wb_prev_sp);
  -- ALU outputs flags to both PC and write-back
  wb_flags <= pc_flags;

end Behavioral;