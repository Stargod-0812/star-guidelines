<div align="center">

# Star Guidelines

**面向 frontier 编码 agent 的工作契约。**

每个 IDE 一个原生适配器。底层共享一份七条规则的契约。环境之间不漂移。

[![Stars](https://img.shields.io/github/stars/Stargod-0812/star-guidelines?style=flat-square&logo=github&label=stars&color=111)](https://github.com/Stargod-0812/star-guidelines/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Stargod-0812/star-guidelines?style=flat-square&color=111)](https://github.com/Stargod-0812/star-guidelines/commits/main)
[![Adapters](https://img.shields.io/badge/adapters-Cursor%20%7C%20Claude%20%7C%20Codex%20%7C%20WorkBuddy-111?style=flat-square)](#适配器路由)
[![Contract](https://img.shields.io/badge/contract-7%20rules-111?style=flat-square)](#star-契约)
[![Version](https://img.shields.io/badge/version-2.0.0-111?style=flat-square)](./CHANGELOG.md)
[![Lang](https://img.shields.io/badge/English-111?style=flat-square)](./README.md)

</div>

---

> Frontier 编码 agent 的失败几乎不发生在模型层面，而发生在执行层面 —— 自作主张地猜任务边界、顺手改无关代码、忽略未提交工作、伪造完成报告、在每个 IDE 加载错的规则。**Star Guidelines 就是把这道执行层的口子缝住的契约。**

## 为什么需要这套规则

大多数 agent 的失败看起来像能力不足，其实是执行面问题。

- 请求模糊时，agent 自己挑了一个理解，没有提问。
- 任务边界外的代码看起来可以更好，agent 顺手改了。
- 仓库还没有真实重复需求，agent 提前堆抽象。
- agent 覆盖了用户未提交的工作。
- agent 没跑测试、构建、截图、复现，就说完成了。
- 在 Claude 项目里加载了 `.cursor/rules/`，或者在 Cursor 里加载了 `CLAUDE.md`，两套规则相互抵消。

更强的模型不会修这些问题。一份契约才会。

## 与其他规则集的区别

| Star Guidelines | 多数 agent 规则集 |
| --- | --- |
| 每个 IDE 一个适配器，互不重叠 | 一个文件，靠所有 IDE 都能读到 |
| 七条规则，单一规范源 `core/CONTRACT.md` | 长 checklist，文件之间漂移 |
| 可验证握手 (`is star-guidelines active?`) | 没有方式确认规则已加载 |
| 一个人精修，刻意为之 | 委员会编辑，最低公约数 |
| 没证据不算完成是产品能力 | "看起来对" 就当作完成 |

## 适合谁用

在真实代码库里使用编码 agent，且已经被越界改动、伪造完成、为单一用例堆抽象、规则悄悄失效坑过的工程师。如果你还没有为这些错误买过单，暂时不需要这套。

这是一个个人 kit，激进精修。不是入门模板。

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

一个环境，一个主适配器。下面这张表是入口真相。

| 运行环境 | 主适配器 | 可选搭配 | Agent 应该说 |
| --- | --- | --- | --- |
| Cursor 项目规则 | `.cursor/rules/star-guidelines.mdc` | `.cursor/skills/star-guidelines/SKILL.md` | `Cursor rule loaded` |
| Cursor 项目 skill | `.cursor/skills/star-guidelines/SKILL.md` | `.cursor/rules/star-guidelines.mdc` | `Cursor skill loaded` |
| Codex / AGENTS-aware IDE | `AGENTS.md` | `skills/star-guidelines/SKILL.md` | `AGENTS rules loaded` |
| Codex 风格 skill runner | `skills/star-guidelines/SKILL.md` | `skills/star-guidelines/agents/openai.yaml` | `skill loaded` |
| Claude Code 项目 | `CLAUDE.md` | 无 | `Claude project rules loaded` |
| Claude plugin 风格环境 | `.claude-plugin/` | 无 | `bundled skill loaded` |
| WorkBuddy 长任务 | `WORKBUDDY.md` | 项目任务上下文 | `WorkBuddy direction loaded` |
| 新增适配器 | `core/CONTRACT.md` | 现有适配器示例 | `contract source loaded` |

不要把所有适配器都装进同一个项目。每个文件都是为特定 loader 写的。如果目标项目已有规则，把对应适配器合并到同一个规则入口里 —— 不要叠加。

## 快速安装

### Cursor

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/rules
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" \
  -o .cursor/rules/star-guidelines.mdc
```

如果想在常驻规则之外再加完整 Cursor 项目 skill：

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/skills/star-guidelines
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" \
  -o .cursor/skills/star-guidelines/SKILL.md
```

### Claude Code

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/CLAUDE.md" \
  -o CLAUDE.star-guidelines.md
```

把 `CLAUDE.star-guidelines.md` 合并进项目的 `CLAUDE.md`。如果环境支持 plugin 风格加载，使用 plugin 包：

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
cp -R star-guidelines/.claude-plugin /path/to/your/claude-plugin-location/star-guidelines
```

### Codex

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/AGENTS.md" \
  -o AGENTS.star-guidelines.md
```

合并进项目的 `AGENTS.md`。可复用 skill：

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
mkdir -p ~/.codex/skills
cp -R star-guidelines/skills/star-guidelines ~/.codex/skills/
```

### WorkBuddy

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/WORKBUDDY.md" \
  -o WORKBUDDY.star-guidelines.md
```

合并进 WorkBuddy 项目级 direction 区域。适合长流程、记忆感知流程、MCP 密集任务、跨会话交接。

## Agent 握手

安装后问：

```text
is star-guidelines active?
```

| IDE | 预期回答应提到 |
| --- | --- |
| Cursor | Cursor rules 或 Cursor skill |
| Codex | `AGENTS.md` 或 `$star-guidelines` |
| Claude Code | 七条工作契约 |
| WorkBuddy | 项目边界、记忆/上下文检查、consent、证据、可交接状态 |

如果回答里出现错误适配器，删掉多余规则入口，只保留匹配当前 IDE 的那一个。

---

## Star 契约

每个适配器都携带同一套七条规则。规范源：[`core/CONTRACT.md`](./core/CONTRACT.md)。其他适配器文件都是把这份契约投影到各 IDE 的原生 loader。

1. **先澄清，再编辑。** 说明会影响实现的重要假设；当歧义会改变文件、API、数据、安全或用户可见行为时，先问。
2. **先阅读，再设计。** 选择实现前，先检查现有代码、测试、脚本、文档和本地约定。
3. **保持改动狭窄。** 只触碰完成请求所需的文件。不顺手重构。不做大范围格式化。
4. **优先当前最简单方案。** 只有当仓库已有真实重复需求或既有模式要求时，才增加抽象。
5. **保护用户工作。** 未提交改动默认属于用户，除非是你刚刚做的；没有明确要求，不覆盖、不回滚。
6. **用具体证据验证。** 运行最小有用测试、构建、lint、截图、日志检查或手动复现，并说明通过了什么、没跑什么。
7. **简短说明权衡。** 点出有意义的风险、简单替代方案和未决问题，但不要把日常任务变成仪式。

契约强度随风险上升。一个拼写修复保持轻量；跨模块重构必须有计划和证据。

## 好的执行长什么样

```text
Orient   →   阅读负责该行为的文件、测试、脚本、文档和本地约定
Scope    →   只说明会改变实现的重要假设
Edit     →   触碰满足请求所需的最小文件集合
Verify   →   运行最小有用检查，并报告具体证据
Report   →   说明改了什么、通过了什么、跳过了什么、还剩什么风险
```

五步。没有仪式感。每一步都挂着自己的验证检查。

## 对比示例

两个场景节选自 [`EXAMPLES.md`](./EXAMPLES.md)。完整版本看那里。

**Bug 修复 —— 缺失到期日让提醒生成崩溃。**

弱 agent 会把一个空值路径扩成通知策略、试用用户处理和兜底排期。Star agent 只改崩溃边界：

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ due_date = customer.get("due_date")
+ if due_date is None:
+     return None
+ reminder_at = due_date - timedelta(days=3)
```

**完成报告 —— 功能开发完。**

弱 agent：「Done.」

Star agent：「改了 `src/webhooks/retry.ts` 和 `src/webhooks/retry.test.ts`。用 `npm test -- webhooks/retry.test.ts` 验证。完整测试套件没跑。剩余风险：没有覆盖 provider-specific retry throttling。」

用户能精确看到改动面、验证证据和未覆盖边界。这就是基线。

---

## 仓库地图

```text
star-guidelines/
├── core/
│   └── CONTRACT.md                            # 规范源（七条规则）
├── AGENTS.md                                  # Codex / AGENTS-aware IDE
├── CLAUDE.md                                  # Claude Code 项目规则
├── CURSOR.md                                  # Cursor 使用指南
├── WORKBUDDY.md                               # 长流程 agent direction
├── .cursor/
│   ├── rules/star-guidelines.mdc              # Cursor 常驻规则
│   └── skills/star-guidelines/SKILL.md        # Cursor 项目 skill
├── skills/star-guidelines/
│   ├── SKILL.md                               # 可复用 Markdown skill
│   └── agents/openai.yaml                     # 支持 skill 的运行器元数据
├── .claude-plugin/                            # Claude plugin 风格包
├── docs/
│   ├── ADAPTERS.md                            # 适配器指南
│   └── INSTALL.md                             # 简短安装指南
├── EXAMPLES.md                                # 好坏 agent 行为示例
├── CHANGELOG.md                               # 版本变更记录
└── scripts/check-repo.sh                      # 一致性 + 历史检查
```

## 设计原则

- **一个 loader，一个适配器。** 不让任何 IDE 猜哪个文件重要。
- **本地代码优先于通用建议。** agent 必须先读仓库，再决定实现形状。
- **小 diff 是产品能力。** 无关清理应该成为后续任务，而不是隐藏副作用。
- **验证属于工作本身。** 没有证据的完成报告不算完成。
- **用户工作不可随意处置。** 现有未提交改动不是可以覆盖的上下文。
- **契约即规范。** 当适配器与 `core/CONTRACT.md` 不一致时，以契约为准。

## 维护

修改核心契约时，必须在同一次改动中同步以下文件：

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

脚本会强制检查文件存在、契约关键术语在每个适配器都覆盖、`origin/main` 对齐，以及可达 refs 都属于 `Stargod-0812` author 身份。版本历史见 [CHANGELOG.md](./CHANGELOG.md)。

## 授权

Star Guidelines 是 **源码可读、需经授权**。欢迎阅读、并在保留署名的前提下在自己的工作里引用。任何分发、打包进产品、在其之上构建对位规则集、或用于训练模型的用途，都需要作者书面授权。详见 [`LICENSE`](./LICENSE)。

---

<div align="center">

由 **[Star](https://github.com/Stargod-0812)** 构建并精修 · v2.0.0 · 个人 kit，已用于生产

</div>
