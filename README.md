<div align="center">

# Star Guidelines

**编码 Agent 的工作契约。七条规则，杀死 agent 失控。**

一个 IDE 一个适配器。底层一份契约。跨环境零漂移。

[![Stars](https://img.shields.io/github/stars/Stargod-0812/star-guidelines?style=flat-square&logo=github&label=stars&color=111)](https://github.com/Stargod-0812/star-guidelines/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Stargod-0812/star-guidelines?style=flat-square&color=111)](https://github.com/Stargod-0812/star-guidelines/commits/main)
[![Adapters](https://img.shields.io/badge/adapters-Cursor%20%7C%20Claude%20%7C%20Codex%20%7C%20WorkBuddy-111?style=flat-square)](#适配器路由)
[![Contract](https://img.shields.io/badge/contract-7%20rules-111?style=flat-square)](#star-契约)
[![Version](https://img.shields.io/badge/version-2.0.0-111?style=flat-square)](./CHANGELOG.md)
[![English](https://img.shields.io/badge/English-111?style=flat-square)](./README.en.md)

</div>

---

## 问题

Frontier 编码 agent 几乎不在模型层面翻车。翻车发生在执行层：

| 失控模式 | 后果 |
| --- | --- |
| 请求模糊时自作主张 | 做错方向，回滚成本翻倍 |
| 顺手改任务边界外的代码 | review 成本暴涨，隐性 bug |
| 还没有真实重复就堆抽象 | 代码膨胀，后人维护负担 |
| 覆盖用户未提交的工作 | 丢改动，信任归零 |
| 没跑任何验证就说 "Done" | 虚假安全感，线上炸 |
| 在 Cursor 里加载了 Claude 的规则，反之亦然 | 规则互相抵消，等于没有规则 |

**更强的模型不修这些。一份执行契约才修。**

---

## Star 契约

七条规则。规范源：[`core/CONTRACT.md`](./core/CONTRACT.md)。

| # | 规则 | 一句话 |
| --- | --- | --- |
| 1 | **先澄清，再编辑** | 歧义会改文件/API/数据/安全/用户行为时，先问 |
| 2 | **先阅读，再设计** | 选方案前读完相关代码、测试、文档、本地约定 |
| 3 | **保持改动狭窄** | 只碰请求需要的文件；不顺手重构 |
| 4 | **优先当前最简方案** | 没有真实重复需求，不堆抽象 |
| 5 | **保护用户工作** | 未提交改动默认属于用户；没有指令不覆盖 |
| 6 | **用具体证据验证** | 跑最小有用的测试/构建/截图/日志/复现 |
| 7 | **简短说明权衡** | 点出风险和替代方案，不把日常工作变仪式 |

契约强度随风险上升。改个拼写保持轻量；跨模块重构必须有计划和证据。

---

## 与其他规则集的区别

| | Star Guidelines | 多数 agent 规则集 |
| --- | --- | --- |
| 架构 | 一个 IDE 一个适配器，互不重叠 | 一个文件 hope 所有 IDE 读到 |
| 规范源 | 七条规则，单文件 `core/CONTRACT.md` | 长 checklist，文件之间漂移 |
| 验证 | 可执行握手确认规则已加载 | 没有确认机制 |
| 策展 | 一个人精修，刻意为之 | 委员会编辑，最低公约数 |
| 完成标准 | 没证据不算完成 | "看起来对" 就过 |

---

## 适配器路由

```text
                    ┌────────────────────────────┐
                    │     core/CONTRACT.md       │   ← 规范源
                    │       7 条 Star 规则        │
                    └─────────────┬──────────────┘
                                  │
        ┌──────────────┬──────────┴──────────┬──────────────┐
        │              │                     │              │
     Cursor       Claude Code              Codex        WorkBuddy
     ──────       ───────────              ─────        ─────────
   .cursor/rules   CLAUDE.md             AGENTS.md      WORKBUDDY.md
   .cursor/skills  .claude-plugin/       skills/        (项目方向)
```

一个环境只装一个主适配器。下表是每个 IDE 的入口真相：

| 运行环境 | 主适配器 | 可选搭配 | Agent 应答 |
| --- | --- | --- | --- |
| Cursor 项目规则 | `.cursor/rules/star-guidelines.mdc` | `.cursor/skills/star-guidelines/SKILL.md` | `Cursor rule loaded` |
| Cursor 项目 skill | `.cursor/skills/star-guidelines/SKILL.md` | `.cursor/rules/star-guidelines.mdc` | `Cursor skill loaded` |
| Codex / AGENTS IDE | `AGENTS.md` | `skills/star-guidelines/SKILL.md` | `AGENTS rules loaded` |
| Codex skill runner | `skills/star-guidelines/SKILL.md` | `skills/star-guidelines/agents/openai.yaml` | `skill loaded` |
| Claude Code 项目 | `CLAUDE.md` | 无 | `Claude project rules loaded` |
| Claude plugin 环境 | `.claude-plugin/` | 无 | `bundled skill loaded` |
| WorkBuddy 长任务 | `WORKBUDDY.md` | 项目任务上下文 | `WorkBuddy direction loaded` |

不要把所有适配器堆进同一个项目。如果目标项目已有规则文件，把对应适配器**合并**进去。

---

## 快速安装

### Cursor

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/rules
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" \
  -o .cursor/rules/star-guidelines.mdc
```

完整 skill（可选）：

```bash
mkdir -p .cursor/skills/star-guidelines
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" \
  -o .cursor/skills/star-guidelines/SKILL.md
```

### Claude Code

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/CLAUDE.md" -o CLAUDE.star-guidelines.md
```

合并进项目 `CLAUDE.md`。Plugin 环境用 plugin 包：

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
cp -R star-guidelines/.claude-plugin /path/to/target/star-guidelines
```

### Codex

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/AGENTS.md" -o AGENTS.star-guidelines.md
```

合并进 `AGENTS.md`。可复用 skill：

```bash
mkdir -p ~/.codex/skills
cp -R star-guidelines/skills/star-guidelines ~/.codex/skills/
```

### WorkBuddy

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/WORKBUDDY.md" -o WORKBUDDY.star-guidelines.md
```

合并进 WorkBuddy 项目级 direction 区域。

---

## 验证握手

安装后问 agent：

```text
is star-guidelines active?
```

| IDE | 预期回答应提到 |
| --- | --- |
| Cursor | Cursor rules 或 Cursor skill |
| Codex | `AGENTS.md` 或 `$star-guidelines` |
| Claude Code | 七条工作契约 |
| WorkBuddy | 项目边界、记忆检查、consent、证据、可交接状态 |

回答里出现错误适配器 → 删掉多余规则文件，只保留当前 IDE 的那一个。

---

## 好的执行长什么样

```text
Orient   →   读负责该行为的文件、测试、脚本、文档
Scope    →   只说明会改变实现的假设
Edit     →   触碰满足请求的最小文件集
Verify   →   跑最小有用检查，报告具体证据
Report   →   改了什么、通过了什么、跳过了什么、还剩什么风险
```

五步。没有仪式。每步都有验证锚点。

---

## 对比示例

两个场景节选自 [`EXAMPLES.md`](./EXAMPLES.md)。

**Bug 修复 —— 缺失到期日让提醒崩溃**

弱 agent 把一个空值路径扩成通知策略 + 试用处理 + 兜底排期。Star agent 只改崩溃边界：

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ due_date = customer.get("due_date")
+ if due_date is None:
+     return None
+ reminder_at = due_date - timedelta(days=3)
```

**完成报告**

弱 agent：「Done.」

Star agent：「改了 `src/webhooks/retry.ts` 和 `src/webhooks/retry.test.ts`。用 `npm test -- webhooks/retry.test.ts` 验证。完整套件没跑。剩余风险：未覆盖 provider-specific retry throttling。」

用户能精确看到改动面、验证证据和未覆盖边界。

---

## 仓库结构

```text
star-guidelines/
├── core/CONTRACT.md                   # 规范源（七条规则）
├── AGENTS.md                          # Codex / AGENTS IDE
├── CLAUDE.md                          # Claude Code 项目规则
├── CURSOR.md                          # Cursor 使用指南
├── WORKBUDDY.md                       # 长流程 agent direction
├── .cursor/
│   ├── rules/star-guidelines.mdc      # Cursor 常驻规则
│   └── skills/star-guidelines/SKILL.md
├── skills/star-guidelines/
│   ├── SKILL.md                       # 可复用 Markdown skill
│   └── agents/openai.yaml             # skill runner 元数据
├── .claude-plugin/                    # Claude plugin 包
├── docs/
│   ├── ADAPTERS.md                    # 适配器指南
│   └── INSTALL.md                     # 安装指南
├── EXAMPLES.md                        # 好坏行为对照
├── CHANGELOG.md                       # 版本变更
└── scripts/check-repo.sh             # 一致性检查
```

---

## 设计原则

- **一个 loader 一个适配器。** 不让 IDE 猜哪个文件重要。
- **本地代码优先。** agent 必须先读仓库再动手。
- **小 diff 是产品能力。** 无关清理是后续任务，不是隐藏副作用。
- **验证属于工作本身。** 没证据的完成报告不算完成。
- **用户工作不可处置。** 未提交改动不是可以随便覆盖的上下文。
- **契约即规范。** 适配器与 `core/CONTRACT.md` 不一致时以契约为准。

---

## 适合谁用

在真实代码库里用编码 agent、且已经被越界改动 / 伪造完成 / 堆无用抽象 / 规则悄悄失效坑过的工程师。

如果你还没为这些错误买过单，暂时不需要这套。

这是个人 kit，激进精修。不是入门模板。

---

## 维护

修改核心契约时，同一次 commit 同步所有适配器：

- `core/CONTRACT.md`
- `AGENTS.md`
- `CLAUDE.md`
- `.cursor/rules/star-guidelines.mdc`
- `.cursor/skills/star-guidelines/SKILL.md`
- `WORKBUDDY.md`
- `skills/star-guidelines/SKILL.md`
- `.claude-plugin/skills/star-guidelines/SKILL.md`

发布前运行：

```bash
scripts/check-repo.sh
```

---

## 授权

**源码可读，需经授权。** 欢迎阅读和引用（署名 + 链接）。分发、打包进产品、构建对位规则集、用于模型训练，需作者书面授权。详见 [`LICENSE`](./LICENSE)。

---

<div align="center">

由 **[Star](https://github.com/Stargod-0812)** 构建并精修 · v2.0.0 · 个人 kit，已用于生产

</div>
