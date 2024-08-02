# README

English | [中文版](./README_CN.md)


This repository contains the Aptos version of the Infinite Seas on-chain contract,
as well as the off-chain query service (sometimes called indexer).

The Aptos version of Infinite Seas was ported from the [Sui version](https://github.com/InfiniteSeas/sui-infinite-seas).

Thanks to the use of the dddappp low-code development platform as the engine for Inifinite Seas,
both the development of the Sui version and the migration to the Aptos version were amazingly quick and easy.

If you want to find out how to use dddappp as a fully on-chain game engine,
you can refer to this getting-started example: https://github.com/wubuku/aptos-constantinople


## Programming

### Writing DDDML model files

The model files are located in the directory `. /dddml`.

> **Tip**
>
> About DDDML, here is an introductory article: ["Introducing DDDML: The Key to Low-Code Development for Decentralized Applications"](https://github.com/wubuku/Dapp-LCDP-Demo/blob/main/IntroducingDDDML.md).


### Generating code

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

### Implementing business logic

[TBD]

## Test application

### Deploy contract

Go into the following directories in order:

* `aptos-contracts/infinite-seas-common`
* `aptos-contracts/infinite-seas-map`
* `aptos-contracts/infinite-seas-production`
* `aptos-contracts/infinite-seas`

Execute the following command (execute once in each directory):

```shell
aptos move publish --named-addresses infinite_seas_map=default,infinite_seas_production=default,infinite_seas_common=default,infinite_seas=default --included-artifacts none --skip-fetch-latest-git-deps --assume-yes
```


