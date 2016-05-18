setup.taiga.yml
===============
Taiga サービスを作成するセットアップファイルの例。


利用方法
--------
1.  以下の手順でPocciの構成を行う。
    *   **Pocci のコマンドでセットアップする場合:**
        1.  環境変数 **POCCI_TEMPLATE** に
            `"template https://github.com/xpfriend/pocci-template-examples.git"` を指定する。

            ```bash
            export POCCI_TEMPLATE="template https://github.com/xpfriend/pocci-template-examples.git"
            ```

        1.  引数に `setup-files/extra/setup.taiga.yml` を指定して `./create-service`
            を実行する。
    *   **Pocci-box でセットアップする場合:**
        1.  environment.sh に以下の記述を行い、VMの作成を行う。

            ```bash
            export template="template https://github.com/xpfriend/pocci-template-examples.git"
            export service_type=setup-files/extra/setup.taiga.yml
            ```

1.  ブラウザを利用するPCの hosts ファイルに `taiga.pocci.test` を登録し、
    `http://taiga.pocci.test/` でアクセスする。
1.  LDAPに登録したユーザー (例: ユーザーID: `boze`、パスワード: `password`) でログインできる。



パラメタ
--------
*   **taiga.smtpDomain:** SMTPドメイン
    *   デフォルトは pocci.domain で指定したドメイン名
    *   環境変数: `TAIGA_SMTP_DOMAIN`
*   **taiga.smtpHost:** SMTPサーバホスト名
    *   デフォルトは `smtp.[pocci.domain で指定したドメイン名]`
    *   環境変数: `TAIGA_SMTP_HOST`
*   **taiga.smtpPort:** SMTPサーバポート番号
    *   デフォルトは `25`
    *   環境変数: `TAIGA_SMTP_PORT`
*   **taiga.mailAddress:** Taigaのメールアドレス
    *   デフォルトは pocci.adminMailAddress で指定したアドレス
    *   環境変数: `TAIGA_MAIL_ADDRESS`
*   **taiga.dbName:** Taiga が内部的に使用するデータベースの名前
    *   デフォルトは `gitlabhq_production`
    *   環境変数: `TAIGA_DB_NAME`
*   **taiga.dbUser:** Taiga が内部的に使用するデータベース接続時のユーザー名
    *   デフォルトは `gitlab`
    *   環境変数: `TAIGA_DB_USER`
*   **taiga.dbPassword:** Taiga が内部的に使用するデータベース接続時のパスワード
    *   デフォルトはランダムな文字列
    *   環境変数: `TAIGA_DB_PASS`


テンプレート実装内容
--------------------
`services/core/taiga` ディレクトリ。

### docker-compose.yml.template, taiga-front.Dockerfile, taiga-back.Dockerfile
Dockerコンテナ設定
*   [htdvisser/taiga-docker](https://github.com/htdvisser/taiga-docker) を使用。
*   LDAP連携を行うために、イメージのビルドを実行している

### fluent.conf.template
ログファイルの内容を fluentd コンテナに天とするための設定。

### nginx.conf.template
Pocci標準のリバースプロキシからアクセスできるようにするための設定。

### update-container.sh
データベースの初期設定を行う。

### js/taiga.js
データベースおよびメールアドレス関連の環境変数設定を行う。
