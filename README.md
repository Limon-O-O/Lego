# 一个仓库的模块化之路
正如标题，本文讲解的是如何在一个仓库进行模块化，当然，如果你想拆分一个模块对应一个仓库，也行，改改就是了。

本文主要记录：

1. Swift 项目怎样使用 Mediator 进行模块化
2. 使用 CocoaPods 管理模块
3. 发布私有库不使用 `pod repo push`，不进行验证，即使库编译不通过，也可以 release 新版本
4. Swift 的一些实践心得

本文分为三部分：

一、[目录解析](https://github.com/Limon-O-O/Lego#一lego-目录解析)

二、[实战](https://github.com/Limon-O-O/Lego#二实战)

三、[实践心得](https://github.com/Limon-O-O/Lego#三实践心得)

<br />

## 一、Lego 目录解析
```
Lego
├── ConfigPrivatePod
├── Frameworks
│   ├── EggKit
│   ├── LegoKit
│   └── Networking
├── Modules
│   ├── CTMediator+Door
│   ├── Door
│   ├── Lego
└── Specs
    ├── EggKit
    ├── LegoKit
    └── Networking
        └── 1.0.1
            └── Networking.podspec
```

1. `ConfigPrivatePod` 文件夹，存放着配置私有源的脚本
2. `Frameworks` 文件夹，存放着各种 `framework`，`EggKit` 代表公司各项目通用库，`LegoKit` 代表本项目各模块通用库
3. `Modules` 文件夹，存放着 `Lego` 项目的全部模块，其中 `Modules/Lego` 就是主模块
4. `Specs` 文件夹，存放着 `framework` 和 `模块` 的版本的 `podName.podspec`，即常说的 `Private Spec Repo`

<br />

## Config PrivatePod

```
ConfigPrivatePod
├── config.sh
└── templates
    ├── Podfile
    ├── module
    │   ├── extension
    │   │   ├── Mediator+Project.swift
    │   │   └── ProjectProtocol.swift
    │   └── target
    │       └── Target_Project.swift
    ├── pod.podspec
    ├── release.sh
    ├── update_version.sh
    └── version_compare.sh
```

`ConfigPrivatePod` 文件夹内含快速配置私有源的脚本。

`config.sh` 新创建 `Pod库` 时使用，作用： 

1. 为 `Pod库` 配置基本文件，如 `pod.podspec`
2. 配置 `release.sh` 脚步，需要为 `Pod库` 发布新版本时，直接敲命令 `./release.sh` 即可
3. 为模块配置与 `Mediator` 关联的文件，如：`Target_Project.swift`, `ProjectProtocol.swift`, `Mediator+Project.swift`

> 当然，在这里填写这4个默认参数的前提是，想把全部模块都放在同一个 `仓库` 里面，如果打算一个模块一个 `仓库`，请参考 Mr.Casa 的[《在现有工程中实施基于CTMediator的组件化方案》](http://casatwy.com/modulization_in_action.html)

<br />

## 关于 CocoaPods Specs

大家都知道 CocoaPods 可以指定第三方依赖的版本，比如：`pod 'MonkeyKing', '~> 1.2.1'`

那 CocoaPods 是如何管理所有已经发布了的版本？
答案就在此 [CocoaPods Specs](https://github.com/CocoaPods/Specs) 仓库。Specs 仓库里面存放着所有已经发布了的版本。

比如 MonkeyKing 的已发布的版本 [Specs](https://github.com/CocoaPods/Specs/tree/master/Specs/f/6/5/MonkeyKing)，在此 [Specs](https://github.com/CocoaPods/Specs/tree/master/Specs/f/6/5/MonkeyKing) 里面，列举 MonkeyKing 所有已经 released 的版本。

MonkeyKing 在 `Specs` 文件夹的呈现：

```
└── Specs
    └── MonkeyKing
        └── 0.0.1
            └── MonkeyKing.podspec.json
        .......
            
        └── 0.9.3
            └── MonkeyKing.podspec.json
        └── 1.1.0
            └── MonkeyKing.podspec.json
        └── 1.2.0
            └── MonkeyKing.podspec.json
        └── 1.2.1
            └── MonkeyKing.podspec.json
        └── 1.2.2
            └── MonkeyKing.podspec.json
```


`https://github.com/CocoaPods/Specs.git` 是 CocoaPods 官方的 `Specs` 仓库，平时我们用 `pod trunk push podName.podspec` 来发布新版本，其实就是向此仓库添加一个名为 `podName.podspec` 的文件。

[CocoaPods Specs](https://github.com/CocoaPods/Specs) 是线上版，在我们本地，其实也有这个仓库，执行下面的命令就可以看到，其中 `master` 对应 CocoaPods 官方的 `Specs` 仓库。
```
cd ~/.cocoapods/repos && ls
```

而在此教程的 `Lego` 仓库里，有一个文件夹 [Specs](https://github.com/Limon-O-O/Lego/tree/master/Specs)，此文件夹里存放着 `framework` 和模块 Pod 的 `podspec`，相当于 Private Spec Repo
> 更多详情请查看官方资料：[Private Pods](https://guides.cocoapods.org/making/private-cocoapods.html)


<br />

## 二、实战


### 实战前夕

1. 新建一个仓库，就先名为 `Lego`，页面先不急着关，打开 `Terminal`，把刚刚新建的仓库 `clone` 到本地

2. 进入刚刚 `clone` 下来的文件夹，把 [ConfigPrivatePod](https://github.com/Limon-O-O/Lego/tree/master/ConfigPrivatePod) 文件夹放进去

3. 在 `./ConfigPrivatePod/config.sh` 文件里，填写 `httpsRepo`, `sshRepo`, `specsRepo`, `homePage`, `author`, `email`，[具体参考](https://github.com/Limon-O-O/Lego/blob/master/ConfigPrivatePod/config.sh#L3)

4. 新建三个文件夹 `Frameworks` `Modules` `Specs`，最终的结构如下：

```
Lego
├── ConfigPrivatePod
│   ├── config.sh
│   └── templates
│       ......
├── Frameworks
├── Modules
└── Specs
```

<br />

### 新建主模块和 Door 模块

##### 主模块 --- Lego
使用 Xcode 创建一个名为 `Lego` 的工程，放在 `Lego/Modules` 下，此工程就是我们的主模块。

##### Door 模块

若想新建一个 Door 模块，需要两个 `Pod库`，
1. Door业务Pod
2. 方便其它模块调用 Door业务 的 Mediator+Door 的 Pod。

> 这里多解释一句：Mediator+Door Pod 本质上只是一个方便方法，它对 Door Pod 不存在任何依赖

开始创建：

1. 同创建主模块一样，创建一个名为 `Door` 的工程，放在 `Lego/Modules` 下，此模块主打`注册登录`。
2. 再创建一个名为 `Mediator+Door` 的工程，同样放在 `Lego/Modules` 下，此工程主要为了方便其它模块调用 Door业务，本质就是通过 `Mediator` 利用`运行时`，找到在 `Door` 内相对应的方法。
3. 在 `ConfigPrivatePod` 下，执行 `./config.sh`，脚本会问你要一些信息。

配置 `Door` 工程：

```
Enter Project Name: Door

================================================
 1 :  Module
 2 :  Extension
 3 :  Framework
================================================

Enter Project Type Number: 1
```

配置 `Mediator+Door` 工程：

```
Enter Project Name: Door // 注：Project Name 也是 Door

================================================
 1 :  Module
 2 :  Extension
 3 :  Framework
================================================

Enter Project Type Number: 2
```

> 若配置模块工程，`Project Type Number` 输入 `1`，若配置 `模块Extension` 工程，输入 `2`，若配置普通的 `framework` 输入 `3`

配置完 `Door` 工程后，在 `Modules/Door/Door` 下，会多了一个也同样名为 `Door` 的文件夹，以后所有需要打包出去给别人用的都在此文件夹下，因为在 `Door.podspec` 文件内定义的源文件就指指定了此文件夹。

打开 `Door.xcodeproj`，把 `Modules/Door/Door/Door` 此文件夹工程里面。 `Mediator+Door` 工程同理。

`Door` 工程的目录简如下：

```
Door
├── Door
│   └── Door
│       ├── WelcomeViewController.swift
│       └── Targets
│           ├── Target_Door.swift
├── Door.xcodeproj
```

`Mediator+Door` 工程的目录简如下：

```
Mediator+Door
├── Mediator+Door
│   └── Mediator+Door
│       ├── Door.swift
│       ├── Mediator+Door.swift
├── Mediator+Door.xcodeproj
```
到此，`Door模块` 基本配置完成，可以前往 `主模块Lego` 引入它了。

<br />

### 在主模块使用 Door 模块

##### 在主模块引入 Door 模块

`Modules/Lego/Podfile`:

```
source 'https://github.com/Limon-O-O/Lego.git'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'Lego' do
    use_frameworks!

    # Door，在开发初期，先用相对路径，因为现在 CocoaPods 支持跨工程修改，便于开发
    pod "Mediator+Door", :path => "../Mediator+Door"
    pod "Door", :path => "../Door"
    
    # Me，若模块已经开发得差不多了，并 released 了，可从 Private Spec 拉取
    pod "Mediator+Me"
    pod "Me", '~> 1.0.1'
end

```

<br />

## 三、实践心得




