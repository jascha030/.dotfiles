module.exports =
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "JkW7");
/******/ })
/************************************************************************/
/******/ ({

/***/ "0c/n":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"loader_line":"loader_line__3q3vg","show":"show__3-1Zj","loading":"loading__1-0L4"};

/***/ }),

/***/ "JkW7":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });

// EXTERNAL MODULE: ../node_modules/preact/dist/preact.min.js
var preact_min = __webpack_require__("KM04");
var preact_min_default = /*#__PURE__*/__webpack_require__.n(preact_min);

// CONCATENATED MODULE: ./utils/utils.ts
function sanitizeStringForHtml(str) {
    var map = {
        '&': "&amp;",
        '<': "&lt;",
        '>': "&gt;",
        '/': "&#x2F;",
        '"': "&quot;",
        '\'': "&#039;"
    };
    return str.replace(/[&<>\/"']/g, function (m) { return map[m]; });
}
function range(from, to) {
    var arr = [];
    for (var i = from; i <= to; i++) {
        arr.push(i);
    }
    return arr;
}
function randId() {
    return (Math.random() + 1).toString(36).substr(2, 8);
}

// CONCATENATED MODULE: ./service/service.js


/*
interface VscodeApi { postMessage: (data: any) => void; }
declare function acquireVsCodeApi(): VscodeApi;
*/
var Service = function () {
    console.log("Service called");

    var requests = {};
    var cache = {};
    var instance = void 0;
    var vscodeApi = void 0;

    if (typeof window !== "undefined") {
        if (typeof acquireVsCodeApi !== "undefined") {
            vscodeApi = acquireVsCodeApi();
        } else {
            // for development
            var resources = getFakeResultSetResources();
            vscodeApi = {
                postMessage: function postMessage(msg) {
                    var command = msg.command.replace(/fetch\:\/(.*)/, '$1');
                    if (resources[command]) {
                        setTimeout(function () {
                            window.postMessage({ command: msg.command, data: resources[command], id: msg.id }, "*");
                        }, 10);
                    }
                }
            };
        }

        console.log("Acquired vscode api");

        window.addEventListener('message', function (event) {
            //console.log("Received message from vscode: "+JSON.stringify(event.data));

            var message = event.data;

            var request = requests[message.id];
            if (request) {
                request.callback(message.data);
                delete requests[message.id];
            }
        });
    }

    return {
        getInstance: function getInstance() {
            if (!instance) {
                instance = {
                    request: function request(message) {
                        if (vscodeApi) {
                            message.id = randId();
                            vscodeApi.postMessage(message);
                            return new Promise(function (resolve, reject) {
                                requests[message.id] = {
                                    message: message,
                                    callback: function callback(data) {
                                        resolve(data);
                                    }
                                };
                            });
                        } else {
                            return Promise.reject();
                        }
                    }
                };
            }
            return instance;
        }
    };
}();
// CONCATENATED MODULE: ./components/fetch/index.tsx
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var fetch_Fetch = /** @class */ (function (_super) {
    __extends(Fetch, _super);
    function Fetch(props, context) {
        var _this = _super.call(this, props, context) || this;
        _this.cache = {};
        return _this;
    }
    Fetch.prototype.componentWillMount = function () {
        this._fetch(this.props.resource);
    };
    Fetch.prototype.componentWillReceiveProps = function (nextProps) {
        if (this.props.resource !== nextProps.resource) {
            this._fetch(nextProps.resource);
        }
    };
    Fetch.prototype.shouldComponentUpdate = function (nextProps, nextState) {
        if (this.props.forceUpdate) {
            return true;
        }
        else {
            // no need to update if the data is the same
            return (JSON.stringify(this.state.data) !== JSON.stringify(nextState.data));
        }
    };
    Fetch.prototype._fetch = function (resource) {
        var _this = this;
        if (!resource)
            return;
        // check if the response to the message is cached
        // and if it is return the data
        if (this.cache[resource] != null) {
            this.setState({ data: this.cache[resource] });
            return;
        }
        var service = Service.getInstance();
        var command = "fetch:/" + resource;
        service.request({ command: command, data: {} }).then(function (data) {
            _this.cache[resource] = data;
            _this.setState({ data: data });
        }).catch(function (reason) {
            _this.setState({ error: reason });
        });
    };
    Fetch.prototype.render = function (props, state) {
        if (state.data != null || state.error != null) {
            return props.children ? props.children[0]({ loading: false, data: state.data, error: state.error }) : null;
        }
        else {
            return props.children ? props.children[0]({ loading: true }) : null;
        }
    };
    return Fetch;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/statement/style.css
var style = __webpack_require__("r2IK");
var style_default = /*#__PURE__*/__webpack_require__.n(style);

// CONCATENATED MODULE: ./components/statement/index.tsx
var statement___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();



var statement_Statement = /** @class */ (function (_super) {
    statement___extends(Statement, _super);
    function Statement(props, context) {
        var _this = _super.call(this, props, context) || this;
        _this.state = ({ isCollapsed: true });
        return _this;
    }
    Statement.prototype.onclick = function () {
        var currState = this.state.isCollapsed;
        this.setState({ isCollapsed: !currState });
    };
    Statement.prototype.render = function (props, state) {
        var _this = this;
        return (Object(preact_min["h"])(fetch_Fetch, { resource: "resultSet/" + props.idx + "/stmt", forceUpdate: true }, function (response) { return (Object(preact_min["h"])("div", { class: state.isCollapsed ? style_default.a.statementCollapsed : style_default.a.statement, onClick: function () { return _this.onclick(); } },
            response.loading && Object(preact_min["h"])("code", { class: style_default.a.code }, "Loading..."),
            response.error && Object(preact_min["h"])("code", { class: style_default.a.code },
                "Error: ",
                response.error),
            response.data && Object(preact_min["h"])("code", { class: style_default.a.code },
                " ",
                response.data))); }));
    };
    return Statement;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/table/trow/index.tsx
var trow___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var trow_TRow = /** @class */ (function (_super) {
    trow___extends(TRow, _super);
    function TRow() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    // this component is built manually to perform some optimizations
    TRow.prototype.shouldComponentUpdate = function (nextProps, nextState, nextContext) {
        if (!this.base || !this.base.children)
            return true;
        if (nextProps.row && nextProps.n != null) {
            this.base.setAttribute('style', 'visibility: visible;');
            while (this.base.children.length < nextProps.row.length + 1) {
                this.base.appendChild(document.createElement('td'));
            }
            for (var i = 0; i < nextProps.row.length + 1; i++) {
                var td = this.base.children[i];
                if (i === 0)
                    td.innerHTML = (nextProps.n + 1).toString();
                else
                    td.innerHTML = sanitizeStringForHtml(nextProps.row[i - 1]);
            }
        }
        else {
            this.base.setAttribute('style', 'display: none;');
        }
        return false;
    };
    TRow.prototype.render = function (props, state) {
        return (Object(preact_min["h"])("tr", { style: "display: none;" }));
    };
    return TRow;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/table/tbody/index.tsx
var tbody___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();




var tbody_TBody = /** @class */ (function (_super) {
    tbody___extends(TBody, _super);
    function TBody() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    TBody.prototype.render = function (props, state) {
        var rowsRange = range(0, props.pageRows - 1);
        var resources = range(props.fromRow, props.toRow).map(function (i) { return "resultSet/" + props.idx + "/rows/" + i; });
        return (Object(preact_min["h"])("tbody", null, rowsRange.map(function (i) {
            if (i < resources.length) {
                return (Object(preact_min["h"])(fetch_Fetch, { resource: resources[i], forceUpdate: true }, function (response) { return Object(preact_min["h"])(trow_TRow, { row: response.data, n: i + props.fromRow }); }));
            }
            else {
                return (Object(preact_min["h"])(trow_TRow, null));
            }
        })));
    };
    return TBody;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/table/thead/index.tsx
var thead___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var thead_THead = /** @class */ (function (_super) {
    thead___extends(THead, _super);
    function THead() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    THead.prototype.render = function (props, state) {
        return (Object(preact_min["h"])("thead", null,
            Object(preact_min["h"])(fetch_Fetch, { resource: "resultSet/" + props.idx + "/header" }, function (response) { return (Object(preact_min["h"])("tr", null,
                response.loading && null,
                response.error && null,
                response.data && response.data.map(function (field, index) {
                    var a = [];
                    if (index === 0)
                        a.push(Object(preact_min["h"])("th", null, "#"));
                    a.push(Object(preact_min["h"])("th", null, field));
                    return a;
                }))); })));
    };
    return THead;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/table/style.css
var table_style = __webpack_require__("ukti");
var table_style_default = /*#__PURE__*/__webpack_require__.n(table_style);

// CONCATENATED MODULE: ./components/table/index.tsx
var table___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();




var table_Table = /** @class */ (function (_super) {
    table___extends(Table, _super);
    function Table() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Table.prototype.render = function (props, state) {
        return (Object(preact_min["h"])("table", { class: table_style_default.a.table },
            Object(preact_min["h"])(thead_THead, { idx: props.idx }),
            Object(preact_min["h"])(tbody_TBody, { idx: props.idx, pageRows: props.pageRows, fromRow: props.fromRow, toRow: props.toRow })));
    };
    return Table;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/pager/style.css
var pager_style = __webpack_require__("QvR7");
var pager_style_default = /*#__PURE__*/__webpack_require__.n(pager_style);

// CONCATENATED MODULE: ./components/pager/index.tsx
var pager___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();



var pager_Pager = /** @class */ (function (_super) {
    pager___extends(Pager, _super);
    function Pager() {
        var args = [];
        for (var _i = 0; _i < arguments.length; _i++) {
            args[_i] = arguments[_i];
        }
        var _this = _super.apply(this, args) || this;
        _this.page = 1;
        _this.pages = Number.MAX_SAFE_INTEGER;
        _this.totRows = Number.MAX_SAFE_INTEGER;
        return _this;
    }
    Pager.prototype.componentDidMount = function () {
        this.changePage(1);
    };
    Pager.prototype.changePage = function (newPage) {
        newPage = newPage < 1 ? 1 : newPage;
        newPage = newPage > this.pages ? this.pages : newPage;
        this.page = newPage;
        var fromRow = (this.page - 1) * this.props.pageRows;
        var toRow = fromRow + this.props.pageRows - 1;
        toRow = toRow > this.totRows - 1 ? this.totRows - 1 : toRow;
        this.props.onPage(fromRow, toRow);
        var pagerInput = document.getElementById('pager-input');
        if (pagerInput)
            pagerInput.value = this.page.toString();
    };
    Pager.prototype.onKeyPress = function (e) {
        if (!e)
            e = window.event;
        var keyCode = e.keyCode || e.which;
        if (keyCode.toString() === '13') {
            e.preventDefault();
            this.changePage(parseInt(e.target.value));
            return false;
        }
    };
    Pager.prototype.render = function (props, state) {
        var _this = this;
        return (Object(preact_min["h"])(fetch_Fetch, { resource: "resultSet/" + props.idx + "/rows/length" }, function (response) {
            _this.totRows = response.data;
            _this.pages = Math.ceil(_this.totRows / _this.props.pageRows);
            if (_this.totRows === 0) {
                return (Object(preact_min["h"])("div", null, "No result found"));
            }
            else {
                return (Object(preact_min["h"])("div", { class: pager_style_default.a.pager },
                    Object(preact_min["h"])("button", { onClick: function () { return _this.changePage(_this.page - 1); } }, "\u276E"),
                    Object(preact_min["h"])("input", { id: "pager-input", type: "number", min: 1, max: _this.pages, value: _this.page, onKeyPress: _this.onKeyPress.bind(_this) }),
                    Object(preact_min["h"])("small", null, _this.pages ? "/" + _this.pages : "/..."),
                    Object(preact_min["h"])("button", { onClick: function () { return _this.changePage(_this.page + 1); } }, "\u276F")));
            }
        }));
    };
    return Pager;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/iconbutton/style.css
var iconbutton_style = __webpack_require__("tWQK");
var iconbutton_style_default = /*#__PURE__*/__webpack_require__.n(iconbutton_style);

// CONCATENATED MODULE: ./components/iconbutton/index.tsx
var iconbutton___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var iconbutton_IconButton = /** @class */ (function (_super) {
    iconbutton___extends(IconButton, _super);
    function IconButton() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    IconButton.prototype.getIcon = function (icon) {
        var htmlIcon = 'data:image/svg+xml;base64,';
        if (document.body.className === 'vscode-light') {
            htmlIcon += window.btoa(icon.light);
        }
        else {
            htmlIcon += window.btoa(icon.dark);
        }
        return htmlIcon;
    };
    IconButton.prototype.render = function (props, state) {
        if (props.ready) {
            return (Object(preact_min["h"])("input", { class: iconbutton_style_default.a.btn, type: "image", title: props.title, alt: props.title, src: this.getIcon(props.icon), width: props.size || 16, height: props.size || 16, onClick: props.onclick }));
        }
        else {
            return (Object(preact_min["h"])("div", { class: iconbutton_style_default.a.loader }));
        }
    };
    return IconButton;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/showhide/index.tsx
var showhide___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var showhide_ShowHide = /** @class */ (function (_super) {
    showhide___extends(ShowHide, _super);
    function ShowHide() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.icon = {
            light: "<svg  xmlns=\"http://www.w3.org/2000/svg\" class=\"octicon octicon-eye\" viewBox=\"0 0 16 16\" version=\"1.1\" width=\"16\" height=\"16\" aria-hidden=\"true\"><path fill-rule=\"evenodd\" d=\"M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z\" fill=\"#656565\"></path></svg>",
            dark: "<svg xmlns=\"http://www.w3.org/2000/svg\" class=\"octicon octicon-eye\" viewBox=\"0 0 16 16\" version=\"1.1\" width=\"16\" height=\"16\" aria-hidden=\"true\"><path fill-rule=\"evenodd\" d=\"M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z\" fill=\"#C5C5C5\"></path></svg>"
        };
        return _this;
    }
    ShowHide.prototype.render = function (props, state) {
        return (Object(preact_min["h"])(iconbutton_IconButton, { title: "Show/Hide", icon: this.icon, ready: true, onclick: props.onToggle }));
    };
    return ShowHide;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/hideable/style.css
var hideable_style = __webpack_require__("Uqx6");
var hideable_style_default = /*#__PURE__*/__webpack_require__.n(hideable_style);

// CONCATENATED MODULE: ./components/hideable/index.tsx
var hideable___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var hideable_Hideable = /** @class */ (function (_super) {
    hideable___extends(Hideable, _super);
    function Hideable() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Hideable.prototype.render = function (props, state) {
        return (Object(preact_min["h"])("div", { class: props.hidden ? hideable_style_default.a.hidden : hideable_style_default.a.showing }, props.children));
    };
    return Hideable;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/exportcsv/index.tsx
var exportcsv___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();




var exportcsv_ExportCsv = /** @class */ (function (_super) {
    exportcsv___extends(ExportCsv, _super);
    function ExportCsv() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.icon = {
            dark: "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\"><style>.icon-canvas-transparent{opacity:0;fill:#2d2d30}.icon-vs-out{fill:#2d2d30}.icon-vs-bg{fill:#c5c5c5}.icon-vs-fg{fill:#2b282e}.icon-vs-action-blue{fill:#75beff}</style><path class=\"icon-canvas-transparent\" d=\"M16 16H0V0h16v16z\" id=\"canvas\"/><path class=\"icon-vs-out\" d=\"M14 4.552V13c-.028.825-.593 2-2.035 2h-8C3.012 15 2 14.299 2 13V8H.586l2-2H0V2h2.586l-2-2h4.828l1 1h3.608L14 4.552z\" id=\"outline\" style=\"display: none;\"/><path class=\"icon-vs-fg\" d=\"M9 3.586L8.414 3H9v.586zM12 6h-2v7h2V6zm-6 7V7.414L5.414 8H4v5h2zm1 0h2V4.414l-1 1V6h-.586L7 6.414V13z\" id=\"iconFg\" style=\"display: none;\"/><path class=\"icon-vs-bg\" d=\"M8 5.414V6h-.586L8 5.414zM13 5v8s-.035 1-1.035 1h-8S3 14 3 13V8h1v5h2V7.414l1-1V13h2V4.414L9.414 4 9 3.586V3h-.586l-1-1h2.227L13 5zm-1 1h-2v7h2V6z\" id=\"iconBg\"/><path class=\"icon-vs-action-blue\" d=\"M8 4L5 7H3l2-2H1V3h4L3 1h2l3 3z\" id=\"colorAction\"/></svg>",
            light: "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\"><style>.icon-canvas-transparent{opacity:0;fill:#f6f6f6}.icon-vs-out{fill:#f6f6f6}.icon-vs-bg{fill:#424242}.icon-vs-fg{fill:#f0eff1}.icon-vs-action-blue{fill:#00539c}</style><path class=\"icon-canvas-transparent\" d=\"M16 16H0V0h16v16z\" id=\"canvas\"/><path class=\"icon-vs-out\" d=\"M14 4.552V13c-.028.825-.593 2-2.035 2h-8C3.012 15 2 14.299 2 13V8H.586l2-2H0V2h2.586l-2-2h4.828l1 1h3.608L14 4.552z\" id=\"outline\" style=\"display: none;\"/><path class=\"icon-vs-fg\" d=\"M9 3.586L8.414 3H9v.586zM12 6h-2v7h2V6zm-6 7V7.414L5.414 8H4v5h2zm1 0h2V4.414l-1 1V6h-.586L7 6.414V13z\" id=\"iconFg\" style=\"display: none;\"/><path class=\"icon-vs-bg\" d=\"M8 5.414V6h-.586L8 5.414zM13 5v8s-.035 1-1.035 1h-8S3 14 3 13V8h1v5h2V7.414l1-1V13h2V4.414L9.414 4 9 3.586V3h-.586l-1-1h2.227L13 5zm-1 1h-2v7h2V6z\" id=\"iconBg\"/><path class=\"icon-vs-action-blue\" d=\"M8 4L5 7H3l2-2H1V3h4L3 1h2l3 3z\" id=\"colorAction\"/></svg>"
        };
        return _this;
    }
    ExportCsv.prototype.exportCsv = function () {
        var service = Service.getInstance();
        service.request({ command: this.props.idx != null ? "csv:resultSet/" + this.props.idx : "csv:resultSet" });
    };
    ExportCsv.prototype.render = function (props, state) {
        var _this = this;
        return (Object(preact_min["h"])(fetch_Fetch, { resource: this.props.idx != null ? "resultSet/" + props.idx + "/rows/length" : "resultSet/length" }, function (response) { return (Object(preact_min["h"])(iconbutton_IconButton, { title: "Export csv", icon: _this.icon, ready: !response.loading, onclick: _this.exportCsv.bind(_this) })); }));
    };
    return ExportCsv;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/exportjson/index.tsx
var exportjson___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();




var exportjson_ExportJson = /** @class */ (function (_super) {
    exportjson___extends(ExportJson, _super);
    function ExportJson() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.icon = {
            dark: "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\"><style>.icon-canvas-transparent{opacity:0;fill:#2d2d30}.icon-vs-out{fill:#2d2d30}.icon-vs-bg{fill:#c5c5c5}.icon-vs-action-blue{fill:#75beff}</style><path class=\"icon-canvas-transparent\" d=\"M16 16H0V0h16v16z\" id=\"canvas\"/><path class=\"icon-vs-out\" d=\"M16 8.38v2.258s-.992-.001-.997-.003c-.012.052-.003.14-.003.281v1.579c0 1.271-.37 2.185-1.054 2.746-.638.522-1.576.759-2.822.759H10v-3.247s1.014-.001 1.037-.003c.004-.046-.037-.117-.037-.214V11.08c0-.943.222-1.606.539-2.072C11.223 8.527 11 7.843 11 6.869V5.468c0-.087.102-.286.094-.325-.02-.002.063-.143.03-.143H10V2h1.124c1.251 0 2.193.265 2.832.81C14.633 3.387 15 4.3 15 5.522V7h.919L16 8.38zM9.414 4l-4-4H.586l2 2H0v4h2v.586L1.586 7H1v.586L.586 8H1v1.638L1.329 11H2v1.536c0 1.247.495 2.149 1.19 2.711.641.517 1.697.753 2.937.753H7v-3.247s-1.011-.001-1.033-.003c-.008-.053.033-.127.033-.228v-1.401c0-.962-.224-1.637-.542-2.111.256-.378.444-.89.511-1.564L9.414 4z\" id=\"outline\" style=\"display: none;\"/><path class=\"icon-vs-bg\" d=\"M15 8.38v1.258c-.697 0-1.046.426-1.046 1.278v1.579c0 .961-.223 1.625-.666 1.989-.445.364-1.166.547-2.164.547v-1.278c.383 0 .661-.092.834-.277s.26-.498.26-.94V11.08c0-1.089.349-1.771 1.046-2.044v-.027c-.697-.287-1.046-1-1.046-2.14V5.468c0-.793-.364-1.189-1.094-1.189V3c.993 0 1.714.19 2.16.571s.67 1.031.67 1.952v1.565c0 .861.349 1.292 1.046 1.292zm-9.967 4.142v-1.401c0-1.117-.351-1.816-1.053-2.099v-.027c.429-.175.71-.519.877-.995H3.049c-.173.247-.436.38-.805.38v1.258c.692 0 1.039.419 1.039 1.258v1.641c0 .934.226 1.584.677 1.948s1.174.547 2.167.547v-1.278c-.388 0-.666-.093-.838-.28-.17-.188-.256-.505-.256-.952z\" id=\"iconBg\"/><path class=\"icon-vs-action-blue\" d=\"M8 4L5 7H3l2-2H1V3h4L3 1h2l3 3z\" id=\"colorAction\"/></svg>",
            light: "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\"><style>.icon-canvas-transparent{opacity:0;fill:#f6f6f6}.icon-vs-out{fill:#f6f6f6}.icon-vs-bg{fill:#424242}.icon-vs-action-blue{fill:#00539c}</style><path class=\"icon-canvas-transparent\" d=\"M16 16H0V0h16v16z\" id=\"canvas\"/><path class=\"icon-vs-out\" d=\"M16 8.38v2.258s-.992-.001-.997-.003c-.012.052-.003.14-.003.281v1.579c0 1.271-.37 2.185-1.054 2.746-.638.522-1.576.759-2.822.759H10v-3.247s1.014-.001 1.037-.003c.004-.046-.037-.117-.037-.214V11.08c0-.943.222-1.606.539-2.072C11.223 8.527 11 7.843 11 6.869V5.468c0-.087.102-.286.094-.325-.02-.002.063-.143.03-.143H10V2h1.124c1.251 0 2.193.265 2.832.81C14.633 3.387 15 4.3 15 5.522V7h.919L16 8.38zM9.414 4l-4-4H.586l2 2H0v4h2v.586L1.586 7H1v.586L.586 8H1v1.638L1.329 11H2v1.536c0 1.247.495 2.149 1.19 2.711.641.517 1.697.753 2.937.753H7v-3.247s-1.011-.001-1.033-.003c-.008-.053.033-.127.033-.228v-1.401c0-.962-.224-1.637-.542-2.111.256-.378.444-.89.511-1.564L9.414 4z\" id=\"outline\" style=\"display: none;\"/><path class=\"icon-vs-bg\" d=\"M15 8.38v1.258c-.697 0-1.046.426-1.046 1.278v1.579c0 .961-.223 1.625-.666 1.989-.445.364-1.166.547-2.164.547v-1.278c.383 0 .661-.092.834-.277s.26-.498.26-.94V11.08c0-1.089.349-1.771 1.046-2.044v-.027c-.697-.287-1.046-1-1.046-2.14V5.468c0-.793-.364-1.189-1.094-1.189V3c.993 0 1.714.19 2.16.571s.67 1.031.67 1.952v1.565c0 .861.349 1.292 1.046 1.292zm-9.967 4.142v-1.401c0-1.117-.351-1.816-1.053-2.099v-.027c.429-.175.71-.519.877-.995H3.049c-.173.247-.436.38-.805.38v1.258c.692 0 1.039.419 1.039 1.258v1.641c0 .934.226 1.584.677 1.948s1.174.547 2.167.547v-1.278c-.388 0-.666-.093-.838-.28-.17-.188-.256-.505-.256-.952z\" id=\"iconBg\"/><path class=\"icon-vs-action-blue\" d=\"M8 4L5 7H3l2-2H1V3h4L3 1h2l3 3z\" id=\"colorAction\"/></svg>"
        };
        return _this;
    }
    ExportJson.prototype.exportJson = function () {
        var service = Service.getInstance();
        service.request({ command: this.props.idx != null ? "json:resultSet/" + this.props.idx : "json:resultSet" });
    };
    ExportJson.prototype.render = function (props, state) {
        var _this = this;
        return (Object(preact_min["h"])(fetch_Fetch, { resource: this.props.idx != null ? "resultSet/" + props.idx + "/rows/length" : "resultSet/length" }, function (response) { return (Object(preact_min["h"])(iconbutton_IconButton, { title: "Export json", icon: _this.icon, ready: !response.loading, onclick: _this.exportJson.bind(_this) })); }));
    };
    return ExportJson;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/header/style.css
var header_style = __webpack_require__("u3et");
var header_style_default = /*#__PURE__*/__webpack_require__.n(header_style);

// CONCATENATED MODULE: ./components/header/index.tsx
var header___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();


var header_Header = /** @class */ (function (_super) {
    header___extends(Header, _super);
    function Header() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Header.prototype.render = function (props, state) {
        return (Object(preact_min["h"])("div", { class: props.noBackground ? header_style_default.a.headerNoBackground : header_style_default.a.header },
            Object(preact_min["h"])("ul", null, props.children.map(function (child) {
                return Object(preact_min["h"])("li", { class: child.attributes.right ? header_style_default.a.right : header_style_default.a.left }, child);
            }))));
    };
    return Header;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/result/style.css
var result_style = __webpack_require__("oqlc");
var result_style_default = /*#__PURE__*/__webpack_require__.n(result_style);

// CONCATENATED MODULE: ./components/exporthtml/index.tsx
var exporthtml___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();




var exporthtml_ExportHtml = /** @class */ (function (_super) {
    exporthtml___extends(ExportHtml, _super);
    function ExportHtml() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.icon = {
            dark: "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" viewBox=\"0 0 16 16\"><g transform=\"matrix(4.1791045,0,0,4.3076924,-0.04477611,-0.07692331)\"><path d=\"M 1.3627119,2.0050847 1,2.4 1.6,3.1 1.4,3.5 0.4,2.4 0.76440678,2.0033898 Z M 2.6,1.3 3.6,2.4 2.6,3.5 2.4,3.1 3,2.4 2.4,1.7 Z\" style=\"fill:#c5c5c5;fill-opacity:1\" /><path d=\"M 2,1 1.25,1.75 h -0.5 l 0.5,-0.5 h -1 V 0.75000004 h 1 l -0.5,-0.5 h 0.5 z\" style=\"fill:#75beff;fill-opacity:1;\" /></g></svg>",
            light: "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" viewBox=\"0 0 16 16\"> <g transform=\"matrix(4.1791045,0,0,4.3076924,-0.04477611,-0.07692331)\"> <path d=\"M 1.3627119,2.0050847 1,2.4 1.6,3.1 1.4,3.5 0.4,2.4 0.76440678,2.0033898 Z M 2.6,1.3 3.6,2.4 2.6,3.5 2.4,3.1 3,2.4 2.4,1.7 Z\" style=\"fill:#424242;fill-opacity:1\" /> <path d=\"M 2,1 1.25,1.75 h -0.5 l 0.5,-0.5 h -1 V 0.75000004 h 1 l -0.5,-0.5 h 0.5 z\" style=\"fill:#00539c;fill-opacity:1;\" /> </g> </svg> "
        };
        return _this;
    }
    ExportHtml.prototype.exportHtml = function () {
        var service = Service.getInstance();
        service.request({ command: this.props.idx != null ? "html:resultSet/" + this.props.idx : "html:resultSet" });
    };
    ExportHtml.prototype.render = function (props, state) {
        var _this = this;
        return (Object(preact_min["h"])(fetch_Fetch, { resource: this.props.idx != null ? "resultSet/" + props.idx + "/rows/length" : "resultSet/length" }, function (response) { return (Object(preact_min["h"])(iconbutton_IconButton, { title: "Export HTML", icon: _this.icon, ready: !response.loading, onclick: _this.exportHtml.bind(_this) })); }));
    };
    return ExportHtml;
}(preact_min["Component"]));


// CONCATENATED MODULE: ./components/result/index.tsx
var result___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();












var result_Result = /** @class */ (function (_super) {
    result___extends(Result, _super);
    function Result(props, context) {
        return _super.call(this, props, context) || this;
    }
    Result.prototype.toggleHidden = function () {
        this.setState({ hidden: !this.state.hidden });
    };
    Result.prototype.changeRows = function (fromRow, toRow) {
        if (this.state.fromRow !== fromRow || this.state.toRow !== toRow) {
            this.setState({ fromRow: fromRow, toRow: toRow });
        }
    };
    Result.prototype.render = function (props, state) {
        var _this = this;
        return (Object(preact_min["h"])(fetch_Fetch, { resource: "pageRows", forceUpdate: true }, function (response) {
            if (response.data != null) {
                return (Object(preact_min["h"])("div", { class: result_style_default.a.result },
                    Object(preact_min["h"])(header_Header, null,
                        Object(preact_min["h"])(statement_Statement, { idx: props.idx }),
                        Object(preact_min["h"])(showhide_ShowHide, { right: true, onToggle: _this.toggleHidden.bind(_this) }),
                        Object(preact_min["h"])(exportcsv_ExportCsv, { right: true, idx: props.idx }),
                        Object(preact_min["h"])(exportjson_ExportJson, { right: true, idx: props.idx }),
                        Object(preact_min["h"])(exporthtml_ExportHtml, { right: true, idx: props.idx })),
                    Object(preact_min["h"])(hideable_Hideable, { hidden: state.hidden },
                        Object(preact_min["h"])(table_Table, { idx: props.idx, pageRows: response.data, fromRow: state.fromRow, toRow: state.toRow }),
                        Object(preact_min["h"])(pager_Pager, { idx: props.idx, pageRows: response.data, onPage: _this.changeRows.bind(_this) }))));
            }
        }));
    };
    return Result;
}(preact_min["Component"]));


// EXTERNAL MODULE: ./components/style.css
var components_style = __webpack_require__("0c/n");
var components_style_default = /*#__PURE__*/__webpack_require__.n(components_style);

// CONCATENATED MODULE: ./components/app.tsx
var app___extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();









var app_App = /** @class */ (function (_super) {
    app___extends(App, _super);
    function App() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    App.prototype.render = function (_a, _b) {
        return (Object(preact_min["h"])("div", null,
            Object(preact_min["h"])(fetch_Fetch, { resource: "resultSet/length" }, function (response) {
                return Object(preact_min["h"])("div", null,
                    response.data > 1 && (Object(preact_min["h"])(header_Header, { noBackground: true },
                        Object(preact_min["h"])(exportcsv_ExportCsv, { right: true }),
                        Object(preact_min["h"])(exportjson_ExportJson, { right: true }),
                        Object(preact_min["h"])(exporthtml_ExportHtml, { right: true }))),
                    response.loading && Object(preact_min["h"])("div", { class: components_style_default.a.loader_line }),
                    response.data > 0 && range(0, response.data - 1).map(function (idx) { return Object(preact_min["h"])(result_Result, { idx: idx }); }));
            })));
    };
    return App;
}(preact_min["Component"]));
/* harmony default export */ var app = (app_App);

// CONCATENATED MODULE: ./index.js


/* harmony default export */ var index_0 = __webpack_exports__["default"] = (app);

/***/ }),

/***/ "KM04":
/***/ (function(module, exports, __webpack_require__) {

!function () {
  "use strict";
  function e(e, t) {
    var n,
        o,
        r,
        i,
        l = W;for (i = arguments.length; i-- > 2;) {
      P.push(arguments[i]);
    }t && null != t.children && (P.length || P.push(t.children), delete t.children);while (P.length) {
      if ((o = P.pop()) && void 0 !== o.pop) for (i = o.length; i--;) {
        P.push(o[i]);
      } else "boolean" == typeof o && (o = null), (r = "function" != typeof e) && (null == o ? o = "" : "number" == typeof o ? o += "" : "string" != typeof o && (r = !1)), r && n ? l[l.length - 1] += o : l === W ? l = [o] : l.push(o), n = r;
    }var a = new T();return a.nodeName = e, a.children = l, a.attributes = null == t ? void 0 : t, a.key = null == t ? void 0 : t.key, void 0 !== M.vnode && M.vnode(a), a;
  }function t(e, t) {
    for (var n in t) {
      e[n] = t[n];
    }return e;
  }function n(e, t) {
    null != e && ("function" == typeof e ? e(t) : e.current = t);
  }function o(n, o) {
    return e(n.nodeName, t(t({}, n.attributes), o), arguments.length > 2 ? [].slice.call(arguments, 2) : n.children);
  }function r(e) {
    !e.__d && (e.__d = !0) && 1 == V.push(e) && (M.debounceRendering || D)(i);
  }function i() {
    var e;while (e = V.pop()) {
      e.__d && x(e);
    }
  }function l(e, t, n) {
    return "string" == typeof t || "number" == typeof t ? void 0 !== e.splitText : "string" == typeof t.nodeName ? !e._componentConstructor && a(e, t.nodeName) : n || e._componentConstructor === t.nodeName;
  }function a(e, t) {
    return e.__n === t || e.nodeName.toLowerCase() === t.toLowerCase();
  }function u(e) {
    var n = t({}, e.attributes);n.children = e.children;var o = e.nodeName.defaultProps;if (void 0 !== o) for (var r in o) {
      void 0 === n[r] && (n[r] = o[r]);
    }return n;
  }function c(e, t) {
    var n = t ? document.createElementNS("http://www.w3.org/2000/svg", e) : document.createElement(e);return n.__n = e, n;
  }function p(e) {
    var t = e.parentNode;t && t.removeChild(e);
  }function s(e, t, o, r, i) {
    if ("className" === t && (t = "class"), "key" === t) ;else if ("ref" === t) n(o, null), n(r, e);else if ("class" !== t || i) {
      if ("style" === t) {
        if (r && "string" != typeof r && "string" != typeof o || (e.style.cssText = r || ""), r && "object" == typeof r) {
          if ("string" != typeof o) for (var l in o) {
            l in r || (e.style[l] = "");
          }for (var l in r) {
            e.style[l] = "number" == typeof r[l] && !1 === E.test(l) ? r[l] + "px" : r[l];
          }
        }
      } else if ("dangerouslySetInnerHTML" === t) r && (e.innerHTML = r.__html || "");else if ("o" == t[0] && "n" == t[1]) {
        var a = t !== (t = t.replace(/Capture$/, ""));t = t.toLowerCase().substring(2), r ? o || e.addEventListener(t, _, a) : e.removeEventListener(t, _, a), (e.__l || (e.__l = {}))[t] = r;
      } else if ("list" !== t && "type" !== t && !i && t in e) {
        try {
          e[t] = null == r ? "" : r;
        } catch (e) {}null != r && !1 !== r || "spellcheck" == t || e.removeAttribute(t);
      } else {
        var u = i && t !== (t = t.replace(/^xlink:?/, ""));null == r || !1 === r ? u ? e.removeAttributeNS("http://www.w3.org/1999/xlink", t.toLowerCase()) : e.removeAttribute(t) : "function" != typeof r && (u ? e.setAttributeNS("http://www.w3.org/1999/xlink", t.toLowerCase(), r) : e.setAttribute(t, r));
      }
    } else e.className = r || "";
  }function _(e) {
    return this.__l[e.type](M.event && M.event(e) || e);
  }function f() {
    var e;while (e = A.shift()) {
      M.afterMount && M.afterMount(e), e.componentDidMount && e.componentDidMount();
    }
  }function d(e, t, n, o, r, i) {
    H++ || (R = null != r && void 0 !== r.ownerSVGElement, B = null != e && !("__preactattr_" in e));var l = h(e, t, n, o, i);return r && l.parentNode !== r && r.appendChild(l), --H || (B = !1, i || f()), l;
  }function h(e, t, n, o, r) {
    var i = e,
        l = R;if (null != t && "boolean" != typeof t || (t = ""), "string" == typeof t || "number" == typeof t) return e && void 0 !== e.splitText && e.parentNode && (!e._component || r) ? e.nodeValue != t && (e.nodeValue = t) : (i = document.createTextNode(t), e && (e.parentNode && e.parentNode.replaceChild(i, e), v(e, !0))), i.__preactattr_ = !0, i;var u = t.nodeName;if ("function" == typeof u) return N(e, t, n, o);if (R = "svg" === u || "foreignObject" !== u && R, u += "", (!e || !a(e, u)) && (i = c(u, R), e)) {
      while (e.firstChild) {
        i.appendChild(e.firstChild);
      }e.parentNode && e.parentNode.replaceChild(i, e), v(e, !0);
    }var p = i.firstChild,
        s = i.__preactattr_,
        _ = t.children;if (null == s) {
      s = i.__preactattr_ = {};for (var f = i.attributes, d = f.length; d--;) {
        s[f[d].name] = f[d].value;
      }
    }return !B && _ && 1 === _.length && "string" == typeof _[0] && null != p && void 0 !== p.splitText && null == p.nextSibling ? p.nodeValue != _[0] && (p.nodeValue = _[0]) : (_ && _.length || null != p) && m(i, _, n, o, B || null != s.dangerouslySetInnerHTML), y(i, t.attributes, s), R = l, i;
  }function m(e, t, n, o, r) {
    var i,
        a,
        u,
        c,
        s,
        _ = e.childNodes,
        f = [],
        d = {},
        m = 0,
        b = 0,
        y = _.length,
        g = 0,
        w = t ? t.length : 0;if (0 !== y) for (var C = 0; C < y; C++) {
      var x = _[C],
          N = x.__preactattr_,
          k = w && N ? x._component ? x._component.__k : N.key : null;null != k ? (m++, d[k] = x) : (N || (void 0 !== x.splitText ? !r || x.nodeValue.trim() : r)) && (f[g++] = x);
    }if (0 !== w) for (var C = 0; C < w; C++) {
      c = t[C], s = null;var k = c.key;if (null != k) m && void 0 !== d[k] && (s = d[k], d[k] = void 0, m--);else if (b < g) for (i = b; i < g; i++) {
        if (void 0 !== f[i] && l(a = f[i], c, r)) {
          s = a, f[i] = void 0, i === g - 1 && g--, i === b && b++;break;
        }
      }s = h(s, c, n, o), u = _[C], s && s !== e && s !== u && (null == u ? e.appendChild(s) : s === u.nextSibling ? p(u) : e.insertBefore(s, u));
    }if (m) for (var C in d) {
      void 0 !== d[C] && v(d[C], !1);
    }while (b <= g) {
      void 0 !== (s = f[g--]) && v(s, !1);
    }
  }function v(e, t) {
    var o = e._component;o ? k(o) : (null != e.__preactattr_ && n(e.__preactattr_.ref, null), !1 !== t && null != e.__preactattr_ || p(e), b(e));
  }function b(e) {
    e = e.lastChild;while (e) {
      var t = e.previousSibling;v(e, !0), e = t;
    }
  }function y(e, t, n) {
    var o;for (o in n) {
      t && null != t[o] || null == n[o] || s(e, o, n[o], n[o] = void 0, R);
    }for (o in t) {
      "children" === o || "innerHTML" === o || o in n && t[o] === ("value" === o || "checked" === o ? e[o] : n[o]) || s(e, o, n[o], n[o] = t[o], R);
    }
  }function g(e, t, n) {
    var o,
        r = F.length;e.prototype && e.prototype.render ? (o = new e(t, n), U.call(o, t, n)) : (o = new U(t, n), o.constructor = e, o.render = w);while (r--) {
      if (F[r].constructor === e) return o.__b = F[r].__b, F.splice(r, 1), o;
    }return o;
  }function w(e, t, n) {
    return this.constructor(e, n);
  }function C(e, t, o, i, l) {
    e.__x || (e.__x = !0, e.__r = t.ref, e.__k = t.key, delete t.ref, delete t.key, void 0 === e.constructor.getDerivedStateFromProps && (!e.base || l ? e.componentWillMount && e.componentWillMount() : e.componentWillReceiveProps && e.componentWillReceiveProps(t, i)), i && i !== e.context && (e.__c || (e.__c = e.context), e.context = i), e.__p || (e.__p = e.props), e.props = t, e.__x = !1, 0 !== o && (1 !== o && !1 === M.syncComponentUpdates && e.base ? r(e) : x(e, 1, l)), n(e.__r, e));
  }function x(e, n, o, r) {
    if (!e.__x) {
      var i,
          l,
          a,
          c = e.props,
          p = e.state,
          s = e.context,
          _ = e.__p || c,
          h = e.__s || p,
          m = e.__c || s,
          b = e.base,
          y = e.__b,
          w = b || y,
          N = e._component,
          U = !1,
          S = m;if (e.constructor.getDerivedStateFromProps && (p = t(t({}, p), e.constructor.getDerivedStateFromProps(c, p)), e.state = p), b && (e.props = _, e.state = h, e.context = m, 2 !== n && e.shouldComponentUpdate && !1 === e.shouldComponentUpdate(c, p, s) ? U = !0 : e.componentWillUpdate && e.componentWillUpdate(c, p, s), e.props = c, e.state = p, e.context = s), e.__p = e.__s = e.__c = e.__b = null, e.__d = !1, !U) {
        i = e.render(c, p, s), e.getChildContext && (s = t(t({}, s), e.getChildContext())), b && e.getSnapshotBeforeUpdate && (S = e.getSnapshotBeforeUpdate(_, h));var L,
            T,
            P = i && i.nodeName;if ("function" == typeof P) {
          var W = u(i);l = N, l && l.constructor === P && W.key == l.__k ? C(l, W, 1, s, !1) : (L = l, e._component = l = g(P, W, s), l.__b = l.__b || y, l.__u = e, C(l, W, 0, s, !1), x(l, 1, o, !0)), T = l.base;
        } else a = w, L = N, L && (a = e._component = null), (w || 1 === n) && (a && (a._component = null), T = d(a, i, s, o || !b, w && w.parentNode, !0));if (w && T !== w && l !== N) {
          var D = w.parentNode;D && T !== D && (D.replaceChild(T, w), L || (w._component = null, v(w, !1)));
        }if (L && k(L), e.base = T, T && !r) {
          var E = e,
              V = e;while (V = V.__u) {
            (E = V).base = T;
          }T._component = E, T._componentConstructor = E.constructor;
        }
      }!b || o ? A.push(e) : U || (e.componentDidUpdate && e.componentDidUpdate(_, h, S), M.afterUpdate && M.afterUpdate(e));while (e.__h.length) {
        e.__h.pop().call(e);
      }H || r || f();
    }
  }function N(e, t, n, o) {
    var r = e && e._component,
        i = r,
        l = e,
        a = r && e._componentConstructor === t.nodeName,
        c = a,
        p = u(t);while (r && !c && (r = r.__u)) {
      c = r.constructor === t.nodeName;
    }return r && c && (!o || r._component) ? (C(r, p, 3, n, o), e = r.base) : (i && !a && (k(i), e = l = null), r = g(t.nodeName, p, n), e && !r.__b && (r.__b = e, l = null), C(r, p, 1, n, o), e = r.base, l && e !== l && (l._component = null, v(l, !1))), e;
  }function k(e) {
    M.beforeUnmount && M.beforeUnmount(e);var t = e.base;e.__x = !0, e.componentWillUnmount && e.componentWillUnmount(), e.base = null;var o = e._component;o ? k(o) : t && (null != t.__preactattr_ && n(t.__preactattr_.ref, null), e.__b = t, p(t), F.push(e), b(t)), n(e.__r, null);
  }function U(e, t) {
    this.__d = !0, this.context = t, this.props = e, this.state = this.state || {}, this.__h = [];
  }function S(e, t, n) {
    return d(n, e, {}, !1, t, !1);
  }function L() {
    return {};
  }var T = function T() {},
      M = {},
      P = [],
      W = [],
      D = "function" == typeof Promise ? Promise.resolve().then.bind(Promise.resolve()) : setTimeout,
      E = /acit|ex(?:s|g|n|p|$)|rph|ows|mnc|ntw|ine[ch]|zoo|^ord/i,
      V = [],
      A = [],
      H = 0,
      R = !1,
      B = !1,
      F = [];t(U.prototype, { setState: function setState(e, n) {
      this.__s || (this.__s = this.state), this.state = t(t({}, this.state), "function" == typeof e ? e(this.state, this.props) : e), n && this.__h.push(n), r(this);
    }, forceUpdate: function forceUpdate(e) {
      e && this.__h.push(e), x(this, 2);
    }, render: function render() {} });var j = { h: e, createElement: e, cloneElement: o, createRef: L, Component: U, render: S, rerender: i, options: M }; true ? module.exports = j : self.preact = j;
}();
//# sourceMappingURL=preact.min.js.map

/***/ }),

/***/ "QvR7":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"pager":"pager__36wtE"};

/***/ }),

/***/ "Uqx6":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"hidden":"hidden__3Phga","showing":"showing__tPtmo"};

/***/ }),

/***/ "oqlc":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"result":"result__1qTTi"};

/***/ }),

/***/ "r2IK":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"statement":"statement__3pbv5","code":"code__1CP9D","statementCollapsed":"statementCollapsed__5fohV"};

/***/ }),

/***/ "tWQK":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"btn":"btn__JPjzb","loader":"loader__25HEU","spin":"spin__8xLiB"};

/***/ }),

/***/ "u3et":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"left":"left__2XgF-","right":"right__1FoI1","headerNoBackground":"headerNoBackground__1__m-","header":"header__2MqSo"};

/***/ }),

/***/ "ukti":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin
module.exports = {"table":"table__zB5U6"};

/***/ })

/******/ });
//# sourceMappingURL=ssr-bundle.js.map