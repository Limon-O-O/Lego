# 一个人的模块化之路

## CocoaPods Specs

大家都知道 CocoaPods 可以指定第三方依赖的版本，比如：`pod 'MonkeyKing', '~> 1.2.1'`
那 CocoaPods 是如何管理所有已经发布了的版本？
答案就在此 [CocoaPods Specs](https://github.com/CocoaPods/Specs) 仓库。

Specs 仓库里面存放着所有已经发布了的版本。

比如 MonkeyKing 的已发布的版本 [Specs](https://github.com/CocoaPods/Specs/tree/master/Specs/f/6/5/MonkeyKing)，在此 [Specs](https://github.com/CocoaPods/Specs/tree/master/Specs/f/6/5/MonkeyKing) 里面，列举所有 MonkeyKing 已经 released 的版本。

`https://github.com/CocoaPods/Specs.git` 是 CocoaPods 官方的 `Specs` 仓库，平时我们用 `pod trunk push podName.podspec` 来发布新版本，其实就是向此仓库添加一个名为 `podName.podspec` 的文件。

[CocoaPods Specs](https://github.com/CocoaPods/Specs) 是线上版，在我们本地，其实也有这个仓库，执行下面的命令就可以看到，其中 `master` 对应 CocoaPods 官方的 `Specs` 仓库。
```
cd ~/.cocoapods/repos && ls
```

而在此教程的 `Lego` 仓库里，有一个文件夹 [Specs](https://github.com/Limon-O-O/Lego/tree/master/Specs)，此文件夹里存放着个人的 `framework` 的 `podspec`，相当于 Private Spec Repo
> 更多详情请查看官方资料：[Private Pods](https://guides.cocoapods.org/making/private-cocoapods.html)


1. 在 `ConfigPrivatePod/config.sh` 文件里，填写 `httpsRepo`, `sshRepo`, `specsRepo`, `homePage`
> 当然，在这里填写这4个默认参数的前提是，想把全部模块都放在同一个 repo 里面，如果打算一个模块一个 repo，请参考 Mr.Casa 的[在现有工程中实施基于CTMediator的组件化方案](http://casatwy.com/modulization_in_action.html)

