## axi_test_reg

* byte_size
    * 256
* bus_width
    * 32

|name|offset_address|
|:--|:--|
|[register_0](#axi_test_reg-register_0)|0x00|
|[register_1](#axi_test_reg-register_1)|0x04|
|[register_2](#axi_test_reg-register_2)|0x08|

### <div id="axi_test_reg-register_0"></div>register_0

* offset_address
    * 0x00
* type
    * default

|name|bit_assignments|type|initial_value|reference|labels|comment|
|:--|:--|:--|:--|:--|:--|:--|
|bit_field_0|[3:0]|rw|0x0|||this is register_0.bit_field_0|
|bit_field_1|[7:4]|rw|0x0||||
|bit_field_2|[8]|rw|0x0||||
|bit_field_3|[10:9]|w1|0x0||||
|bit_field_4|[12:11]|wrc|0x0||||
|bit_field_5|[14:13]|wrs|0x0||||
|bit_field_6|[16:15]|rowo|0x0||||

### <div id="axi_test_reg-register_1"></div>register_1

* offset_address
    * 0x04
* type
    * default

|name|bit_assignments|type|initial_value|reference|labels|comment|
|:--|:--|:--|:--|:--|:--|:--|
|register_1|[0]|rw|0x0||name: foo value: 0 comment: FOO value<br>name: bar value: 1 comment: BAR value||

### <div id="axi_test_reg-register_2"></div>register_2

* offset_address
    * 0x08
* type
    * default

|name|bit_assignments|type|initial_value|reference|labels|comment|
|:--|:--|:--|:--|:--|:--|:--|
|bit_field_0|[3:0]|ro|||||
|bit_field_1|[15:8]|rof|0xab||||
|bit_field_2|[19:16]|rohw|0x0||||
