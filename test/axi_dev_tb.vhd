library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;
context vunit_lib.vc_context;

-- bring the record types and sizing constants into the TB
use work.axi_dev_tb_pkg.all;

entity axi_dev_tb is
    generic (
        runner_cfg : string := runner_cfg_default
    );
end entity axi_dev_tb;

architecture tb of axi_dev_tb is

    -- AXI-Lite record signal (defaulted)
    signal s_axi : axi_lite_t := (others => (others => '0'));
    -- AXI Stream record signal (defaulted)
    signal s_axis : axi_stream_t := (others => (others => '0'));

    -- Other TB signals used by DUT
    signal clk_i           : std_logic := '0';
    signal rst_n_i         : std_logic := '0';

begin

    main : process
    begin
        test_runner_setup(runner, runner_cfg);

        while test_suite loop
            if run("test_1") then
                report "Test 1";
            end if;
        end loop;

        test_runner_cleanup(runner);
    end process;

    -- simple clock process for the TB
    clk_proc : process
    begin
        wait for 5 ns;
        clk_i <= not clk_i;
    end process;

    -- Instantiate DUT, map AXI-Stream ports to record fields
    -- and AXI-Lite ports to s_axi record fields
    dut : entity work.axi_dev_top
    generic map (
        DATA_WIDTH        => DATA_WIDTH_C,
        ADDR_WIDTH        => ADDR_WIDTH_C
    )
    port map (
        clk_i             => clk_i,
        rst_n_i           => rst_n_i,
        
        -- map AXI-Stream ports to record fields
        s_axis_tdata_i    => s_axis.tdata,
        s_axis_tvalid_i   => s_axis.tvalid,
        s_axis_tready_o   => s_axis.tready,
        s_axis_tlast_i    => s_axis.tlast,
        
        -- map AXI-lite ports to record fields
        s_axi_awaddr_i    => s_axi.awaddr,
        s_axi_awvalid_i   => s_axi.awvalid,
        s_axi_awready_o   => s_axi.awready,
        s_axi_wdata_i     => s_axi.wdata,
        s_axi_wstrb_i     => s_axi.wstrb,
        s_axi_wvalid_i    => s_axi.wvalid,
        s_axi_wready_o    => s_axi.wready,
        s_axi_bresp_o     => s_axi.bresp,
        s_axi_bvalid_o    => s_axi.bvalid,
        s_axi_bready_i    => s_axi.bready,
        
        s_axi_araddr_i    => s_axi.araddr,
        s_axi_arvalid_i   => s_axi.arvalid,
        s_axi_arready_o   => s_axi.arready,
        s_axi_rdata_o     => s_axi.rdata,
        s_axi_rresp_o     => s_axi.rresp,
        s_axi_rvalid_o    => s_axi.rvalid,
        s_axi_rready_i    => s_axi.rready
    );

end architecture tb;