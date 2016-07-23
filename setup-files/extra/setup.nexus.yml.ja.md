setup.nexus.yml
================
Nexus サーバを作成するセットアップファイルの例。


利用方法
--------
### セットアップ方法
1.  以下の手順でPocciの構成を行う。
    *   **Pocci のコマンドでセットアップする場合:**
        1.  環境変数 **POCCI_TEMPLATE** に
            `"template https://github.com/xpfriend/pocci-template-examples.git"` を指定する。

            ```bash
            export POCCI_TEMPLATE="template https://github.com/xpfriend/pocci-template-examples.git"
            ```

        1.  引数に `setup-files/extra/setup.nexus.yml` を指定して `./create-service`
            を実行する。
    *   **Pocci-box でセットアップする場合:**
        1.  environment.sh に以下の記述を行い、VMの作成を行う。

            ```bash
            export template="template https://github.com/xpfriend/pocci-template-examples.git"
            export service_type=setup-files/extra/setup.nexus.yml
            ```

### Nexusサーバへのアクセス
1.  ブラウザを利用するPCの hosts ファイルに `nexus.pocci.test` を登録し、
    `http://nexus.pocci.test/` でアクセスする。
1.  ユーザーID: `admin`、パスワード: `admin123` でログインできる。

### Nexusサーバへのデプロイ実行
Jenkins でビルドジョブ `java-lib` を実行すると、
作成された jar ファイルが Nexus サーバにデプロイされる。

ビルドジョブ `java-lib` 終了後にはビルドジョブ `java-app` が実行され、
`java-app` のコンパイル時に Nexus サーバから `java-lib` の
jar ファイルがダウンロードされる。

テンプレート実装内容
--------------------
### サンプルコード
`code/example-nexus` ディレクトリ。

#### java-lib
このディレクトリにあるソースコードをコンパイルして作成した
jar ファイルが Nexus サーバにデプロイされる。

#### java-lib/build.sh
`mvn deploy` を実行し、作成した jar ファイルを Nexus サーバにデプロイする。

#### java-lib/jenkins-config.xml
Jenkins ジョブ `java-lib` の設定ファイル。
`build.sh` を実行し、終了後 `java-app` を呼び出す。

#### java-lib/pom.xml
**distributionManagement** にデプロイ先URL (Nexus サーバ) の指定を行っている。

#### java-app
Nexus サーバにデプロイされた **java-lib の jar ファイル**
を使用するコードを格納したディレクトリ。

#### java-lib/build.sh
`mvn test` を実行する。

#### java-lib/jenkins-config.xml
`build.sh` を実行する。

#### java-lib/pom.xml
`java-lib` に対する dependency が設定されている。


### サービステンプレート
`services/core/nexus` ディレクトリ。

#### docker-compose.yml.template
公式の Nexus イメージを使用した docker-compose ファイル。

#### nginx.conf.template
Pocci標準のリバースプロキシからアクセスできるようにするための設定。

#### settings.xml
Nexus サーバへのアクセス情報が設定された Maven 設定ファイル。

#### setup-workspace.sh
ワークスペースの初期化時に呼び出されるスクリプト。

**java ワークスペース** (Jenkinsスレーブ) の `~/.m2`
に `settings.xml` をコピーする。

#### js/nginx.js
環境変数
 (`NEXUS_URL`, `NEXUS_PROTOCOL`, `NEXUS_HOST`, `NEXUS_PORT`)
定義。
