# markmap 思维导图规范（mindmap-spec）

## 技术方案（已验证）

- 使用 markmap-autoloader（jsDelivr CDN），**不要**同时手写引入 markmap-lib + markmap-view（会报 `Transformer has already been declared`）
- 模板：`assets/mindmap-template.html`（官方 autoloader 用法：`<div class="markmap"><script type="text/template"># markdown</script></div>`）
- 单文件自包含：内联样式 + CDN 脚本，可直接浏览器打开、可发布

## 内容组织

- 根节点 = 章节名（如「阶段八：Agent开发精讲与实战」）
- 一级 = 各里程碑（如「里程碑一：Agent核心概念 & 三大范式」）
- 二级 = 核心知识点（一句话，≤30 字）
- 三级 = 关键细节（少量，只在确有价值时用，如多模态 RAG 三方案）
- 每节点文字尽量短，节点总数控制在 40-60 个，避免密集重叠

## 截图验证（必须，交付前）

用 `html` Skill 的 `scripts/shot.py`：

```bash
python3 <html-skill>/scripts/shot.py <mindmap.html>
```

检查项：
1. 报告 `consoleErrors` 为空（CDN 加载成功、无 JS 报错）
2. 桌面截图 Read 检查：六/各里程碑分支完整展开、**无文字重叠**
3. 移动截图存在（如产物需移动端查看）

用户明确偏好：导图必须无文字重叠（曾因重叠要求重做并复刻 markmap 思路）。

## 产物落点

- 交付：HTML 文件（`present_files`）+ 截图（可插入飞书文档作业「脑图」处）
- 截图命名：`{章节}思维导图_desktop.jpg` / `_mobile.jpg`，存 `_shots/`
