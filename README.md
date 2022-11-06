# my qvim

这是我个人的`neovim`配置文件, **`neovim`最好是最新版本, 版本太老可能不支持**

## 依赖

该配置文件依赖一下几个工具, 需要提前安装好

1. git
2. rg(ripgrep使用)

确保`neovim`支持`python3`, 如果不支持, 执行以下命令

```shell
pip3 install pynvim
```

## 集成的功能

1. 自动补全
2. 代码调试
3. git
4. 模糊搜索
5. markdown预览
6. c/c++, rust语法高亮
7. 格式化代码
8. 浮动终端

## 安装

### 安装之前的操作

1. 安装字体

> 没有安装字体neovim也能正常工作, 但是部分地方会有乱码

部分插件需要用到`nerdfont`字体, 去[nerdfont官网](https://www.nerdfonts.com/)下载, gui中的配置中默认的字体是`SauceCodePro Nerd Font`, 如要更改，可以再`ginit.vim`中修改。

2. 安装 nvim packer插件管理系统

> Unix, Linux Installation

``` bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
> Windows Powershell Installation

``` bash
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

```

### 安装过程

运行以下命令, clone仓库到本地：

```shell
git clone https://gitee.com/degree45/vim_configuration ~/.config/nvim
```

进入`neovim`后执行

```vim
:PackerSync
```

## 已知的问题

无
