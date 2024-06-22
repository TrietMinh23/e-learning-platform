"use client";
import { ConfigProvider, Input } from "antd";
import type { SearchProps } from "antd/es/input/Search";
import React from "react";

const { Search } = Input;

const onSearch: SearchProps["onSearch"] = (value, _e, info) =>
  console.log(info?.source, value);

const SearchBar: React.FC = () => (
  <ConfigProvider
    theme={{
      token: {
        colorPrimary: "#F5F7FA",
        colorPrimaryActive: "#F5F7FA",
        borderRadius: 20,
        controlHeight: 12,
        fontSize: 16,
        lineWidth: 0,
        colorBgContainer: "#F5F7FA",
      },
      components: {
        Input: {
          inputFontSizeLG: 14,
          paddingBlockLG: 10,
          paddingInlineLG: 16,
          addonBg: "#F5F7FA",
        },
      },
    }}
  >
    <Search
      placeholder="Search"
      onSearch={onSearch}
      style={{ width: "100%" }}
      enterButton
      size="large"
      id="search-bar"
    />
  </ConfigProvider>
);

export default SearchBar;
