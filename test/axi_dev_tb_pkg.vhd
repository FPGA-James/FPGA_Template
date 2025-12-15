library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package axi_dev_tb_pkg is

    -- TB-wide sizing constants
    constant DATA_WIDTH_C : integer := 32;
    constant ADDR_WIDTH_C : integer := 32;

    -- AXI4-Lite record type
    type axi_lite_t is record
        awaddr  : std_logic_vector(ADDR_WIDTH_C - 1 downto 0);
        awvalid : std_logic;
        awready : std_logic;
        wdata   : std_logic_vector(31 downto 0);
        wstrb   : std_logic_vector(3 downto 0);
        wvalid  : std_logic;
        wready  : std_logic;
        bresp   : std_logic_vector(1 downto 0);
        bvalid  : std_logic;
        bready  : std_logic;
        araddr  : std_logic_vector(ADDR_WIDTH_C - 1 downto 0);
        arvalid : std_logic;
        arready : std_logic;
        rdata   : std_logic_vector(31 downto 0);
        rresp   : std_logic_vector(1 downto 0);
        rvalid  : std_logic;
        rready  : std_logic;
    end record;

    -- AXI-Stream record type
    type axi_stream_t is record
        tdata  : std_logic_vector(DATA_WIDTH_C - 1 downto 0);
        tvalid : std_logic;
        tready : std_logic;
        tlast  : std_logic;
    end record;

    -- AXI-Lite write procedure (master-side)
    -- Implements AXI4-Lite AW/W/B handshakes (compliant with AXI standard)
    -- clk, rst_n : clock and active-low reset used for synchronous handshakes
    -- axi        : signal record that maps to DUT AXI-Lite ports (see test/axi_dev_tb.vhd)
    -- address    : ADDR_WIDTH_C bits
    -- data       : 32-bit write data
    -- wstrb      : optional write strobe (default all bytes valid)
    -- timeout_cycles: number of clock cycles to wait for ready/response
    procedure axi_lite_write(
        signal clk          : in  std_logic;
        signal rst_n        : in  std_logic;
        signal axi          : inout axi_lite_t;
        address             : in  std_logic_vector(ADDR_WIDTH_C - 1 downto 0);
        data                : in  std_logic_vector(31 downto 0);
        wstrb               : in  std_logic_vector(3 downto 0) := (others => '1');
        timeout_cycles      : in  natural := 1000
    );

    -- AXI-Lite read procedure (master-side)
    -- Implements AXI4-Lite AR/R handshakes (compliant with AXI standard)
    -- clk, rst_n : clock and active-low reset used for synchronous handshakes
    -- axi        : signal record that maps to DUT AXI-Lite ports (see test/axi_dev_tb.vhd)
    -- address    : ADDR_WIDTH_C bits
    -- read_data  : output 32-bit read data (signal actual passed from TB)
    -- timeout_cycles: number of clock cycles to wait for ready/response
    procedure axi_lite_read(
        signal clk          : in  std_logic;
        signal rst_n        : in  std_logic;
        signal axi          : inout axi_lite_t;
        address             : in  std_logic_vector(ADDR_WIDTH_C - 1 downto 0);
        signal read_data    : out std_logic_vector(31 downto 0);
        timeout_cycles      : in  natural := 1000
    );

end package axi_dev_tb_pkg;

