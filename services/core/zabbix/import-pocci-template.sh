#!/bin/bash
set -xe

ZABBIX_AUTH=`
    curl -X POST -H "Content-Type: application/json-rpc" http://zabbix.pocci.test/api_jsonrpc.php \
    -d '{"jsonrpc":"2.0","method":"user.login","id":1,"auth":null,"params":{"user":"admin", "password":"zabbix"}}' \
    | jq .result
`

curl -X POST -H "Content-Type: application/json-rpc" http://zabbix.pocci.test/api_jsonrpc.php \
-d '{
    "jsonrpc": "2.0",
    "method": "configuration.import",
    "params": {
        "format": "xml",
        "rules": {
            "groups": {
                "createMissing": true
            },
            "templates": {
                "createMissing": true,
                "updateExisting": true
            },
            "templateScreens": {
                "createMissing": true,
                "updateExisting": true
            },
            "templateLinkage": {
                "createMissing": true
            },
            "applications": {
                "createMissing": true
            },
            "items": {
                "createMissing": true,
                "updateExisting": true
            },
            "discoveryRules": {
                "createMissing": true,
                "updateExisting": true
            },
            "triggers": {
                "createMissing": true,
                "updateExisting": true
            },
            "graphs": {
                "createMissing": true,
                "updateExisting": true
            }
        },
        "source": "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<zabbix_export>
    <version>2.0</version>
    <date>2016-01-30T02:24:15Z</date>
    <groups>
        <group>
            <name>Linux servers</name>
        </group>
    </groups>
    <templates>
        <template>
            <template>Template Pocci</template>
            <name>Template Pocci</name>
            <description/>
            <groups>
                <group>
                    <name>Linux servers</name>
                </group>
            </groups>
            <applications/>
            <items>
                <item>
                    <name>Alive monitoring of docker processes</name>
                    <type>2</type>
                    <snmp_community/>
                    <multiplier>0</multiplier>
                    <snmp_oid/>
                    <key>pocci.docker.process</key>
                    <delay>0</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>4</value_type>
                    <allowed_hosts/>
                    <units/>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Processes</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Disk usage</name>
                    <type>2</type>
                    <snmp_community/>
                    <multiplier>0</multiplier>
                    <snmp_oid/>
                    <key>pocci.disk.usage</key>
                    <delay>0</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>4</value_type>
                    <allowed_hosts/>
                    <units/>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Filesystems</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Pocci backup status</name>
                    <type>2</type>
                    <snmp_community/>
                    <multiplier>0</multiplier>
                    <snmp_oid/>
                    <key>pocci.backup</key>
                    <delay>0</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>4</value_type>
                    <allowed_hosts/>
                    <units/>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>General</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
            </items>
            <discovery_rules/>
            <macros/>
            <templates>
                <template>
                    <name>Template OS Linux</name>
                </template>
            </templates>
            <screens/>
        </template>
    </templates>
    <triggers>
        <trigger>
            <expression>(({Template Pocci:pocci.disk.usage.regexp(^1:)})&lt;&gt;0)</expression>
            <name>Free disk space is less than 10% on volume</name>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description/>
            <type>1</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>(({Template Pocci:pocci.backup.regexp(^2:)})&lt;&gt;0)</expression>
            <name>Pocci backup failed</name>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description/>
            <type>1</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>(({Template Pocci:pocci.docker.process.regexp(^2:)})&lt;&gt;0)</expression>
            <name>There are terminated docker processes</name>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description/>
            <type>1</type>
            <dependencies/>
        </trigger>
    </triggers>
</zabbix_export>
"
    },
    "auth": '${ZABBIX_AUTH}',
    "id": 1
}'
