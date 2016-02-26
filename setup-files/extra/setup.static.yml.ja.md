setup.static.yml
================
静的ドキュメント公開用サービスを作成するセットアップファイルの例。

利用方法
--------
1.  (必要に応じて)セットアップファイルの static.dir を変更する。
1.  static.dir で指定したディレクトリにWeb公開したいファイルを格納する。
1.  以下の手順でPocciの構成を行う。
    *   **Pocci のコマンドでセットアップする場合:**
        1.  環境変数 **POCCI_TEMPLATE** に
            `"template https://github.com/xpfriend/pocci-template-examples.git"` を指定する。

            ```bash
            export POCCI_TEMPLATE="template https://github.com/xpfriend/pocci-template-examples.git"
            ```

        1.  引数に `setup-files/extra/setup.static.yml` を指定して `./create-service`
            を実行する。
    *   **Pocci-box でセットアップする場合:**
        1.  environment.sh に以下の記述を行い、VMの作成を行う。
            ```bash
            export template="template https://github.com/xpfriend/pocci-template-examples.git"
            export service_type=setup-files/extra/setup.static.yml
            ```
1.  ブラウザを利用するPCの hosts ファイルに `static.pocci.test` を登録し、
    `http://static.pocci.test/` でアクセスする。


パラメタ
--------
*   **static.dir:**  
    公開するドキュメントを格納するディレクトリ。  
    Dockerホストマシンのディレクトリを絶対パスで指定する。
    *   デフォルトは ${POCCI_DIR}/config/volumes/static
    *   環境変数: `STATIC_DIR`


テンプレート実装内容
--------------------
`services/core/static` ディレクトリ。

### docker-compose.yml.template
Nginx イメージを使用したシンプルなWebサーバの定義。

static.dir で指定されたディレクトリを `/usr/share/nginx/html`
(デフォルトのドキュメントルートとなるディレクトリ) にマウントする。

### nginx.conf.template
Pocci標準のリバースプロキシからアクセスできるようにするための設定。

この構成ではNginxは2つ（リバースプロキシ用と静的ドキュメント公開用）
起動することになる。

### create-config.sh
環境変数 `${STATIC_DIR}` で指定されたディレクトリの存在をチェックし、
もし存在しない場合はディレクトリを作成する。

また、`${STATIC_DIR}/index.html` ファイルが存在しない場合は作成する。


### js/static.js
setup ファイルの **static.dir**  パラメタで指定された値を環境変数
**STATIC_DIR** に格納する。

その他の環境変数 (`STATIC_URL`, `STATIC_PROTOCOL`, `STATIC_HOST`, `STATIC_PORT`)
についてはお決まりのパターンに則って追加したが、必要性はあまりないかも。
