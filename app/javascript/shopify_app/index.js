import "https://cdn.jsdelivr.net/npm/@shopify/app-bridge@3.7.9/umd/index.min.js";

var AppBridge = window["app-bridge"];
var actions = window["app-bridge"].actions;
var createApp = AppBridge.default;
var app = createApp({
  apiKey: "a7dba99a1a0a96f6939e42ec27ed917a",
  host: new URLSearchParams(location.search).get("host"),
});
const getSessionToken = window["app-bridge"].utilities.getSessionToken;
console.log(window);
