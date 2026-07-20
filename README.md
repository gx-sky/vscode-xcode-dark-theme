# Sky Xcode Dark Theme（中文说明）

`Sky Xcode Dark Theme` 是 IntelliJ `Xcode-Dark` 主题在 VS Code 中的高保真移植版本，并针对 Java/Spring 场景做了持续优化。

## 基线来源

- UI 与语法色板基线：`images/xcode-dark-palette.svg`
- VS Code 主题文件：`themes/sky-xcode-dark-color-theme.json`

暗色主题优先复用 SVG 中的角色颜色；仅当原色无法满足可读性或 VS Code 需要额外状态色时，才使用同色相的适配色。

## 当前配色策略（Java/Spring）

- 关键字/注解：Xcode 粉色加粗（`#FF78B2`）
- 字符串：珊瑚色（`#FF806C`）
- 数字/字符：柔和黄色（`#DACA77`）
- 方法/函数：青绿色（`#75C3B3`）
- 局部变量：白色（`#FCFCFC`）
- 全局/成员变量：紫色（`#B37EEE`）
- 类/接口/枚举/类型引用/泛型参数：统一青蓝色（`#49B0CE`）
- 注释：可访问性增强灰蓝色（`#8A98A6`）；原色 `#7F8C99` 在部分背景上对比度不足
- 选择状态：Xcode 蓝色（`#0973EB`）

## 已完成优化摘要

- 增强 Java/Spring 专项规则：注解、导包、变量语义分类等。
- 按 `xcode-dark-palette.svg` 校准关键字、数字、方法、选择与链接颜色。
- 恢复成员/全局变量的紫色语义层级，避免与类型色混淆。
- 补齐 Java 数组、继承/实现、模块与注解成员的精确 scope，并移除过宽的 import 覆盖。
- 修复局部变量“同名不同色”问题：收窄过宽 scope，增加局部变量兜底。
- 去除高风险 broad scope（如方法调用整段染色）以减少串色。
- 统一类相关颜色，避免声明/引用/默认库多色割裂。
- 统一泛型参数 `typeParameter` 与类型色，提升 `Map<String, Object>` 可读性。

## 开发维护原则

- 优先使用 `semanticTokenColors`，`tokenColors` 作为兜底。
- 避免使用会覆盖整段表达式的宽 scope（如 `meta.method-call`）。
- 同一符号类别保持“声明与使用”颜色一致。
- 每次调整至少验证以下片段：
  1. 泛型方法签名（返回值 + 参数）
  2. 局部变量声明与多次使用
  3. 成员字段声明与使用
  4. 注解密集的 Spring Service/Controller
  5. 数组类型与元素类型（如 `Integer`、`Integer[]`、`List<Integer>[]`）
  6. 继承、实现与 permits 中的类型引用
  7. 导入处类名与代码中使用处的颜色一致性
  8. 注解成员在 semantic token 与 TextMate fallback 下的一致性

## 推荐排查流程

1. 在 VS Code 执行 `Developer: Inspect Editor Tokens and Scopes`
2. 记录异常符号的 semantic token（type/modifier/language）与 TextMate scope
3. 先改 `semanticTokenColors`，再补最小化 `tokenColors`
4. 重新打包 VSIX，在同一代码片段回归验证

## 打包方式

在仓库根目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File build-vsix.ps1
```

输出文件：

- `vscode-xcode-dark-theme.vsix`

## 安装方式

1. VS Code 命令面板执行：`Extensions: Install from VSIX...`
2. 选择 `sky-xcode-dark-theme.vsix`
3. 启用主题 `Sky Xcode Dark Theme`

## 致谢

- VS Code 版本移植与持续优化：当前项目维护者

## 许可证

MIT

