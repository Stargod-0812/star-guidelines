<div align="center">

# Star Guidelines

**编码 Agent 的执行层操作系统。**

七条不可违背的规则。一个 IDE 一个原生适配器。跨 Cursor / Claude Code / Codex / WorkBuddy 零漂移。

[![Stars](https://img.shields.io/github/stars/Stargod-0812/star-guidelines?style=flat-square&logo=github&label=stars&color=111)](https://github.com/Stargod-0812/star-guidelines/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Stargod-0812/star-guidelines?style=flat-square&color=111)](https://github.com/Stargod-0812/star-guidelines/commits/main)
[![Adapters](https://img.shields.io/badge/adapters-4%20native-111?style=flat-square)](#适配器路由)
[![Contract](https://img.shields.io/badge/contract-7%20rules-111?style=flat-square)](#star-契约)
[![Version](https://img.shields.io/badge/v2.0.0-111?style=flat-square)](./CHANGELOG.md)
[![English](https://img.shields.io/badge/English-111?style=flat-square)](./README.en.md)

</div>

---

> **TL;DR** — Frontier 编码 agent 的翻车不在模型智力，在执行纪律。Star Guidelines 是一份可安装、可验证、跨 IDE 同步的执行契约——装上就生效，问一句就确认。

---

## 为什么需要这个

编码 agent 的六种系统性失控，每一种都不是模型能力问题：

| 失控模式 | 根因 | 实际代价 |
| --- | --- | --- |
| 请求模糊时自作主张选方向 | 缺少 clarification gate | 回滚成本 ×2，信任损耗 |
| 顺手动了任务边界外的代码 | 缺少 scope constraint | PR diff 膨胀，review 成本指数上升 |
| 一个 caller 就堆三层抽象 | 缺少 simplicity bias | 技术债提前到账 |
| 覆盖用户未提交的改动 | 缺少 ownership boundary | 丢工作，最高级别信任事故 |
| 没跑任何验证就报 "Done" | 缺少 evidence requirement | 虚假完成 → 线上 incident |
| 在 Cursor 里加载了 Claude 的规则 | 缺少 adapter isolation | 规则互相抵消 = 等于裸奔 |

更好的模型不会修复这些。一份带强制力的执行契约才会。

---

## Star 契约（The Seven Rules）

规范源：[`core/CONTRACT.md`](./core/CONTRACT.md)。每个适配器都是这七条规则在目标 IDE 原生 loader 中的投影。

| # | 规则 | 触发条件 | Agent 行为 |
| --- | --- | --- | --- |
| 1 | **先澄清，再编辑** | 歧义涉及文件 / API / 数据 / 安全 / 可见行为 | 陈述假设，问清再动 |
| 2 | **先阅读，再设计** | 任何非 trivial 改动 | 先读 owning module、tests、docs、conventions |
| 3 | **保持改动狭窄** | 每次编辑 | 只碰请求所需的文件，不顺手重构 |
| 4 | **优先当前最简方案** | 想加抽象/配置层/策略模式时 | 没有 >1 个真实 caller，不引入新层 |
| 5 | **保护用户工作** | 存在未提交改动 | 默认属于用户；无明确指令不动 |
| 6 | **用具体证据验证** | 任务完成前 | 跑最小有用 test/build/lint/screenshot/repro |
| 7 | **简短说明权衡** | 存在有意义的风险或替代方案 | 一两句话点明，不把日常工作变 ceremony |

> 契约强度随风险线性上升。typo fix 保持极轻量；跨模块重构必须有 plan + evidence + risk report。

---

## 执行循环

七条规则约束的是 **什么不能做**。执行循环定义的是 **怎么做**：

```text
┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐
│  Orient │ ──▶ │  Scope  │ ──▶ │  Edit   │ ──▶ │ Verify  │ ──▶ │ Report  │
└─────────┘     └─────────┘     └─────────┘     └─────────┘     └─────────┘
 读 owning       陈述影响         触碰最小         跑最小有用       报告改动面
 files/tests/    实现的假设       文件集           检查 + 证据      + 证据 + 风险
 docs/conventions
```

五步。每步都有退出条件。没有 ceremony。

**规则 vs 循环的关系**：循环是操作路径，规则是每一步的 guardrail。Orient 阶段受 Rule 2 约束，Edit 阶段受 Rule 3/4/5 约束，Verify 阶段受 Rule 6 约束。

---

## 适配器架构

Star Guidelines 的核心设计决策：**每个 IDE 用自己的原生格式加载规则，而不是一个万能文件碰运气。**

```text
                    ┌────────────────────────────┐
                    │     core/CONTRACT.md       │   ← single source of truth
                    │       7 条 Star 规则        │
                    └─────────────┬──────────────┘
                                  │
        ┌──────────────┬──────────┴──────────┬──────────────┐
        │              │                     │              │
     Cursor       Claude Code              Codex        WorkBuddy
     ──────       ───────────              ─────        ─────────
   .cursor/rules   CLAUDE.md             AGENTS.md      WORKBUDDY.md
   .cursor/skills  .claude-plugin/       skills/        (project direction)
```

### 适配器入口表

| 运行环境 | 主适配器 | 可选搭配 | 握手应答 |
| --- | --- | --- | --- |
| Cursor 项目规则 | `.cursor/rules/star-guidelines.mdc` | `.cursor/skills/…/SKILL.md` | `Cursor rule loaded` |
| Cursor 项目 skill | `.cursor/skills/star-guidelines/SKILL.md` | `.cursor/rules/…` | `Cursor skill loaded` |
| Codex / AGENTS IDE | `AGENTS.md` | `skills/star-guidelines/SKILL.md` | `AGENTS rules loaded` |
| Codex skill runner | `skills/star-guidelines/SKILL.md` | `agents/openai.yaml` | `skill loaded` |
| Claude Code 项目 | `CLAUDE.md` | — | `Claude project rules loaded` |
| Claude plugin 环境 | `.claude-plugin/` | — | `bundled skill loaded` |
| WorkBuddy 长任务 | `WORKBUDDY.md` | project task context | `WorkBuddy direction loaded` |

> **关键原则**：不要把所有适配器装进同一个项目。每个文件针对特定 loader 设计。已有规则的项目，把对应适配器**合并**进现有规则文件。

---

## 快速安装

> [!TIP]
> 每个命令都是幂等的。重复执行会覆盖旧版本，不会产生冲突。

### Cursor（推荐：always-on rule）

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/rules
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" \
  -o .cursor/rules/star-guidelines.mdc
```

<details>
<summary>附加：Cursor 项目 skill（可选，更详细的 workflow 指导）</summary>

```bash
mkdir -p .cursor/skills/star-guidelines
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" \
  -o .cursor/skills/star-guidelines/SKILL.md
```

</details>

### Claude Code

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/CLAUDE.md" -o CLAUDE.star-guidelines.md
```

合并进项目 `CLAUDE.md`。Plugin 环境可直接 bundle：

<details>
<summary>Plugin 包安装</summary>

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
cp -R star-guidelines/.claude-plugin /path/to/target/star-guidelines
```

</details>

### Codex

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/AGENTS.md" -o AGENTS.star-guidelines.md
```

合并进 `AGENTS.md`。全局 skill 安装：

<details>
<summary>全局 skill 安装</summary>

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
mkdir -p ~/.codex/skills
cp -R star-guidelines/skills/star-guidelines ~/.codex/skills/
```

</details>

### WorkBuddy

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/WORKBUDDY.md" -o WORKBUDDY.star-guidelines.md
```

合并进 WorkBuddy 项目级 direction 区域。适用于长流程、跨会话交接、MCP 密集任务。

---

## 验证握手

安装完不代表生效。**用握手确认**：

```text
is star-guidelines active?
```

| IDE | 正确响应应包含 |
| --- | --- |
| Cursor | `Cursor rule loaded` 或 `Cursor skill loaded` |
| Codex | `AGENTS.md` 或 `$star-guidelines` |
| Claude Code | 七条工作契约的描述 |
| WorkBuddy | 项目边界 + 记忆检查 + consent + 证据 + 可交接状态 |

**诊断**：如果响应里提到了错误的适配器（比如在 Cursor 里说"Claude project rules"），说明存在规则冲突。删掉不属于当前 IDE 的规则文件即可。

---

## 对比：有 Star Guidelines vs 没有

### 场景一：Bug 修复 —— 缺失到期日让提醒崩溃

**无 Star（典型 agent drift）**：

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ customer.setdefault("timezone", "UTC")
+ customer.setdefault("notification_channel", "email")
+ if customer.get("status") == "trial":
+     return None
+ if not customer.get("due_date"):
+     return datetime.now(timezone.utc) + timedelta(days=7)
+ reminder_at = customer["due_date"] - timedelta(days=3)
```

一个 null check 变成了 notification policy + trial handling + fallback scheduling。未经讨论。没有 test。

**有 Star（Rule 3 + Rule 6 生效）**：

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ due_date = customer.get("due_date")
+ if due_date is None:
+     return None
+ reminder_at = due_date - timedelta(days=3)
```

只修崩溃边界。如果产品想要 fallback scheduling，那是另一个 request。

### 场景二：Feature request —— 失败 webhook 手动重试按钮

**无 Star**：

```text
我来构建一个 webhook 运维控制台：retry 策略配置、审计流、
实时状态、Slack 通知集成。
```

**有 Star（Rule 1 + Rule 4 生效）**：

```text
1. 定位现有 webhook 失败模型和 retry 路径。验证：读 service + tests。
2. 加一个 UI action 调用已有 retry path。验证：route test。
3. 跑 webhook 相关测试，报告跳过的检查。
```

功能边界锁在 "一个按钮调用已有路径"，不是 "建一个运维平台"。

### 场景三：完成报告

**无 Star**：

```text
Done.
```

**有 Star（Rule 6 + Rule 7 生效）**：

```text
改了 src/webhooks/retry.ts 和 src/webhooks/retry.test.ts。
验证：npm test -- webhooks/retry.test.ts (passed)。
完整套件未跑。
剩余风险：provider-specific retry throttling 未覆盖。
```

reviewer 能精确看到：改动面、通过了什么、跳过了什么、还剩什么风险。

> 更多场景见 [`EXAMPLES.md`](./EXAMPLES.md)。

---

## 设计哲学

### 为什么是七条，不是更多

规则集的有效性和规则数量成反比。超过 10 条规则，agent 开始做 "best effort" 而非 "strict compliance"。七条是 agent context window 里能被完整 attend to 的上限附近。

### 为什么每个 IDE 一个适配器

不同 IDE 的规则加载机制完全不同：

- **Cursor** 读 `.cursor/rules/` 下的 `.mdc` 文件，支持 `alwaysApply: true` 前缀
- **Claude Code** 读项目根 `CLAUDE.md`，或通过 plugin 机制加载
- **Codex** 读 `AGENTS.md`，支持 skill directory 结构
- **WorkBuddy** 读 project direction，结合 memory/task context

用一个通用文件 "hope" 所有 IDE 都读到，是一种妥协。Star Guidelines 拒绝这种妥协——为每个 loader 写原生格式的适配器，保证 100% 的规则覆盖率。

### 为什么契约优先于建议

建议（"你应该..."）可以被忽略。契约（"违反时 agent 必须..."）有强制退出条件。Star Guidelines 的每条规则都有明确的触发条件和对应行为，不是 best practice 列表。

---

## 与其他方案的对比

| 维度 | Star Guidelines | 社区 `.cursorrules` 模板 | 通用 AI coding guidelines |
| --- | --- | --- | --- |
| IDE 覆盖 | 4 个原生适配器 | 仅 Cursor | 无特定 IDE 适配 |
| 规则数量 | 7 条（可被 agent 完整 attend） | 通常 15-50+ 条 | 不限 |
| 验证机制 | 可执行握手 | 无 | 无 |
| 规范源 | 单文件 `core/CONTRACT.md` | 无规范源概念 | N/A |
| 完成标准 | 必须有 evidence | 通常无强制 | 无 |
| 维护成本 | `check-repo.sh` 自动检查一致性 | 手动维护 | N/A |
| 架构 | adapter pattern（隔离） | 单文件（all-in-one） | 文档（无架构） |

---

## 仓库结构

```text
star-guidelines/
├── core/
│   └── CONTRACT.md                    # 规范源 · 七条规则的唯一 source of truth
├── AGENTS.md                          # Codex adapter · 命令式风格
├── CLAUDE.md                          # Claude Code adapter · 项目规则风格
├── CURSOR.md                          # Cursor 使用指南
├── WORKBUDDY.md                       # WorkBuddy adapter · 长流程 direction
├── .cursor/
│   ├── rules/star-guidelines.mdc      # Cursor always-on rule（alwaysApply: true）
│   └── skills/star-guidelines/SKILL.md # Cursor project skill
├── skills/star-guidelines/
│   ├── SKILL.md                       # IDE-agnostic reusable skill
│   └── agents/openai.yaml            # OpenAI skill runner metadata
├── .claude-plugin/
│   ├── plugin.json                    # Claude plugin manifest
│   ├── marketplace.json               # Marketplace metadata
│   └── skills/star-guidelines/SKILL.md # Bundled skill copy
├── docs/
│   ├── ADAPTERS.md                    # 适配器详细指南
│   └── INSTALL.md                     # 分平台安装文档
├── EXAMPLES.md                        # 7 个 before/after 场景
├── CHANGELOG.md                       # 版本变更记录
├── LICENSE                            # 源码可读，需经授权
└── scripts/
    └── check-repo.sh                  # CI：文件存在性 + 术语覆盖 + 身份一致性
```

---

## 设计原则

| 原则 | 含义 |
| --- | --- |
| **One loader, one adapter** | 不让任何 IDE 猜哪个文件生效。每个 loader 有且只有一个入口。 |
| **Local code over generic advice** | Agent 必须先读当前仓库的代码/测试/约定，再决定实现形状。 |
| **Small diffs as a feature** | 无关清理是独立 PR，不是当前改动的隐藏副作用。 |
| **Verification is work** | 没有 evidence 的完成报告等于没完成。 |
| **User work is sacred** | 未提交改动 = 用户私有财产。未经允许不可触碰。 |
| **Contract is normative** | 适配器与 `core/CONTRACT.md` 冲突时，以契约为准。 |
| **Risk-proportional ceremony** | typo fix 不需要 plan；跨模块重构必须有 plan + evidence + risk。 |

---

## 维护与一致性保证

修改核心契约时，**同一次 commit** 同步全部 8 个适配器文件：

```text
core/CONTRACT.md                       ← 改这里
AGENTS.md                              ← 同步
CLAUDE.md                              ← 同步
.cursor/rules/star-guidelines.mdc      ← 同步
.cursor/skills/star-guidelines/SKILL.md ← 同步
WORKBUDDY.md                           ← 同步
skills/star-guidelines/SKILL.md        ← 同步
.claude-plugin/skills/…/SKILL.md       ← 同步
```

发布前强制运行一致性检查：

```bash
scripts/check-repo.sh
```

脚本验证项：
- 所有必需文件存在
- 五个核心术语在每个适配器中都有覆盖
- 中文 README 包含所有中文核心术语
- Git author/committer 身份一致性
- `origin/main` 与 HEAD 对齐

---

## 适合谁

在真实代码库里用 frontier 编码 agent（Claude Code / Cursor Agent / Codex / GPT-Engineer / Devin / Copilot Workspace），且已经被以下问题坑过至少一次的工程师：

- Agent 越界改动导致 PR 被打回
- Agent 伪造完成导致线上 incident
- Agent 为单一用例堆三层抽象
- 跨 IDE 切换后规则悄悄失效

如果你还没为这些错误买过单，暂时不需要这套。

**这是一个个人 kit。激进精修。不是入门模板。不是 committee product。**

---

## 授权

**Source-available, permission-required.**

| 行为 | 是否需要授权 |
| --- | --- |
| 阅读、学习、评估 | ✅ 自由 |
| 引用片段（署名 + 链接） | ✅ 自由 |
| 分发、镜像、打包进产品 | ❌ 需书面授权 |
| 构建 competing rule kit | ❌ 需书面授权 |
| 用于模型训练 | ❌ 需书面授权 |

详见 [`LICENSE`](./LICENSE)。授权请求通过 [GitHub Issues](https://github.com/Stargod-0812/star-guidelines/issues) 提交。

---

<div align="center">

由 **[Star](https://github.com/Stargod-0812)** 构建并精修 · v2.0.0

个人 kit · 已用于生产 · 持续迭代中

</div>
