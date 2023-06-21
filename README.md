# my qvim

这是我个人的`neovim`配置文件, **`neovim`最好是最新版本, 版本太老可能不支持**

## 依赖

该配置文件依赖一下几个工具, 需要提前安装好

1. git
2. rg(ripgrep 使用)

确保`neovim`支持`python3`, 如果不支持, 执行以下命令

```shell
pip3 install pynvim
```

## 集成的功能

1. 自动补全
2. 代码调试
3. git
4. 模糊搜索
5. markdown 预览
6. c/c++, rust 语法高亮
7. 格式化代码
8. 浮动终端
9. xmake 编译调试

## 安装

### 安装之前的操作

1. 安装字体

> 没有安装字体 neovim 也能正常工作, 但是部分地方会有乱码

部分插件需要用到`nerdfont`字体, 去[nerdfont 官网](https://www.nerdfonts.com/)下载

### 安装过程

运行以下命令, clone 仓库到本地即可：

```shell
git clone https://gitee.com/degree45/vim_configuration ~/.config/nvim
```

## 已知的问题

无
