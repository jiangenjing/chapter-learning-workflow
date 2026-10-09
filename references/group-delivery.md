# 群发布与文档权限（group-delivery）

## 目标群

- 默认群：**「AI打卡群」** chat_id=`oc_e629ff5c93bf1a55b04b2918e3524d1d`（external=True，外部群，群主=用户）
- 备份旧群「学习资料库」chat_id=`oc_54ff908727a4e7a1a0e6d14cdefb7ed7`（内部群）
- 用户说「发到群里 / 资料同步」时默认发 AI 打卡群；群名可随时按用户要求改（`lark-cli im +chat-update --name <新名> --as user`）

## 发消息模板

用 `lark-cli im +messages-send --chat-id <群> --markdown $'...' --as user`：

```
## 📚 {文档标题}

{2-3 句摘要，突出价值}

🔗 <文档链接>
```

- 播客/导图文件：`--file ./相对路径`（必须 cwd 相对路径；播客用压缩版 ≤20MB）
- 所有发群消息必须 `--as user`（用户身份），且发送前用户已授权

## 文档权限开放（可选，用户要求时）

用户说「打开权限 / 所有人都能访问 / 共享给大家」时：

1. 读取当前权限：`lark-cli drive +permission-get-setting --token <url> --as user`
2. 检查授权：`lark-cli drive permission.members auth --params '{"action":"manage_public","token":"<token>","type":"docx"}' --as user`（auth_result=false 则不能 patch）
3. 确认档位（必须向用户确认：范围 + 只读/可编辑）：
   - 所有人可阅读（推荐）：`link_share_entity=anyone_readable`
   - 仅组织内：`tenant_readable`
4. 执行：`lark-cli drive permission.public patch --params '{"token":"<token>","type":"docx"}' --data '{"link_share_entity":"anyone_readable"}' --as user --yes`
5. 验证：重新 `+permission-get-setting` 确认 `link_share_entity: anyone_readable`

注意：`anyone_readable` = 互联网公开链接可读（P0 级开放），修改前必须明确告知用户并获确认。

## 已知坑

- 消息超过文件上限（~20MB）报错 234006 → 播客先压缩
- `--file` 本地路径必须是 cwd 相对路径，绝对路径被拒绝
- 群链接/二维码：`lark-cli im chats link` 可取分享链接；外部群邀请需用户在飞书客户端操作
