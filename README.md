<div align="center">
  <img width="100px" alt="logo" src="https://raw.githubusercontent.com/OpenListTeam/Logo/main/logo.svg"/></a>
  <p><em>🗂️A file list program that supports multiple storages, powered by Gin and SolidJS, fork of AList.</em></p>
<div>
  <a href="https://goreportcard.com/report/github.com/OpenListTeam/OpenList/v3">
    <img src="https://goreportcard.com/badge/github.com/OpenListTeam/OpenList/v3" alt="latest version" />
  </a>
  <a href="https://github.com/OpenListTeam/OpenList/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/OpenListTeam/OpenList" alt="License" />
  </a>
  <a href="https://github.com/OpenListTeam/OpenList/actions?query=workflow%3ABuild">
    <img src="https://img.shields.io/github/actions/workflow/status/OpenListTeam/OpenList/build.yml?branch=main" alt="Build status" />
  </a>
  <a href="https://github.com/OpenListTeam/OpenList/releases">
    <img src="https://img.shields.io/github/release/OpenListTeam/OpenList" alt="latest version" />
  </a>
</div>
<div>
  <a href="https://github.com/OpenListTeam/OpenList/discussions">
    <img src="https://img.shields.io/github/discussions/OpenListTeam/OpenList?color=%23ED8936" alt="discussions" />
  </a>
  <a href="https://github.com/OpenListTeam/OpenList/releases">
    <img src="https://img.shields.io/github/downloads/OpenListTeam/OpenList/total?color=%239F7AEA&logo=github" alt="Downloads" />
  </a>
</div>
</div>

---