package body axi_dev_tb_pkg is

    -- References:
    -- Generated register block adapter expects AXI-Lite signals:
    --   out/axi_test_reg.vhd ports: i_awvalid, o_awready, i_wvalid, o_wready, o_bvalid, i_bready, o_bresp
    --   out/axi_test_reg.vhd ports: i_arvalid, o_arready, o_rvalid, i_rready, o_rdata, o_rresp
    -- The testbench maps these to the axi_lite_t fields in axi_dev_tb.vhd.

    procedure axi_lite_write(
        signal clk          : in  std_logic;
        signal rst_n        : in  std_logic;
        signal axi          : inout axi_lite_t;
        address             : in  std_logic_vector(ADDR_WIDTH_C - 1 downto 0);
        data                : in  std_logic_vector(31 downto 0);
        wstrb               : in  std_logic_vector(3 downto 0) := (others => '1');
        timeout_cycles      : in  natural := 1000
    ) is
        variable cnt : natural := 0;
        variable aw_done : boolean := false;
        variable w_done  : boolean := false;
    begin
        -- References:
        --  - Generated register adapter: out/axi_test_reg.vhd
        --    ports used by this procedure:
        --      i_awvalid, o_awready, i_awaddr, i_wvalid, o_wready, i_wdata, i_wstrb, o_bvalid, i_bready, o_bresp
        --  - RGGen adapter code located in out/axi_test_reg.vhd and rggen_axi4lite_adapter component inside it.
        --
        -- WaveDrom: AW + W then B (write transaction)
        -- AW (address) + W (data) can be accepted in any order; B is returned later.
        --
        -- AW+W handshake (combined view):
        -- {
        --  "signal": [
        --    {"name":"AWVALID","wave":"10....1..."},
        --    {"name":"AWREADY","wave":"..1......"},
        --    {"name":"AWADDR","wave":"x......."},
        --    {"name":"WVALID","wave":"..10...1.."},
        --    {"name":"WREADY","wave":"....1...."},
        --    {"name":"WDATA","wave":"x......."},
        --    {"name":"BVALID","wave":"......10."},
        --    {"name":"BREADY","wave":"......1.."},
        --    {"name":"BRESP","wave":"......x.."}
        --  ]
        -- }
        --
        -- AW-only view:
        -- {
        --  "signal":[ {"name":"AWVALID","wave":"10.."},{"name":"AWREADY","wave":"..1."},{"name":"AWADDR","wave":"x.."} ]
        -- }
        -- W-only view:
        -- {
        --  "signal":[ {"name":"WVALID","wave":"10.."},{"name":"WREADY","wave":"..1."},{"name":"WDATA","wave":"x.."} ]
        -- }
        --
        -- B response view:
        -- {
        --  "signal":[ {"name":"BVALID","wave":"..10"},{"name":"BREADY","wave":"..1."},{"name":"BRESP","wave":"..x."} ]
        -- }
        --
        -- Note: WaveDrom snippets above are JSON fragments for inline documentation / visualization.

        -- Drive AW and W channels
        axi.awaddr  <= address;
        axi.awvalid <= '1';
        axi.wdata   <= data;
        axi.wstrb   <= wstrb;
        axi.wvalid  <= '1';
        axi.bready  <= '0';

        aw_done := false;
        w_done  := false;
        cnt := 0;

        -- Wait for AW and W acceptance (independent handshakes)
        while not (aw_done and w_done) loop
            wait until rising_edge(clk);
            if rst_n = '0' then
                report "axi_lite_write: reset asserted during AW/W handshake" severity failure;
            end if;

            -- AW handshake complete when master had AWVALID='1' and slave asserts AWREADY='1'
            if (axi.awvalid = '1' and axi.awready = '1') then
                aw_done := true;
                axi.awvalid <= '0';  -- deassert after acceptance (compliant)
            end if;

            -- W handshake complete when WVALID='1' and WREADY='1'
            if (axi.wvalid = '1' and axi.wready = '1') then
                w_done := true;
                axi.wvalid <= '0';   -- deassert after acceptance (compliant)
            end if;

            cnt := cnt + 1;
            if cnt > timeout_cycles then
                report "axi_lite_write: timeout waiting for AW/W ready" severity error;
                -- best-effort cleanup
                axi.awvalid <= '0';
                axi.wvalid  <= '0';
                return;
            end if;
        end loop;

        -- Both address and data accepted. Now wait for write response on B channel.
        cnt := 0;
        axi.bready <= '1'; -- master ready to accept response

        while axi.bvalid /= '1' loop
            wait until rising_edge(clk);
            if rst_n = '0' then
                report "axi_lite_write: reset asserted waiting for BVALID" severity failure;
            end if;
            cnt := cnt + 1;
            if cnt > timeout_cycles then
                report "axi_lite_write: timeout waiting for BVALID" severity error;
                axi.bready <= '0';
                return;
            end if;
        end loop;

        -- Accept response for one clock cycle
        wait until rising_edge(clk);

        -- Check response (00 = OKAY)
        if axi.bresp /= "00" then
            report "axi_lite_write: write response not OKAY (bresp=" & axi.bresp & ")" severity warning;
        end if;

        -- Tidy up signals
        axi.bready <= '0';
        axi.awaddr <= (others => '0');
        axi.wdata  <= (others => '0');
        axi.wstrb  <= (others => '0');
    end procedure axi_lite_write;

    -- AXI-Lite read procedure implementation (master-side)
    procedure axi_lite_read(
        signal clk          : in  std_logic;
        signal rst_n        : in  std_logic;
        signal axi          : inout axi_lite_t;
        address             : in  std_logic_vector(ADDR_WIDTH_C - 1 downto 0);
        signal read_data    : out std_logic_vector(31 downto 0);
        timeout_cycles      : in  natural := 1000
    ) is
        variable cnt : natural := 0;
        variable ar_done : boolean := false;
    begin
        -- References:
        --  - Generated register adapter: out/axi_test_reg.vhd
        --    ports used by this procedure:
        --      i_arvalid, o_arready, o_rvalid, i_rready, o_rdata, o_rresp
        --  - RGGen adapter and rggen_axi4lite_adapter implement the slave behaviour.
        --
        -- WaveDrom: AR then R (read transaction)
        -- AR (address) issued by master; slave returns R (data + resp).
        --
        -- AR+R handshake view:
        -- {
        --  "signal": [
        --    {"name":"ARVALID","wave":"10...."},
        --    {"name":"ARREADY","wave":"..1..."},
        --    {"name":"ARADDR","wave":"x....."},
        --    {"name":"RVALID","wave":"....10"},
        --    {"name":"RREADY","wave":"....1."},
        --    {"name":"RDATA","wave":"....x."},
        --    {"name":"RRESP","wave":"....x."}
        --  ]
        -- }
        --
        -- Note: WaveDrom JSON above is a small fragment for documentation/visualization.

        -- Drive AR channel
        axi.araddr  <= address;
        axi.arvalid <= '1';

        ar_done := false;
        cnt := 0;

        -- Wait for AR acceptance
        while not ar_done loop
            wait until rising_edge(clk);
            if rst_n = '0' then
                report "axi_lite_read: reset asserted during AR handshake" severity failure;
            end if;

            if (axi.arvalid = '1' and axi.arready = '1') then
                ar_done := true;
                axi.arvalid <= '0';  -- deassert ARVALID after acceptance (compliant)
            end if;

            cnt := cnt + 1;
            if cnt > timeout_cycles then
                report "axi_lite_read: timeout waiting for ARREADY" severity error;
                axi.arvalid <= '0';
                return;
            end if;
        end loop;

        -- Now request read data: assert RREADY and wait for RVALID
        cnt := 0;
        axi.rready <= '1';

        while axi.rvalid /= '1' loop
            wait until rising_edge(clk);
            if rst_n = '0' then
                report "axi_lite_read: reset asserted waiting for RVALID" severity failure;
            end if;
            cnt := cnt + 1;
            if cnt > timeout_cycles then
                report "axi_lite_read: timeout waiting for RVALID" severity error;
                axi.rready <= '0';
                return;
            end if;
        end loop;

        -- On handshake (RVALID && RREADY) capture data
        wait until rising_edge(clk);
        read_data <= axi.rdata;

        -- Check response (00 = OKAY)
        if axi.rresp /= "00" then
            report "axi_lite_read: read response not OKAY (rresp=" & axi.rresp & ")" severity warning;
        end if;

        -- Tidy up
        axi.rready <= '0';
        axi.araddr <= (others => '0');
    end procedure axi_lite_read;

end package body axi_dev_tb_pkg;