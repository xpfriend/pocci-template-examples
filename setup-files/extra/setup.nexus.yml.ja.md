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
            Jenkins を利用したい場合は。以下のように `+jenkins` を引数に追加する。

            ```bash
            ./create-service setup-files/extra/setup.nexus.yml +jenkins
            ```

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
#### java-lib (GitLab CI でビルドする場合)
`example-nexus/java-lib` リポジトリにプッシュを行うとビルドジョブが実行され、
そこで作成された jar ファイルが Nexus サーバにデプロイされる。

`example-nexus/java-lib` のビルドジョブは終了時に
`example-nexus/java-app` のビルドを呼び出す。
`example-nexus/java-app` のコンパイル時には
Nexus サーバから `java-lib` の jar ファイルがダウンロードされる。

##### 事前準備
上記のようなジョブ実行のためには以下の事前準備が必要となる。

1.  example-nexus/java-app の Triggers で、ビルドトリガーを追加し、作成されたトークンをメモする。
1.  example-nexus/java-lib の Variables で、以下の環境変数を定義する。
    *   **MAVEN_DEPLOY_USERNAME** : admin
    *   **MAVEN_DEPLOY_PASSWORD** : admin123
    *   **BUILD_TRIGGER_OF_JAVA_APP** : example-nexus/java-app のビルドトリガーを指定した URL。  
        例:

        ```
        http://gitlab.pocci.test/api/v3/projects/2/trigger/builds?token=トークン&ref=master
        ```

#### java-lib (Jenkins でビルドする場合)
Jenkins でビルドジョブ `java-lib` を実行すると、
作成された jar ファイルが Nexus サーバにデプロイされる。

ビルドジョブ `java-lib` は終了時にビルドジョブ `java-app` を呼び出す。
`java-app` のコンパイル時には Nexus サーバから `java-lib` の
jar ファイルがダウンロードされる。

##### 事前準備
上記のようなジョブ実行のためには以下の事前準備が必要となる。

1.  Jenkinsの管理 - システムの設定の「グローバルプロパティ - 環境変数」で以下の環境変数を定義する。
    *   **MAVEN_DEPLOY_USERNAME** : admin
    *   **MAVEN_DEPLOY_PASSWORD** : admin123
    *   **BUILD_TRIGGER_OF_JAVA_APP** : java-app ジョブをビルドするための URL。  
        例:

        ```
        http://jenkinsci:password@jenkins.pocci.test/job/java-app/build
        ```

#### nodejs-lib (GitLab CI でビルドする場合)
`example-nexus/nodejs-lib` リポジトリにプッシュを行うとビルドジョブが実行され、
nodejs-lib は Nexus サーバにデプロイされる。

`example-nexus/nodejs-lib` のビルドジョブは終了時に
`example-nexus/nodejs-app` のビルドを呼び出す。
`example-nexus/nodejs-app` のビルド実行時には
Nexus サーバから `nodejs-lib` がダウンロードされる。

##### 事前準備
上記のようなジョブ実行のためには以下の事前準備が必要となる。

1.  example-nexus/nodejs-app の Triggers で、ビルドトリガーを追加し、作成されたトークンをメモする。
1.  example-nexus/nodejs-lib の Variables で、以下の環境変数を定義する。
    *   **NPM_USER** : admin
    *   **NPM_PASS** : admin123
    *   **NPM_EMAIL** : admin@example.org
    *   **BUILD_TRIGGER_OF_NODEJS_APP** : example-nexus/nodejs-app のビルドトリガーを指定した URL。  
        例:

        ```
        http://gitlab.pocci.test/api/v3/projects/4/trigger/builds?token=トークン&ref=master
        ```

#### nodejs-lib (Jenkins でビルドする場合)
Jenkins でビルドジョブ `nodejs-lib` を実行すると、
作成された jar ファイルが Nexus サーバにデプロイされる。

ビルドジョブ `nodejs-lib` は終了時にビルドジョブ `nodejs-app` を呼び出す。
`nodejs-app` のビルド実行時には Nexus サーバから `nodejs-lib` がダウンロードされる。

