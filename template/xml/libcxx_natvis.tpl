;; xml
<?xml version="1.0" encoding="utf-8"?>
<AutoVisualizer xmlns="http://schemas.microsoft.com/vstudio/debugger/natvis/2010">
  <Type Name="std::__1::string">
    <AlternativeType Name="std::__1::basic_string&lt;char,*&gt;" />
    <DisplayString>{(char*)(__r_.__value_.__l.__data_)}</DisplayString>
    <Expand>
      <Item Name="[string]">(char*)(__r_.__value_.__l.__data_)</Item>
      <Item Name="[size]">__r_.__value_.__l.__size_</Item>
    </Expand>
  </Type>
  <Type Name="std::__1::vector&lt;*&gt;">
    <DisplayString>{{size={__end_ - __begin_}}}</DisplayString>
    <Expand>
      <Item Name="[size]" ExcludeView="simple">__end_ - __begin_</Item>
      <Item Name="[capacity]" ExcludeView="simple">__end_cap_.__value_ - __begin_</Item>
      <Item Name="[allocator]" ExcludeView="simple">__end_cap_</Item>
      <ArrayItems>
        <Size>__end_ - __begin_</Size>
        <ValuePointer>__begin_</ValuePointer>
      </ArrayItems>
    </Expand>
  </Type>
</AutoVisualizer>

