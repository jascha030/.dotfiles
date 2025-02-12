return function()
    return {
        handlers = {
            -- Disable providers for intelephense.
            ['textDocument/publishDiagnostics'] = function() end,
        },
        settings = {
            intelephense = {
                format = {
                    enable = false,
                },
                diagnostics = {
                    enable = false,
                },
                -- "aerospike", "dio", "zmq", "zookeeper", "yar", "yaf", "xcache", "xxtea", "wddx", "uopz", "stomp", "suhosin", "snmp", "solr", "SaxonC", "rpminfo", "judy", "ming",
                stubs = {
                    'Core',
                    'Ev',
                    'FFI',
                    'LuaSandbox',
                    'PDO',
                    'Parle',
                    'Phar',
                    'Reflection',
                    'SPL',
                    'SQLite',
                    'SimpleXML',
                    'SplType',
                    'Zend OPcache',
                    'ZendCache',
                    'ZendDebugger',
                    'ZendUtils',
                    'amqp',
                    'apache',
                    'apcu',
                    'ast',
                    'bcmath',
                    'blackfire',
                    'bz2',
                    'calendar',
                    'cassandra',
                    'com_dotnet',
                    'couchbase',
                    'couchbase_v2',
                    'crypto',
                    'ctype',
                    'cubrid',
                    'curl',
                    'date',
                    'dba',
                    'decimal',
                    'dom',
                    'ds',
                    'enchant',
                    'event',
                    'exif',
                    'fann',
                    'ffmpeg',
                    'fileinfo',
                    'filter',
                    'fpm',
                    'ftp',
                    'gd',
                    'gearman',
                    'geoip',
                    'geos',
                    'gettext',
                    'gmagick',
                    'gmp',
                    'gnupg',
                    'grpc',
                    'hash',
                    'http',
                    'ibm_db2',
                    'iconv',
                    'igbinary',
                    'imagick',
                    'imap',
                    'inotify',
                    'interbase',
                    'intl',
                    'json',
                    'ldap',
                    'leveldb',
                    'libevent',
                    'libsodium',
                    'libvirt-php',
                    'libxml',
                    'lua',
                    'lzf',
                    'mailparse',
                    'mapscript',
                    'mbstring',
                    'mcrypt',
                    'memcache',
                    'memcached',
                    'meminfo',
                    'meta',
                    'mongo',
                    'mongodb',
                    'mosquitto-php',
                    'mqseries',
                    'msgpack',
                    'mssql',
                    'mysql',
                    'mysql_xdevapi',
                    'mysqli',
                    'ncurses',
                    'newrelic',
                    'oauth',
                    'oci8',
                    'odbc',
                    'openssl',
                    'parallel',
                    'pcntl',
                    'pcov',
                    'pcre',
                    'pdflib',
                    'pdo_ibm',
                    'pdo_mysql',
                    'pdo_pgsql',
                    'pdo_sqlite',
                    'pgsql',
                    'phpdbg',
                    'posix',
                    'pspell',
                    'pthreads',
                    'radius',
                    'rar',
                    'rdkafka',
                    'readline',
                    'recode',
                    'redis',
                    'regex',
                    'rrd',
                    'session',
                    'shmop',
                    'soap',
                    'sockets',
                    'sodium',
                    'sqlite3',
                    'sqlsrv',
                    'ssh2',
                    'standard',
                    'stats',
                    'superglobals',
                    'svm',
                    'svn',
                    'sybase',
                    'sync',
                    'sysvmsg',
                    'sysvsem',
                    'sysvshm',
                    'tidy',
                    'tokenizer',
                    'uuid',
                    'uv',
                    'v8js',
                    'win32service',
                    'winbinder',
                    'wincache',
                    'wordpress',
                    'woocommerce',
                    'acf-pro',
                    'acf-stubs',
                    'wordpress-globals',
                    'wp-cli',
                    'xdebug',
                    'xhprof',
                    'xlswriter',
                    'xml',
                    'xmlreader',
                    'xmlrpc',
                    'xmlwriter',
                    'xsl',
                    'yaml',
                    'zend',
                    'zip',
                    'zlib',
                    'zstd',
                },
                files = {
                    maxSize = 5000000,
                },
            },
        },
    }
end
