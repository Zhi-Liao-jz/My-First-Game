# 保护红魔馆

> 东方同人弹幕防御游戏 —— 操控帕秋莉·诺蕾姬，以五属性法术抵御涌来的妖精与毛玉。

## 快速启动

### 1. 克隆仓库

```bash
git clone https://github.com/Zhi-Liao-jz/My-First-Game.git
cd My-First-Game
```

### 2. 安装 Godot 引擎

本游戏基于 **Godot 4.5** 开发，请前往官网下载对应版本：

> https://godotengine.org/download/

> **注意**：请确保下载的是 **4.5 或更高版本**，低版本可能无法正确打开项目。

### 3. 打开并运行游戏

1. 打开 Godot Engine
2. 点击 **Import**，选择项目根目录下的 `project.godot` 文件
3. 进入编辑器后，按 **F5** 或点击右上角 ▶ 按钮运行游戏

### 4. 直接运行可执行文件（Windows）

如果你不想安装 Godot，可以直接运行已导出的 Windows 可执行文件：

```
Build/保护红魔馆.exe
```

---

## 游戏简介

**保护红魔馆** 是一款以《东方Project》为主题的弹幕防御游戏。玩家扮演的帕秋莉固定在画面中央，通过切换和释放五种属性法术，消灭从路径上涌来的敌人。

### 核心玩法

- **法术切换**：按数字键 `1`–`5` 激活对应属性法术
- **资源管理**：每种法术消耗对应属性的魔力，击败敌人可回收资源
- **天赋系统**：拖拽天赋卡牌到激活区域，解锁强力被动效果
- **连携施法**：同时按住多个数字键可激活组合法术

### 法术一览

| 按键 | 法术 | 属性 | 效果 |
|------|------|------|------|
| `1` | 魔法飞弹 | 银 | 基础魔法弹 |
| `2` | 火符「火神之光」 | 火 | 持续火焰射击，可解锁炸弹变体 |
| `3` | 水符「水精公主」 | 水 | 直线水弹，天赋加成后可三连发 |
| `4` | 金符「金属疲劳」 | 金 | 蓄力射击，松键后发射 |
| `5` | 木符「风灵的角笛」 | 木 | 点击发射追踪叶片 |

### 天赋一览

| 天赋名 | 效果 |
|--------|------|
| 双重施法 | 允许同时激活多种属性法术 |
| 汽油罐 | 强化火属性法术 |
| 溢泪症 | 强化水属性法术 |
| 爆炸 | 解锁火焰炸弹变体 |
| 赛钱 | 提升资源与金钱掉落 |
| 咲夜的怀表 | 时间系特殊效果 |

---

## 项目结构

```
My-First-Game/
├── scene/
│   ├── main/         # 主游戏场景（入口）
│   ├── bullet/       # 弹幕与抛射物（5 种 + 炸弹）
│   ├── skill/        # 五种法术实现
│   ├── enemy/        # 敌人类型与 AI
│   ├── component/    # 可复用组件（血量、碰撞、攻击）
│   └── GUI/          # 天赋 UI 面板
├── source/
│   ├── script/       # 全局管理器（Manage、SkillMap）
│   ├── sprite/       # 游戏美术资源
│   ├── shader/       # 视觉特效着色器
│   └── theme/        # UI 主题
├── script/           # 开发工具脚本（setup.ps1）
├── addons/           # Pixel Pen 像素画插件
└── project.godot     # Godot 项目配置
```

---

## 技术栈

| 项目 | 说明 |
|------|------|
| 引擎 | Godot 4.5，Forward Plus 渲染模式 |
| 语言 | GDScript |
| 架构 | 组件化设计 + 状态机（技能、敌人） |
| 全局管理 | `Manage`（资源/金钱/天赋）、`SkillMap`（技能映射） |
| 插件 | Pixel Pen（像素画编辑） |

---

## 开发

### 准备开发环境

执行以下命令自动安装所有开发依赖（需已安装 Python 3.8+）：

```powershell
.\script\setup.ps1
```

此脚本会自动完成：
- 安装 `gdtoolkit`（GDScript 格式检查与代码规范）
- 安装 `pre-commit`
- 注册 git hook（之后每次 `commit` 自动触发检查）

> **注意**：首次运行 PowerShell 脚本可能需要先执行：
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
> ```

### 开发规范

**每次开发必须遵循以下流程，禁止直接提交到 `master` 分支。**

#### 第一步：创建新分支

在项目根目录执行：

```powershell
.\script\new-branch.ps1
```

首次运行会要求输入姓名拼音首字母缩写（如张三丰 → `zsf`），之后自动复用。
生成的分支名格式为 `{缩写}{日期}-dev`，例如 `zsf43-dev`。

可选参数：

```powershell
.\script\new-branch.ps1 feature   # 创建 zsf43-feature 分支
.\script\new-branch.ps1 -Local    # 不切换 master，在当前分支上创建
.\script\new-branch.ps1 -Help     # 查看帮助
```

#### 第二步：提交代码

```powershell
git add <修改的文件>
git commit -m "描述本次改动"
```

> **注意**：提交时会自动触发 pre-commit 检查（GDScript 格式、代码规范、换行符等）。
> **禁止使用 `--no-verify` 跳过检查**，检查不通过必须修复后重新提交。

#### 第三步：推送并提交 PR

```powershell
git push origin <分支名>
```

推送后前往 GitHub 仓库提交 Pull Request，目标分支选择 `master`，等待 review 后合并。

---

### 代码质量

```powershell
# 手动对全部文件运行一次检查
pre-commit run --all-files
```
