# ai-ks-fastapi

使用 Terraform（Docker provider）在本地拉起 **Python 3.14** 容器，挂载 `code/` 运行最小 **FastAPI** 应用（`uvicorn`）。

## 前置条件

- [Terraform](https://www.terraform.io/) ≥ 1.x
- Docker
- Provider：`kreuzwerker/docker` 3.9.0（网络慢时可本地 `-plugin-dir`，见下）

## 快速开始

```bash
chmod +x tf_apply.sh tf_destroy.sh
./tf_apply.sh                    # 默认端口 21001，代码目录 code/
./tf_apply.sh 18001              # 指定宿主机端口
./tf_apply.sh 18001 code -node-100   # 端口 + 代码目录 + 容器名后缀（多节点）

./tf_destroy.sh                  # 销毁资源
```

`--clean` / `-c`：先 `destroy` 再 `apply`（彻底重装）。

### 离线 / 内网插件目录

- 环境变量：`TF_INIT_PLUGIN_DIR` 指向含 provider 的目录；或
- 将插件放在本模块上两级目录的 `plugins/`（例如 `workspace/plugins`）。

与 [ai-ks-design](https://github.com/Szy1227/ai-ks-design) 编排时，会使用 `workspace/ai-ks-tools/terraform/plugins`。

## 项目结构

```
.
├── main.tf           # Docker 镜像与容器
├── tf_apply.sh       # init + apply
├── tf_destroy.sh
└── code/
    ├── main.py       # FastAPI 入口
    ├── requirements.txt
    └── start.sh      # 容器内：pip install + uvicorn
```

容器内监听 **8000**，映射到 `external_port`。

## 相关仓库

- [ai-ks-design](https://github.com/Szy1227/ai-ks-design) — 多节点编排
- [ai-ks-vue](https://github.com/Szy1227/ai-ks-vue) — 前端
- [ai-ks-ssh-claude](https://github.com/Szy1227/ai-ks-ssh-claude) — SSH 开发容器
