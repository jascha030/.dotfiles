local M = {}

local langs = nil
local langs_indexed = nil

local function get_langs_indexed()
    if nil ~= langs_indexed then
        return langs_indexed
    end

    langs_indexed = {
        ['2html'] = '2html',
        ['8th'] = '8th',
        ['Jenkinsfile'] = 'Jenkinsfile',
        ['Trouble'] = 'Trouble',
        ['a2ps'] = 'a2ps',
        ['a65'] = 'a65',
        ['aap'] = 'aap',
        ['abap'] = 'abap',
        ['abaqus'] = 'abaqus',
        ['abc'] = 'abc',
        ['abel'] = 'abel',
        ['acedb'] = 'acedb',
        ['ada'] = 'ada',
        ['aflex'] = 'aflex',
        ['ahdl'] = 'ahdl',
        ['aidl'] = 'aidl',
        ['alsaconf'] = 'alsaconf',
        ['amiga'] = 'amiga',
        ['aml'] = 'aml',
        ['ampl'] = 'ampl',
        ['ansible'] = 'ansible',
        ['ansible_hosts'] = 'ansible_hosts',
        ['ant'] = 'ant',
        ['antlr'] = 'antlr',
        ['apache'] = 'apache',
        ['apachestyle'] = 'apachestyle',
        ['apiblueprint'] = 'apiblueprint',
        ['applescript'] = 'applescript',
        ['aptconf'] = 'aptconf',
        ['arch'] = 'arch',
        ['arduino'] = 'arduino',
        ['art'] = 'art',
        ['asciidoc'] = 'asciidoc',
        ['asl'] = 'asl',
        ['asm'] = 'asm',
        ['asm68k'] = 'asm68k',
        ['asmh8300'] = 'asmh8300',
        ['asn'] = 'asn',
        ['aspperl'] = 'aspperl',
        ['aspvbs'] = 'aspvbs',
        ['asterisk'] = 'asterisk',
        ['asteriskvm'] = 'asteriskvm',
        ['atlas'] = 'atlas',
        ['autodoc'] = 'autodoc',
        ['autohotkey'] = 'autohotkey',
        ['autoit'] = 'autoit',
        ['automake'] = 'automake',
        ['ave'] = 'ave',
        ['avra'] = 'avra',
        ['awk'] = 'awk',
        ['ayacc'] = 'ayacc',
        ['b'] = 'b',
        ['baan'] = 'baan',
        ['bash'] = 'bash',
        ['basic'] = 'basic',
        ['bc'] = 'bc',
        ['bdf'] = 'bdf',
        ['bib'] = 'bib',
        ['bicep'] = 'bicep',
        ['bindzone'] = 'bindzone',
        ['bitbake'] = 'bitbake',
        ['blade'] = 'blade',
        ['blank'] = 'blank',
        ['brewfile'] = 'brewfile',
        ['bsdl'] = 'bsdl',
        ['bst'] = 'bst',
        ['btm'] = 'btm',
        ['bzl'] = 'bzl',
        ['bzr'] = 'bzr',
        ['c'] = 'c',
        ['cabal'] = 'cabal',
        ['cabal-1'] = 'cabal-1',
        ['cabal-2'] = 'cabal-2',
        ['cabalconfig'] = 'cabalconfig',
        ['cabalproject'] = 'cabalproject',
        ['caddyfile'] = 'caddyfile',
        ['calendar'] = 'calendar',
        ['calender'] = 'calender',
        ['carp'] = 'carp',
        ['catalog'] = 'catalog',
        ['cdl'] = 'cdl',
        ['cdrdaoconf'] = 'cdrdaoconf',
        ['cdrtoc'] = 'cdrtoc',
        ['cf'] = 'cf',
        ['cfg'] = 'cfg',
        ['ch'] = 'ch',
        ['chaiscript'] = 'chaiscript',
        ['change'] = 'change',
        ['changelog'] = 'changelog',
        ['chaskell'] = 'chaskell',
        ['chatito'] = 'chatito',
        ['checkhealth'] = 'checkhealth',
        ['cheetah'] = 'cheetah',
        ['chicken'] = 'chicken',
        ['chill'] = 'chill',
        ['chordpro'] = 'chordpro',
        ['cl'] = 'cl',
        ['clean'] = 'clean',
        ['clipper'] = 'clipper',
        ['clojure'] = 'clojure',
        ['cmake'] = 'cmake',
        ['cmod'] = 'cmod',
        ['cmusrc'] = 'cmusrc',
        ['cobol'] = 'cobol',
        ['coco'] = 'coco',
        ['coffee'] = 'coffee',
        ['colortest'] = 'colortest',
        ['common'] = 'common',
        ['conaryrecipe'] = 'conaryrecipe',
        ['conf'] = 'conf',
        ['config'] = 'config',
        ['confini'] = 'confini',
        ['context'] = 'context',
        ['cpp'] = 'cpp',
        ['cql'] = 'cql',
        ['crm'] = 'crm',
        ['crontab'] = 'crontab',
        ['cryptol'] = 'cryptol',
        ['crystal'] = 'crystal',
        ['cs'] = 'cs',
        ['csc'] = 'csc',
        ['csdl'] = 'csdl',
        ['csh'] = 'csh',
        ['csp'] = 'csp',
        ['css'] = 'css',
        ['csv'] = 'csv',
        ['cterm'] = 'cterm',
        ['ctrlh'] = 'ctrlh',
        ['cucumber'] = 'cucumber',
        ['cuda'] = 'cuda',
        ['cuesheet'] = 'cuesheet',
        ['cupl'] = 'cupl',
        ['cuplsim'] = 'cuplsim',
        ['cvs'] = 'cvs',
        ['cvsrc'] = 'cvsrc',
        ['cweb'] = 'cweb',
        ['cynlib'] = 'cynlib',
        ['cynpp'] = 'cynpp',
        ['cython'] = 'cython',
        ['d'] = 'd',
        ['dart'] = 'dart',
        ['datascript'] = 'datascript',
        ['dcd'] = 'dcd',
        ['dcl'] = 'dcl',
        ['dcov'] = 'dcov',
        ['dd'] = 'dd',
        ['ddoc'] = 'ddoc',
        ['debchangelog'] = 'debchangelog',
        ['debcontrol'] = 'debcontrol',
        ['debcopyright'] = 'debcopyright',
        ['debsources'] = 'debsources',
        ['def'] = 'def',
        ['denyhosts'] = 'denyhosts',
        ['dep3patch'] = 'dep3patch',
        ['desc'] = 'desc',
        ['desktop'] = 'desktop',
        ['dhall'] = 'dhall',
        ['dictconf'] = 'dictconf',
        ['dictdconf'] = 'dictdconf',
        ['diff'] = 'diff',
        ['dircolors'] = 'dircolors',
        ['dirpager'] = 'dirpager',
        ['diva'] = 'diva',
        ['django'] = 'django',
        ['dns'] = 'dns',
        ['dnsmasq'] = 'dnsmasq',
        ['docbk'] = 'docbk',
        ['docbksgml'] = 'docbksgml',
        ['docbkxml'] = 'docbkxml',
        ['docker-compose'] = 'docker-compose',
        ['dockerfile'] = 'dockerfile',
        ['dosbatch'] = 'dosbatch',
        ['dosini'] = 'dosini',
        ['dot'] = 'dot',
        ['doxygen'] = 'doxygen',
        ['dracula'] = 'dracula',
        ['dsdl'] = 'dsdl',
        ['dsl'] = 'dsl',
        ['dtd'] = 'dtd',
        ['dtml'] = 'dtml',
        ['dtrace'] = 'dtrace',
        ['dts'] = 'dts',
        ['dune'] = 'dune',
        ['dylan'] = 'dylan',
        ['dylanintr'] = 'dylanintr',
        ['dylanlid'] = 'dylanlid',
        ['ecd'] = 'ecd',
        ['ecrystal'] = 'ecrystal',
        ['edif'] = 'edif',
        ['editorconfig'] = 'editorconfig',
        ['eelixir'] = 'eelixir',
        ['eiffel'] = 'eiffel',
        ['elf'] = 'elf',
        ['elinks'] = 'elinks',
        ['elixir'] = 'elixir',
        ['elm'] = 'elm',
        ['elmfilt'] = 'elmfilt',
        ['ember-script'] = 'ember-script',
        ['emblem'] = 'emblem',
        ['epuppet'] = 'epuppet',
        ['erlang'] = 'erlang',
        ['eruby'] = 'eruby',
        ['esmtprc'] = 'esmtprc',
        ['esqlc'] = 'esqlc',
        ['esterel'] = 'esterel',
        ['eterm'] = 'eterm',
        ['euphoria3'] = 'euphoria3',
        ['euphoria4'] = 'euphoria4',
        ['eviews'] = 'eviews',
        ['exim'] = 'exim',
        ['expect'] = 'expect',
        ['exports'] = 'exports',
        ['falcon'] = 'falcon',
        ['fan'] = 'fan',
        ['fasm'] = 'fasm',
        ['fbs'] = 'fbs',
        ['fdcc'] = 'fdcc',
        ['fennel'] = 'fennel',
        ['ferm'] = 'ferm',
        ['fetchmail'] = 'fetchmail',
        ['fgl'] = 'fgl',
        ['fish'] = 'fish',
        ['flexwiki'] = 'flexwiki',
        ['flow'] = 'flow',
        ['focexec'] = 'focexec',
        ['form'] = 'form',
        ['forth'] = 'forth',
        ['fortran'] = 'fortran',
        ['foxpro'] = 'foxpro',
        ['fpcmake'] = 'fpcmake',
        ['framescript'] = 'framescript',
        ['freebasic'] = 'freebasic',
        ['fsharp'] = 'fsharp',
        ['fstab'] = 'fstab',
        ['fvwm'] = 'fvwm',
        ['fvwm2m4'] = 'fvwm2m4',
        ['gdb'] = 'gdb',
        ['gdmo'] = 'gdmo',
        ['gdresource'] = 'gdresource',
        ['gdscript'] = 'gdscript',
        ['gdshader'] = 'gdshader',
        ['gedcom'] = 'gedcom',
        ['gemtext'] = 'gemtext',
        ['gift'] = 'gift',
        ['git'] = 'git',
        ['gitattributes'] = 'gitattributes',
        ['gitcommit'] = 'gitcommit',
        ['gitconfig'] = 'gitconfig',
        ['gitignore'] = 'gitignore',
        ['gitolite'] = 'gitolite',
        ['gitrebase'] = 'gitrebase',
        ['gitsendemail'] = 'gitsendemail',
        ['gkrellmrc'] = 'gkrellmrc',
        ['gleam'] = 'gleam',
        ['glsl'] = 'glsl',
        ['gmpl'] = 'gmpl',
        ['gnash'] = 'gnash',
        ['gnuplot'] = 'gnuplot',
        ['go'] = 'go',
        ['godebugoutput'] = 'godebugoutput',
        ['godebugstacktrace'] = 'godebugstacktrace',
        ['godebugvariables'] = 'godebugvariables',
        ['godefstack'] = 'godefstack',
        ['godoc'] = 'godoc',
        ['gohtmltmpl'] = 'gohtmltmpl',
        ['gomod'] = 'gomod',
        ['gosum'] = 'gosum',
        ['gotexttmpl'] = 'gotexttmpl',
        ['gowork'] = 'gowork',
        ['gp'] = 'gp',
        ['gpg'] = 'gpg',
        ['gprof'] = 'gprof',
        ['grads'] = 'grads',
        ['graphql'] = 'graphql',
        ['gretl'] = 'gretl',
        ['groff'] = 'groff',
        ['groovy'] = 'groovy',
        ['group'] = 'group',
        ['grub'] = 'grub',
        ['gsp'] = 'gsp',
        ['gtkrc'] = 'gtkrc',
        ['gvpr'] = 'gvpr',
        ['gyp'] = 'gyp',
        ['haml'] = 'haml',
        ['hamster'] = 'hamster',
        ['handlebars'] = 'handlebars',
        ['haproxy'] = 'haproxy',
        ['hare'] = 'hare',
        ['haskell'] = 'haskell',
        ['haste'] = 'haste',
        ['hastepreproc'] = 'hastepreproc',
        ['haxe'] = 'haxe',
        ['haxe_extended'] = 'haxe_extended',
        ['hb'] = 'hb',
        ['hcl'] = 'hcl',
        ['heex'] = 'heex',
        ['helm'] = 'helm',
        ['help'] = 'help',
        ['help_ru'] = 'help_ru',
        ['hercules'] = 'hercules',
        ['hex'] = 'hex',
        ['hgcommit'] = 'hgcommit',
        ['hitest'] = 'hitest',
        ['hive'] = 'hive',
        ['hjson'] = 'hjson',
        ['hlsplaylist'] = 'hlsplaylist',
        ['hog'] = 'hog',
        ['hollywood'] = 'hollywood',
        ['hostconf'] = 'hostconf',
        ['hostsaccess'] = 'hostsaccess',
        ['hss'] = 'hss',
        ['html'] = 'html',
        ['htmlcheetah'] = 'htmlcheetah',
        ['htmldjango'] = 'htmldjango',
        ['htmlm4'] = 'htmlm4',
        ['htmlos'] = 'htmlos',
        ['hxml'] = 'hxml',
        ['i3config'] = 'i3config',
        ['ia64'] = 'ia64',
        ['ibasic'] = 'ibasic',
        ['icalendar'] = 'icalendar',
        ['icemenu'] = 'icemenu',
        ['icon'] = 'icon',
        ['idl'] = 'idl',
        ['idlang'] = 'idlang',
        ['idris'] = 'idris',
        ['idris2'] = 'idris2',
        ['indent'] = 'indent',
        ['inform'] = 'inform',
        ['initex'] = 'initex',
        ['initng'] = 'initng',
        ['inittab'] = 'inittab',
        ['ion'] = 'ion',
        ['ipfilter'] = 'ipfilter',
        ['ishd'] = 'ishd',
        ['iss'] = 'iss',
        ['ist'] = 'ist',
        ['j'] = 'j',
        ['jal'] = 'jal',
        ['jam'] = 'jam',
        ['jargon'] = 'jargon',
        ['java'] = 'java',
        ['javacc'] = 'javacc',
        ['javascript'] = 'javascript',
        ['javascript-1'] = 'javascript-1',
        ['javascript-2'] = 'javascript-2',
        ['javascriptreact'] = 'javascriptreact',
        ['jess'] = 'jess',
        ['jgraph'] = 'jgraph',
        ['jinja2'] = 'jinja2',
        ['jovial'] = 'jovial',
        ['jproperties'] = 'jproperties',
        ['jq'] = 'jq',
        ['json'] = 'json',
        ['json5'] = 'json5',
        ['jsonc'] = 'jsonc',
        ['jsonnet'] = 'jsonnet',
        ['jsp'] = 'jsp',
        ['jst'] = 'jst',
        ['jsx'] = 'jsx',
        ['jsx_pretty'] = 'jsx_pretty',
        ['julia'] = 'julia',
        ['juliadoc'] = 'juliadoc',
        ['just'] = 'just',
        ['kconfig'] = 'kconfig',
        ['kivy'] = 'kivy',
        ['kix'] = 'kix',
        ['kotlin'] = 'kotlin',
        ['krl'] = 'krl',
        ['kscript'] = 'kscript',
        ['kwt'] = 'kwt',
        ['lace'] = 'lace',
        ['latte'] = 'latte',
        ['lc'] = 'lc',
        ['ld'] = 'ld',
        ['ldapconf'] = 'ldapconf',
        ['ldif'] = 'ldif',
        ['ledger'] = 'ledger',
        ['less'] = 'less',
        ['lex'] = 'lex',
        ['lftp'] = 'lftp',
        ['lhaskell'] = 'lhaskell',
        ['libao'] = 'libao',
        ['lidris'] = 'lidris',
        ['lidris2'] = 'lidris2',
        ['lifelines'] = 'lifelines',
        ['lilo'] = 'lilo',
        ['lilypond'] = 'lilypond',
        ['lilypond-words'] = 'lilypond-words',
        ['limits'] = 'limits',
        ['liquid'] = 'liquid',
        ['lisp'] = 'lisp',
        ['litcoffee'] = 'litcoffee',
        ['lite'] = 'lite',
        ['litestep'] = 'litestep',
        ['llvm'] = 'llvm',
        ['log'] = 'log',
        ['logcheck'] = 'logcheck',
        ['loginaccess'] = 'loginaccess',
        ['logindefs'] = 'logindefs',
        ['logtalk'] = 'logtalk',
        ['lotos'] = 'lotos',
        ['lout'] = 'lout',
        ['lpc'] = 'lpc',
        ['lprolog'] = 'lprolog',
        ['ls'] = 'ls',
        ['lscript'] = 'lscript',
        ['lsl'] = 'lsl',
        ['lsp_markdown'] = 'lsp_markdown',
        ['lss'] = 'lss',
        ['lua'] = 'lua',
        ['lynx'] = 'lynx',
        ['lyrics'] = 'lyrics',
        ['m3build'] = 'm3build',
        ['m3quake'] = 'm3quake',
        ['m4'] = 'm4',
        ['machine-ir'] = 'machine-ir',
        ['mail'] = 'mail',
        ['mailaliases'] = 'mailaliases',
        ['mailcap'] = 'mailcap',
        ['make'] = 'make',
        ['mako'] = 'mako',
        ['mallard'] = 'mallard',
        ['man'] = 'man',
        ['manconf'] = 'manconf',
        ['manual'] = 'manual',
        ['maple'] = 'maple',
        ['markdown'] = 'markdown',
        ['masm'] = 'masm',
        ['mason'] = 'mason',
        ['master'] = 'master',
        ['matlab'] = 'matlab',
        ['maxima'] = 'maxima',
        ['mdx'] = 'mdx',
        ['mel'] = 'mel',
        ['merlin'] = 'merlin',
        ['mermaid'] = 'mermaid',
        ['meson'] = 'meson',
        ['messages'] = 'messages',
        ['mf'] = 'mf',
        ['mgl'] = 'mgl',
        ['mgp'] = 'mgp',
        ['mib'] = 'mib',
        ['mint'] = 'mint',
        ['mir'] = 'mir',
        ['mix'] = 'mix',
        ['mlir'] = 'mlir',
        ['mma'] = 'mma',
        ['mmix'] = 'mmix',
        ['mmp'] = 'mmp',
        ['modconf'] = 'modconf',
        ['model'] = 'model',
        ['modsim3'] = 'modsim3',
        ['modula2'] = 'modula2',
        ['modula3'] = 'modula3',
        ['monk'] = 'monk',
        ['moo'] = 'moo',
        ['moon'] = 'moon',
        ['mp'] = 'mp',
        ['mplayerconf'] = 'mplayerconf',
        ['mrxvtrc'] = 'mrxvtrc',
        ['msidl'] = 'msidl',
        ['msmessages'] = 'msmessages',
        ['msql'] = 'msql',
        ['mupad'] = 'mupad',
        ['murphi'] = 'murphi',
        ['mush'] = 'mush',
        ['mustache'] = 'mustache',
        ['muttrc'] = 'muttrc',
        ['mysql'] = 'mysql',
        ['n1ql'] = 'n1ql',
        ['named'] = 'named',
        ['nanorc'] = 'nanorc',
        ['nasm'] = 'nasm',
        ['nastran'] = 'nastran',
        ['natural'] = 'natural',
        ['ncf'] = 'ncf',
        ['neomuttrc'] = 'neomuttrc',
        ['netrc'] = 'netrc',
        ['netrw'] = 'netrw',
        ['nftables'] = 'nftables',
        ['nginx'] = 'nginx',
        ['nim'] = 'nim',
        ['ninja'] = 'ninja',
        ['nix'] = 'nix',
        ['nosyntax'] = 'nosyntax',
        ['nqc'] = 'nqc',
        ['nroff'] = 'nroff',
        ['nsis'] = 'nsis',
        ['oasis'] = 'oasis',
        ['obj'] = 'obj',
        ['objc'] = 'objc',
        ['objcpp'] = 'objcpp',
        ['obse'] = 'obse',
        ['ocaml'] = 'ocaml',
        ['ocamlbuild_tags'] = 'ocamlbuild_tags',
        ['occam'] = 'occam',
        ['ocpbuild'] = 'ocpbuild',
        ['ocpbuildroot'] = 'ocpbuildroot',
        ['octave'] = 'octave',
        ['odin'] = 'odin',
        ['omake'] = 'omake',
        ['omnimark'] = 'omnimark',
        ['opam'] = 'opam',
        ['opencl'] = 'opencl',
        ['openroad'] = 'openroad',
        ['openscad'] = 'openscad',
        ['openvpn'] = 'openvpn',
        ['opl'] = 'opl',
        ['ora'] = 'ora',
        ['org'] = 'org',
        ['outline'] = 'outline',
        ['pamconf'] = 'pamconf',
        ['pamenv'] = 'pamenv',
        ['papp'] = 'papp',
        ['pascal'] = 'pascal',
        ['passwd'] = 'passwd',
        ['pbtxt'] = 'pbtxt',
        ['pcap'] = 'pcap',
        ['pccts'] = 'pccts',
        ['pdf'] = 'pdf',
        ['perl'] = 'perl',
        ['pest'] = 'pest',
        ['pf'] = 'pf',
        ['pfmain'] = 'pfmain',
        ['pgsql'] = 'pgsql',
        ['php'] = 'php',
        ['phtml'] = 'phtml',
        ['pic'] = 'pic',
        ['pike'] = 'pike',
        ['pilrc'] = 'pilrc',
        ['pine'] = 'pine',
        ['pinfo'] = 'pinfo',
        ['plaintex'] = 'plaintex',
        ['plantuml'] = 'plantuml',
        ['pli'] = 'pli',
        ['plm'] = 'plm',
        ['plp'] = 'plp',
        ['plsql'] = 'plsql',
        ['po'] = 'po',
        ['pod'] = 'pod',
        ['poefilter'] = 'poefilter',
        ['poke'] = 'poke',
        ['pony'] = 'pony',
        ['postscr'] = 'postscr',
        ['pov'] = 'pov',
        ['povini'] = 'povini',
        ['ppd'] = 'ppd',
        ['ppwiz'] = 'ppwiz',
        ['prescribe'] = 'prescribe',
        ['privoxy'] = 'privoxy',
        ['procmail'] = 'procmail',
        ['progress'] = 'progress',
        ['prolog'] = 'prolog',
        ['promela'] = 'promela',
        ['proto'] = 'proto',
        ['protocols'] = 'protocols',
        ['ps1'] = 'ps1',
        ['ps1xml'] = 'ps1xml',
        ['psf'] = 'psf',
        ['psl'] = 'psl',
        ['ptcap'] = 'ptcap',
        ['pug'] = 'pug',
        ['puppet'] = 'puppet',
        ['puppet_tagbar'] = 'puppet_tagbar',
        ['purescript'] = 'purescript',
        ['purifylog'] = 'purifylog',
        ['pyrex'] = 'pyrex',
        ['python'] = 'python',
        ['python2'] = 'python2',
        ['qb64'] = 'qb64',
        ['qf'] = 'qf',
        ['qmake'] = 'qmake',
        ['qml'] = 'qml',
        ['quake'] = 'quake',
        ['quarto'] = 'quarto',
        ['query'] = 'query',
        ['r'] = 'r',
        ['racc'] = 'racc',
        ['racket'] = 'racket',
        ['radiance'] = 'radiance',
        ['ragel'] = 'ragel',
        ['raku'] = 'raku',
        ['raml'] = 'raml',
        ['ratpoison'] = 'ratpoison',
        ['razor'] = 'razor',
        ['rc'] = 'rc',
        ['rcs'] = 'rcs',
        ['rcslog'] = 'rcslog',
        ['readline'] = 'readline',
        ['reason'] = 'reason',
        ['rebol'] = 'rebol',
        ['redif'] = 'redif',
        ['registry'] = 'registry',
        ['rego'] = 'rego',
        ['remind'] = 'remind',
        ['requirements'] = 'requirements',
        ['resolv'] = 'resolv',
        ['reva'] = 'reva',
        ['rexx'] = 'rexx',
        ['rhelp'] = 'rhelp',
        ['rib'] = 'rib',
        ['rmd'] = 'rmd',
        ['rnc'] = 'rnc',
        ['rng'] = 'rng',
        ['rnoweb'] = 'rnoweb',
        ['rnoweb-1'] = 'rnoweb-1',
        ['rnoweb-2'] = 'rnoweb-2',
        ['robots'] = 'robots',
        ['routeros'] = 'routeros',
        ['rpcgen'] = 'rpcgen',
        ['rpl'] = 'rpl',
        ['rrst'] = 'rrst',
        ['rspec'] = 'rspec',
        ['rst'] = 'rst',
        ['rtf'] = 'rtf',
        ['ruby'] = 'ruby',
        ['rust'] = 'rust',
        ['samba'] = 'samba',
        ['sas'] = 'sas',
        ['sass'] = 'sass',
        ['sather'] = 'sather',
        ['sbt'] = 'sbt',
        ['scala'] = 'scala',
        ['scala.xpt'] = 'scala.xpt',
        ['scdoc'] = 'scdoc',
        ['scheme'] = 'scheme',
        ['scilab'] = 'scilab',
        ['screen'] = 'screen',
        ['scss'] = 'scss',
        ['sd'] = 'sd',
        ['sdc'] = 'sdc',
        ['sdl'] = 'sdl',
        ['sed'] = 'sed',
        ['sendpr'] = 'sendpr',
        ['sensors'] = 'sensors',
        ['services'] = 'services',
        ['setserial'] = 'setserial',
        ['sexplib'] = 'sexplib',
        ['sgml'] = 'sgml',
        ['sgmldecl'] = 'sgmldecl',
        ['sgmllnx'] = 'sgmllnx',
        ['sh'] = 'sh',
        ['shada'] = 'shada',
        ['sicad'] = 'sicad',
        ['sieve'] = 'sieve',
        ['sil'] = 'sil',
        ['simula'] = 'simula',
        ['sinda'] = 'sinda',
        ['sindacmp'] = 'sindacmp',
        ['sindaout'] = 'sindaout',
        ['sisu'] = 'sisu',
        ['skill'] = 'skill',
        ['sl'] = 'sl',
        ['slang'] = 'slang',
        ['slice'] = 'slice',
        ['slim'] = 'slim',
        ['slime'] = 'slime',
        ['slpconf'] = 'slpconf',
        ['slpreg'] = 'slpreg',
        ['slpspi'] = 'slpspi',
        ['slrnrc'] = 'slrnrc',
        ['slrnsc'] = 'slrnsc',
        ['sm'] = 'sm',
        ['smarty'] = 'smarty',
        ['smcl'] = 'smcl',
        ['smhl'] = 'smhl',
        ['smil'] = 'smil',
        ['smith'] = 'smith',
        ['sml'] = 'sml',
        ['smt2'] = 'smt2',
        ['snippets'] = 'snippets',
        ['snnsnet'] = 'snnsnet',
        ['snnspat'] = 'snnspat',
        ['snnsres'] = 'snnsres',
        ['snobol4'] = 'snobol4',
        ['solidity'] = 'solidity',
        ['solution'] = 'solution',
        ['spec'] = 'spec',
        ['specman'] = 'specman',
        ['spice'] = 'spice',
        ['splint'] = 'splint',
        ['spup'] = 'spup',
        ['spyce'] = 'spyce',
        ['sql'] = 'sql',
        ['sqlanywhere'] = 'sqlanywhere',
        ['sqlforms'] = 'sqlforms',
        ['sqlhana'] = 'sqlhana',
        ['sqlinformix'] = 'sqlinformix',
        ['sqlj'] = 'sqlj',
        ['sqloracle'] = 'sqloracle',
        ['sqr'] = 'sqr',
        ['squid'] = 'squid',
        ['squirrel'] = 'squirrel',
        ['srec'] = 'srec',
        ['srt'] = 'srt',
        ['ssa'] = 'ssa',
        ['sshconfig'] = 'sshconfig',
        ['sshdconfig'] = 'sshdconfig',
        ['st'] = 'st',
        ['stata'] = 'stata',
        ['stp'] = 'stp',
        ['strace'] = 'strace',
        ['structurizr'] = 'structurizr',
        ['stylus'] = 'stylus',
        ['sudoers'] = 'sudoers',
        ['svelte'] = 'svelte',
        ['svelte-css'] = 'svelte-css',
        ['svelte-html'] = 'svelte-html',
        ['svelte-xml'] = 'svelte-xml',
        ['svg'] = 'svg',
        ['svn'] = 'svn',
        ['swayconfig'] = 'swayconfig',
        ['swift'] = 'swift',
        ['swiftgyb'] = 'swiftgyb',
        ['sxhkdrc'] = 'sxhkdrc',
        ['synload'] = 'synload',
        ['syntax'] = 'syntax',
        ['sysctl'] = 'sysctl',
        ['systemd'] = 'systemd',
        ['systemverilog'] = 'systemverilog',
        ['tablegen'] = 'tablegen',
        ['tads'] = 'tads',
        ['tags'] = 'tags',
        ['tak'] = 'tak',
        ['takcmp'] = 'takcmp',
        ['takout'] = 'takout',
        ['tap'] = 'tap',
        ['tar'] = 'tar',
        ['taskdata'] = 'taskdata',
        ['taskedit'] = 'taskedit',
        ['tasm'] = 'tasm',
        ['tcl'] = 'tcl',
        ['tcsh'] = 'tcsh',
        ['template'] = 'template',
        ['teraterm'] = 'teraterm',
        ['terminfo'] = 'terminfo',
        ['terraform'] = 'terraform',
        ['tex'] = 'tex',
        ['texinfo'] = 'texinfo',
        ['texmf'] = 'texmf',
        ['text'] = 'text',
        ['textile'] = 'textile',
        ['tf'] = 'tf',
        ['thrift'] = 'thrift',
        ['tidy'] = 'tidy',
        ['tilde'] = 'tilde',
        ['tli'] = 'tli',
        ['tmux'] = 'tmux',
        ['toml'] = 'toml',
        ['tpp'] = 'tpp',
        ['tptp'] = 'tptp',
        ['trasys'] = 'trasys',
        ['treetop'] = 'treetop',
        ['trustees'] = 'trustees',
        ['tsalt'] = 'tsalt',
        ['tsscl'] = 'tsscl',
        ['tssgm'] = 'tssgm',
        ['tssop'] = 'tssop',
        ['tsx'] = 'tsx',
        ['tt2'] = 'tt2',
        ['tt2html'] = 'tt2html',
        ['tt2js'] = 'tt2js',
        ['tutor'] = 'tutor',
        ['twig'] = 'twig',
        ['typescript'] = 'typescript',
        ['typescriptreact'] = 'typescriptreact',
        ['uc'] = 'uc',
        ['udevconf'] = 'udevconf',
        ['udevperm'] = 'udevperm',
        ['udevrules'] = 'udevrules',
        ['uil'] = 'uil',
        ['unison'] = 'unison',
        ['updatedb'] = 'updatedb',
        ['upstart'] = 'upstart',
        ['upstreamdat'] = 'upstreamdat',
        ['upstreaminstalllog'] = 'upstreaminstalllog',
        ['upstreamlog'] = 'upstreamlog',
        ['upstreamrpt'] = 'upstreamrpt',
        ['usserverlog'] = 'usserverlog',
        ['usw2kagtlog'] = 'usw2kagtlog',
        ['vala'] = 'vala',
        ['valgrind'] = 'valgrind',
        ['vb'] = 'vb',
        ['vbnet'] = 'vbnet',
        ['vcl'] = 'vcl',
        ['vdf'] = 'vdf',
        ['velocity'] = 'velocity',
        ['vera'] = 'vera',
        ['verilog'] = 'verilog',
        ['verilogams'] = 'verilogams',
        ['vgrindefs'] = 'vgrindefs',
        ['vhdl'] = 'vhdl',
        ['vim'] = 'vim',
        ['vimgo'] = 'vimgo',
        ['viminfo'] = 'viminfo',
        ['vimnormal'] = 'vimnormal',
        ['virata'] = 'virata',
        ['vlang'] = 'vlang',
        ['vmasm'] = 'vmasm',
        ['voscm'] = 'voscm',
        ['vrml'] = 'vrml',
        ['vroom'] = 'vroom',
        ['vsejcl'] = 'vsejcl',
        ['vue'] = 'vue',
        ['wast'] = 'wast',
        ['wdiff'] = 'wdiff',
        ['wdl'] = 'wdl',
        ['web'] = 'web',
        ['webmacro'] = 'webmacro',
        ['wget'] = 'wget',
        ['wget2'] = 'wget2',
        ['whitespace'] = 'whitespace',
        ['winbatch'] = 'winbatch',
        ['wml'] = 'wml',
        ['wsh'] = 'wsh',
        ['wsml'] = 'wsml',
        ['wvdial'] = 'wvdial',
        ['xbl'] = 'xbl',
        ['xdc'] = 'xdc',
        ['xdefaults'] = 'xdefaults',
        ['xf86conf'] = 'xf86conf',
        ['xhtml'] = 'xhtml',
        ['xinetd'] = 'xinetd',
        ['xkb'] = 'xkb',
        ['xmath'] = 'xmath',
        ['xml'] = 'xml',
        ['xmodmap'] = 'xmodmap',
        ['xpm'] = 'xpm',
        ['xpm2'] = 'xpm2',
        ['xquery'] = 'xquery',
        ['xs'] = 'xs',
        ['xsd'] = 'xsd',
        ['xsl'] = 'xsl',
        ['xslt'] = 'xslt',
        ['xxd'] = 'xxd',
        ['yacc'] = 'yacc',
        ['yaml'] = 'yaml',
        ['yardoc_support'] = 'yardoc_support',
        ['yats'] = 'yats',
        ['z8a'] = 'z8a',
        ['zephir'] = 'zephir',
        ['zig'] = 'zig',
        ['zimbu'] = 'zimbu',
        ['zir'] = 'zir',
        ['zsh'] = 'zsh',
    }

    return langs_indexed
end

local function get_langs()
    if nil ~= langs then
        return langs
    end

    langs = {}

    for _, v in pairs(get_langs_indexed()) do
        table.insert(langs, v)
    end

    return langs
end

function M.get_langs(with_keys)
    return with_keys == true and get_langs_indexed() or get_langs()
end

return M