> [!IMPORTANT]
>
> Drop-in replacement for AList with long-term governance, no hidden risks, and full transparency, built to defend open source against trust-based attacks.
>
> We sincerely thank the author [Xhofe](https://github.com/Xhofe) of the original project [AlistGo/alist](https://github.com/AlistGo/alist) and all other contributors.
>
> This fork is not yet stable, specific migration progress can be viewed in [OpenList Migration Work Summary](https://github.com/OpenListTeam/OpenList/issues/6).

## 构建你自己的 Docker 镜像

> Openlist 有官方的镜像，本教程只是为了解决 [issues 226](https://github.com/OpenListTeam/OpenList/issues/226) 在 clawcloud 遇到的不断自动 exit 的问题。

> [个人构建的版本](https://hub.docker.com/r/ppken/openlist/tags)，不建议使用，请以[官方镜像](https://hub.docker.com/r/openlistteam/openlist/tags)为准。

以下是根据现有源码编译并推送你自己的 Docker 镜像的步骤：

### 第一步：准备工作

1.  打开 Docker Desktop 并确保它正在运行。
2.  在终端中，确保你当前位于 `openlist` 项目的根目录下。

### 第二步：构建 Docker 镜像

1.  执行以下命令来构建你的 Docker 镜像。

    - 将 `你的 DockerHub 用户名` 替换为你在 Docker Hub 上的实际用户名。
    - `openlist:latest` 是你为新镜像指定的名称和标签，你可以根据需要自定义。

    ```bash
    docker build -t 你的 DockerHub 用户名/openlist:latest .
    ```

    **注意：** 命令末尾的 `.` 表示使用当前目录作为构建上下文，请勿遗漏。

2.  构建过程可能需要一些时间（因为它需要下载基础镜像、编译 Go 代码并进行压缩），请耐心等待，直到你看到 `Successfully tagged ...` 的信息。

### 第三步：登录并推送到 Docker Hub

1.  登录到 Docker Hub：

    ```bash
    docker login
    ```

    终端会提示你输入用户名和密码（或访问令牌）。

2.  推送你刚刚在本地构建好的镜像到 Docker Hub。请确保这里的镜像名称和标签与上一步构建时使用的完全一致。

    ```bash
    docker push 你的 DockerHub 用户名/openlist:latest
    ```

3.  上传完成后，你可以登录 Docker Hub 网站，在你的仓库中查看这个新的镜像。

### 第四步：在 ClawCloud 中使用新镜像

1.  回到你的 ClawCloud 应用配置界面。
2.  在 "Basic" 信息卡片中，找到 "Image" 字段。
3.  将原来的 `openlistteam/openlist:beta` 修改为你自己的镜像地址：`你的 DockerHub 用户名/openlist:latest`。
4.  保存配置并让 ClawCloud 重新部署你的应用。

### 第五步：ClawCloud 环境配置参考

根据图片信息，以下是 ClawCloud 中的配置参考：

#### 基本配置

- **镜像**：用户名/openlist:latest（替换为你的镜像）
- **CPU 限制**：0.2 Core
- **内存限制**：256 Mi

#### 环境变量

| 变量名 | 值            |
| ------ | ------------- |
| TZ     | Asia/Shanghai |
| PUID   | 0             |
| PGID   | 0             |
| UMASK  | 022           |

#### 存储配置

- **/etc/openlist**：6 Gi （仅参考）

确保在部署时正确配置这些参数，特别是存储路径应该挂载到容器内的 `/etc/openlist` 目录。

---

English | [中文](./README_cn.md) | [日本語](./README_ja.md) | [Contributing](./CONTRIBUTING.md) | [CODE OF CONDUCT](./CODE_OF_CONDUCT.md)

## Features

- [x] Multiple storages
  - [x] Local storage
  - [x] [Aliyundrive](https://www.alipan.com/)
  - [x] OneDrive / Sharepoint ([global](https://www.office.com/), [cn](https://portal.partner.microsoftonline.cn),de,us)
  - [x] [189cloud](https://cloud.189.cn) (Personal, Family)
  - [x] [GoogleDrive](https://drive.google.com/)
  - [x] [123pan](https://www.123pan.com/)
  - [x] FTP / SFTP
  - [x] [PikPak](https://www.mypikpak.com/)
  - [x] [S3](https://aws.amazon.com/s3/)
  - [x] [Seafile](https://seafile.com/)
  - [x] [UPYUN Storage Service](https://www.upyun.com/products/file-storage)
  - [x] WebDav(Support OneDrive/SharePoint without API)
  - [x] Teambition([China](https://www.teambition.com/),[International](https://us.teambition.com/))
  - [x] [Mediatrack](https://www.mediatrack.cn/)
  - [x] [139yun](https://yun.139.com/) (Personal, Family, Group)
  - [x] [YandexDisk](https://disk.yandex.com/)
  - [x] [BaiduNetdisk](http://pan.baidu.com/)
  - [x] [Terabox](https://www.terabox.com/main)
  - [x] [UC](https://drive.uc.cn)
  - [x] [Quark](https://pan.quark.cn)
  - [x] [Thunder](https://pan.xunlei.com)
  - [x] [Lanzou](https://www.lanzou.com/)
  - [x] [ILanzou](https://www.ilanzou.com/)
  - [x] [Aliyundrive share](https://www.alipan.com/)
  - [x] [Google photo](https://photos.google.com/)
  - [x] [Mega.nz](https://mega.nz)
  - [x] [Baidu photo](https://photo.baidu.com/)
  - [x] SMB
  - [x] [115](https://115.com/)
  - [x] Cloudreve
  - [x] [Dropbox](https://www.dropbox.com/)
  - [x] [FeijiPan](https://www.feijipan.com/)
  - [x] [dogecloud](https://www.dogecloud.com/product/oss)
  - [x] [Azure Blob Storage](https://azure.microsoft.com/products/storage/blobs)
- [x] Easy to deploy and out-of-the-box
- [x] File preview (PDF, markdown, code, plain text, ...)
- [x] Image preview in gallery mode
- [x] Video and audio preview, support lyrics and subtitles
- [x] Office documents preview (docx, pptx, xlsx, ...)
- [x] `README.md` preview rendering
- [x] File permalink copy and direct file download
- [x] Dark mode
- [x] I18n
- [x] Protected routes (password protection and authentication)
- [x] WebDav (waiting for detail documents)
- [ ] Docker Deploy (rebuilding)
- [x] Cloudflare Workers proxy
- [x] File/Folder package download
- [x] Web upload(Can allow visitors to upload), delete, mkdir, rename, move and copy
- [x] Offline download
- [x] Copy files between two storage
- [x] Multi-thread downloading acceleration for single-thread download/stream

## Document

- https://docs.oplist.org
- https://docs.openlist.team

## Demo

N/A (to be rebuilt)

## Discussion

Please refer to [_Discussions_](https://github.com/OpenListTeam/OpenList/discussions) for raising general questions, **_Issues_ is for bug reports and feature requests only.**

## Contributors

Thanks goes to these wonderful people:

[![Contributors](https://contrib.rocks/image?repo=OpenListTeam/OpenList)](https://github.com/OpenListTeam/OpenList/graphs/contributors)

## License

The `OpenList` is open-source software licensed under the AGPL-3.0 license.

## Disclaimer

- This program is a free and open source project. It is designed to share files on the network disk, which is convenient for downloading and learning Golang. Please abide by relevant laws and regulations when using it, and do not abuse it;
- This program is implemented by calling the official sdk/interface, without destroying the official interface behavior;
- This program only does 302 redirect/traffic forwarding, and does not intercept, store, or tamper with any user data;
- Before using this program, you should understand and bear the corresponding risks, including but not limited to account ban, download speed limit, etc., which is none of this program's business;
- If there is any infringement, please contact [OpenListTeam](https://github.com/OpenListTeam), and it will be dealt with in time.

---

> [@GitHub](https://github.com/OpenListTeam) · [Telegram Group](https://t.me/OpenListTeam) · [Telegram Channel](https://t.me/OpenListOfficial)
