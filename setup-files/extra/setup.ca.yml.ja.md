setup.ca.yml
================
プライベートCA (認証局) サービスを作成するセットアップファイルの例。

利用方法
--------
### Pocci のコマンドでセットアップする場合
1.  環境変数 **POCCI_TEMPLATE** に
    `"template https://github.com/xpfriend/pocci-template-examples.git"` を指定する。

    ```bash
    export POCCI_TEMPLATE="template https://github.com/xpfriend/pocci-template-examples.git"
    ```

1.  引数に `setup-files/extra/setup.ca.yml` を指定して `./create-service`
    を実行する。

### Pocci-box でセットアップする場合
1.  environment.sh に以下の記述を行い、VMの作成を行う。
    ```bash
    export template="template https://github.com/xpfriend/pocci-template-examples.git"
    export service_type=setup-files/extra/setup.ca.yml
    ```

### CA サービスの利用方法
`/sign` に POST メソッドで CSR を渡せば証明書を返す。

**pocci サーバの CSR で証明書を取得する例:**
```bash
# CSRが格納されているディレクトリに移動する
cd ${POCCI_DIR}/config/nginx/ssl/public

# 既存の証明書をバックアップする
cp server.crt server.crt.backup

# CAサービスを呼び出して証明書を取得する
curl -X POST http://ca.pocci.test/sign --data-binary @server.csr -H "Content-Type: text/plain" > server.crt

# サービスを再起動する
${POCCI_DIR}/bin/restart-service
```


テンプレート実装内容
--------------------
`services/core/ca` ディレクトリ。

### docker-compose.yml.template
workspace-nodejs による Node.js アプリケーション実行環境の定義。

アプリケーションプログラムが格納されている `${POCCI_DIR}/config/volumes/ca` を `/app` に、
証明書作成時に利用するファイルが格納されている `${POCCI_DIR}/config/nginx/ssl` を `/ssl` にマウントしている。

`/app` ディレクトリ上に存在する `start.sh` を起動する。


### nginx.conf.template
Pocci標準のリバースプロキシからアクセスできるようにするための設定。


### js/ca.js
その他の環境変数 (`CA_URL`, `CA_PROTOCOL`, `CA_HOST`, `CA_PORT`)
についてお決まりのパターンに則って追加したが、必要性はあまりないかも。

### volumes
`${POCCI_DIR}/config/volumes/ca` にコピーされるディレクトリ。


### volumes/sign.sh
**openssl ca** コマンドにより証明書の作成を行う。

### volumes/server.js
CSRのPOSTリクエストを受け付けるWebアプリケーション。
リクエストのたびに `sign.sh` を起動して、作成された証明書をクライアントに返す。

### volumes/start.sh
依存ライブラリを取得 (`npm install`) して、`server.js` を起動する。
