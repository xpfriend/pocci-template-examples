setup.serverspec.yml
====================
Serverspec 実行用ワークスペース (Jenkinsスレーブ) を作成するセットアップファイルの例。

利用方法
--------
### Pocci のコマンドでセットアップする場合
1.  環境変数 **POCCI_TEMPLATE** に
    `"template https://github.com/xpfriend/pocci-template-examples.git"` を指定する。

    ```bash
    export POCCI_TEMPLATE="template https://github.com/xpfriend/pocci-template-examples.git"
    ```

1.  引数に `setup-files/ws/setup.serverspec.yml` を指定して `./create-service`
    を実行する。

### Pocci-box でセットアップする場合
1.  environment.sh に以下の記述を行い、VMの作成を行う。
    ```bash
    export template="template https://github.com/xpfriend/pocci-template-examples.git"
    export service_type=setup-files/ws/setup.serverspec.yml
    ```

### テスト用ジョブの実行方法
セットアップが終了すると、Jenkins上に テスト用ジョブ (example-serverspec) が作成される。
このジョブで実行されるテストプログラムは gitlab コンテナを対象にしているため、
gitlab コンテナに対する SSH 接続設定を事前に行う必要がある。

**SSH 接続設定の例:**

1.  以下のコマンドを実行し、gitlab コンテナにパスワードなしで SSH ログインできるように設定する。

    ```
    docker exec -it poccis_gitlab_1 mkdir /root/.ssh
    docker exec -it poccis_gitlab_1 chmod 700 /root/.ssh
    docker cp ${POCCI_DIR}/config/.ssh/id_rsa.pub poccis_gitlab_1:/root/.ssh/authorized_keys
    ```

1.  `${POCCI_DIR}/config/.ssh/config` ファイルを作成して以下のように記述する

    ```
    Host gitlab
      HostName IPアドレス
      User root
      StrictHostKeyChecking no
    ```

    *   **IPアドレス**は `docker inspect poccis_gitlab_1 |grep IPAddress` で調査できる。

#### ポイント
`${POCCI_DIR}/config/.ssh` は、ワークスペース (serverspec コンテナ)
の `~/.ssh` としてマウントされるため、
上記の作業は serverspec コンテナ上の `~/.ssh` に対する作業と同じ意味を持つ。


テンプレート実装内容
--------------------
`code/example/example-serverspec` ディレクトリ。

サンプルのテストコードが格納されており、これらのファイルはセットアップ時に
Gitlab 上に **example/example-serverspec** プロジェクトとして登録される。

### build.sh
テスト用 Jenkins ジョブ (example-serverspec) から呼び出されるスクリプト。  
`rake spec` を実行してテストプログラムを起動する。

### jenkins-config.xml
Jenkins ジョブ設定。  
**serverspec** スレーブ上で **build.sh** を起動する。

### spec/gitlab/user_spec.rb
テストプログラム本体。
