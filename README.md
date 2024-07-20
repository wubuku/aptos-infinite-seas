# README



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