##### 事前準備
上記のようなジョブ実行のためには以下の事前準備が必要となる。

1.  Jenkinsの管理 - システムの設定の「グローバルプロパティ - 環境変数」で以下の環境変数を定義する。
    *   **NPM_USER** : admin
    *   **NPM_PASS** : admin123
    *   **NPM_EMAIL** : admin@example.org
    *   **BUILD_TRIGGER_OF_NODEJS_APP** : nodejs-app ジョブをビルドするための URL。  
        例:

        ```
        http://jenkinsci:password@jenkins.pocci.test/job/nodejs-app/build
        ```


テンプレート実装内容
--------------------
### サンプルコード
`code/example-nexus` ディレクトリ。

#### java-lib
このディレクトリにあるソースコードをコンパイルして作成した
jar ファイルが Nexus サーバにデプロイされる。

##### java-lib/build.sh
`mvn deploy` を実行し、作成した jar ファイルを Nexus サーバにデプロイする。

##### java-lib/jenkins-config.xml
Jenkins を用いて `java-lib` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行し、終了後に 環境変数 `BUILD_TRIGGER_OF_JAVA_APP`
に設定されている URL にアクセスすることにより、
`java-app` ジョブを起動する。

##### java-lib/.gitlab-ci.yml
GitLab CI を用いて `java-lib` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行し、終了後に 環境変数 `BUILD_TRIGGER_OF_JAVA_APP`
に設定されている URL にアクセスすることにより、
`java-app` ジョブを起動する。


##### java-lib/pom.xml
**distributionManagement** にデプロイ先URL (Nexus サーバ) の指定を行っている。

##### java-lib/deploy-settings.xml
デプロイ時に利用するユーザーID、パスワードの環境変数
(MAVEN_DEPLOY_USERNAME, MAVEN_DEPLOY_PASSWORD) 参照設定をしている。


#### java-app
Nexus サーバにデプロイされた **java-lib の jar ファイル**
を使用するコードを格納したディレクトリ。

##### java-app/build.sh
`mvn test` を実行する。

##### java-app/jenkins-config.xml
Jenkins を用いて `java-app` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行する。

##### java-app/.gitlab-ci.yml
GitLab CI を用いて `java-app` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行する。

##### java-app/pom.xml
`java-lib` に対する dependency が設定されている。


#### nodejs-lib
このディレクトリにあるソースコードが Nexus サーバにデプロイされる。

##### nodejs-lib/build.sh
Nexus サーバへのデプロイのため、以下の処理を行っている
1.  `npm-cli-login` コマンドを呼び出し、Nexus サーバへのログイン設定を行う。
    (このコマンドを呼び出す際には、事前に環境変数 NPM_USER, NPM_PASS, NPM_EMAIL
    を設定しておく必要がある)
1.  `npm publish` コマンドを呼び出し、Nexus サーバへのへのデプロイを行う。

##### nodejs-lib/jenkins-config.xml
Jenkins を用いて `nodejs-lib` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行し、終了後に 環境変数 `BUILD_TRIGGER_OF_NODEJS_APP`
に設定されている URL にアクセスすることにより、
`nodejs-app` ジョブを起動する。

##### nodejs-lib/.gitlab-ci.yml
GitLab CI を用いて `nodejs-lib` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行し、終了後に 環境変数 `BUILD_TRIGGER_OF_NODEJS_APP`
に設定されている URL にアクセスすることにより、
`nodejs-app` ジョブを起動する。


#### nodejs-app
Nexus サーバにデプロイされた **nodejs-lib**
を使用するコードを格納したディレクトリ。

##### nodejs-app/build.sh
`npm install` で
Nexus サーバにデプロイされた **nodejs-lib**
を取得する。

##### nodejs-app/jenkins-config.xml
Jenkins を用いて `nodejs-app` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行する。

##### nodejs-app/.gitlab-ci.yml
GitLab CI を用いて `nodejs-app` のビルドジョブ実行を行うための設定ファイル。  
`build.sh` を実行する。

##### nodejs-app/package.json
`nodejs-lib` に対する dependency が設定されている。

