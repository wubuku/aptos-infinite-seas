# README

[English](./README.md) | 中文版


## 编写代码

### 编写 DDDML 模型文件

The model files are located in the directory `. /dddml`.

> **Tip**
>
> About DDDML, here is an introductory article: ["Introducing DDDML: The Key to Low-Code Development for Decentralized Applications"](https://github.com/wubuku/Dapp-LCDP-Demo/blob/main/IntroducingDDDML.md).


### 从模型文件生成代码

In repository root directory, run:

```shell
docker run \
-v .:/myapp \
wubuku/dddappp-aptos:master \
--dddmlDirectoryPath /myapp/dddml \
--boundedContextName Dddml.AptosInfiniteSeas \
--aptosMoveProjectDirectoryPath /myapp/aptos-contracts \
--boundedContextAptosPackageName InfiniteSeas \
--boundedContextAptosNamedAddress infinite_seas \
--boundedContextJavaPackageName org.dddml.aptosinfiniteseas \
--javaProjectsDirectoryPath /myapp/aptos-java-service \
--javaProjectNamePrefix aptosinfiniteseas \
--pomGroupId dddml.aptosinfiniteseas \
--enableMultipleMoveProjects
```

> **Hint**
>
> Sometimes you may need to remove old containers and images:
>
> ```shell
> docker rm $(docker ps -aq --filter "ancestor=wubuku/dddappp-aptos:master")
> docker rmi wubuku/dddappp-aptos:master
> ```

### 实现操作业务逻辑

[TBD]

## 测试应用


### 部署合约

在目录 `aptos-contracts/infinite-seas-common` 下，执行：

```shell
aptos move publish --named-addresses infinite_seas_map=default,infinite_seas_common=default,infinite_seas=default --included-artifacts none --skip-fetch-latest-git-deps --assume-yes
```

在目录 `aptos-contracts/infinite-seas-map` 下，执行：

```shell
aptos move publish --named-addresses infinite_seas_map=default,infinite_seas_common=default,infinite_seas=default --included-artifacts none --skip-fetch-latest-git-deps --assume-yes
```

在目录 `aptos-contracts/infinite-seas` 下，执行：

```shell
aptos move publish --named-addresses infinite_seas_map=default,infinite_seas_common=default,infinite_seas=default --included-artifacts none --skip-fetch-latest-git-deps --assume-yes
```

