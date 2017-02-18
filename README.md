# Lego

稍微解析下 `specs repo` 的意思：`https://github.com/CocoaPods/Specs.git` 是 CocoaPods 官方的 `specs repo`，平时我们用 `pod trunk push podName.podspec` 来发布新版本，其实就是向此 `repo` 添加一个新版本的 `podName.podspec`。

比如 MonkeyKing 的已添加的版本 [Specs](https://github.com/CocoaPods/Specs/tree/master/Specs/f/6/5/MonkeyKing)

在此 [Specs](https://github.com/CocoaPods/Specs/tree/master/Specs/f/6/5/MonkeyKing) 里面，列举所有 MonkeyKing 已经 release 的版本。

[CocoaPods Specs](https://github.com/CocoaPods/Specs) 是线上版，在我们本地，其还是也有这么个 `repo`，执行下面的命令就可以看到，其中 `master` 相对于 CocoaPods 官方的 `repo`
```
cd ~/.cocoapods/repos && ls
```


1. 在 `ConfigPrivatePod/config.sh` 文件里，填写 `httpsRepo`, `sshRepo`, `specsRepo`, `homePage`
> 当然，在这里填写这4个默认参数的前提是，想把全部模块都放在同一个 repo 里面，如果打算一个模块一个 repo，请参考 Mr.Casa 的[在现有工程中实施基于CTMediator的组件化方案](http://casatwy.com/modulization_in_action.html)

