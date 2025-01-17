# Infinite Search

## 项目介绍

基于[Search with Lepton](https://github.com/leptonai/search_with_lepton)项目，
将后端替换为了SpringBoot + LangChain4J，同时对信息处理流程做了一些调整。

感谢[Lepton](https://www.lepton.ai/)团队的杰出工作，揭开了RAG搜索的神秘面纱，实现了开源版的[Plexarity](https://www.perplexity.ai/)

## 信息处理流程

与Search Wth Lepton相比，我们提供了两种信息处理流程

### Brief模式
1. 使用搜索引擎API（如Google）搜索关键词，获取搜索结果
2. 将所有搜索结果的摘要信息合并为上下文整合入prompt
3. 将prompt提交给大语言模型，获取结果

### Detail模式
1. 使用搜索引擎API（如Google）搜索关键词，获取搜索结果
2. 将最前面两项搜索结果的网页内容和其余搜索结果的摘要内容存入向量数据库
3. 从向量数据库中检索出最相似的文本内容，作为上下文信息整合入prompt
4. 将prompt提交给大语言模型，获取结果

出于速度原因，默认采用的是Brief模式，如果需要更为详细的搜索结果，可以在配置文件中修改为Detail模式。

## 提升的关键

目前来看AI搜索已经有了一定效果，要进一步提升的话，我认为关键在于以下几点:

1. 如何转换用户的搜索关键词甚至语言以获取更为优质的搜索结果
2. 如何排除HTML中其他无关内容的干扰，提取出最准确的正文内容
3. 如何从向量数据库中检索出更为贴近和准确的内容
4. 如何让大语言模型处理更多的上下文信息

## 构建项目与运行项目

### 前置准备
1. OpenAI API
2. Google Search API
3. Java 21

把相应的信息填入到 `application-dev.properties`


### Build

```shell
./gradlew build -x test
```

### Run

```shell
java -jar build/libs/infinite-search-$version.jar
```

打开浏览器访问 http://localhost:8605