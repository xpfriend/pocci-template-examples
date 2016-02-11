setup.zabbix.yml
================
Zabbix サーバを作成するセットアップファイルの例。

Pocci-box の Zabbix 連携機能を意識したテンプレート (Template Pocci)
をインポート済みの状態で起動する。


利用方法
--------
1.  環境変数 **POCCI_TEMPLATE** に
    `"template https://github.com/xpfriend/pocci-template-examples.git"` を指定する。

    ```bash
    export POCCI_TEMPLATE="template https://github.com/xpfriend/pocci-template-examples.git"
    ```

1.  引数に `setup-files/extra/setup.zabbix.yml` を指定して `./create-service`
    を実行する。
1.  ブラウザを利用するPCの hosts ファイルに `zabbix.pocci.test` を登録し、
    `http://zabbix.pocci.test/` でアクセスする。
1.  ユーザーID: `admin`、パスワード: `zabbix` でログインできる。

*   同一VM上のDockerコンテナやDockerホスト上のZabbixエージェントと通信を行いたい場合、
    `docker inspect poccis_zabbix_1 |grep IPAddress` を実行して、
    Zabbix ServerコンテナのIPアドレスを調べ、
    Zabbix エージェント側設定ファイルの
    `Server=` にそのIPアドレスを指定してください。
    (IPアドレス指定が間違っている場合、Zabbixサーバ側からエージェント側に対する通信が
    拒否されます)


パラメタ
--------
*   **zabbix.dbUser:**  データベース接続ユーザー名。
    *   デフォルトは `username`
    *   環境変数: `ZABBIX_DB_USER`
*   **zabbix.dbPassword:**  データベース接続時のパスワード。
    *   デフォルトは `my_password`
    *   環境変数: `ZABBIX_DB_PASS`


テンプレート実装内容
--------------------
`services/core/zabbix` ディレクトリ。

### docker-compose.yml.template
Zabbix 標準の Zabbix サーバイメージとデータベースイメージを使用。

`10051`ポートを公開する。

### nginx.conf.template
Pocci標準のリバースプロキシからアクセスできるようにするための設定。


### update-container.sh, import-pocci-template.sh
Pocci-box の Zabbix 連携機能を意識したテンプレート (Template Pocci)
を Zabbix Server にインポートする。


### js/zabbix.js
setup ファイルの **zabbix.dbUser**, **zabbix.dbPassword**  パラメタで指定された値を
それぞれ環境変数**ZABBIX_DB_USER**, **ZABBIX_DB_PASS** に格納する。

その他の環境変数 (`ZABBIX_URL`, `ZABBIX_PROTOCOL`, `ZABBIX_HOST`, `ZABBIX_PORT`)
についてはお決まりのパターンに則って追加したが、必要性はあまりないかも。
