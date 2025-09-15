// ==UserScript==
// @name         DarkMode
// @version      1.3
// @description  Auto enable darkmode on Roblox.com
// @author       RobloxThot
// @match        https://*.roblox.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=roblox.com
// ==/UserScript==

(async function() {
    'use strict';
    var loggedIn = false;
    try{
        // This is just my jank way of checking if you are logged in
        await (await fetch("https://friends.roblox.com/v1/user/friend-requests/count", {
            "credentials": "include"
        })).json();
        loggedIn = true;
    }catch{}
    if (!document.body.classList.contains('dark-theme')){
        if(loggedIn){
            // If we are logged in then attempt to enable dark mode
            fetch("https://accountsettings.roblox.com/v1/themes/user", {
                "headers": {
                    "content-type": "application/x-www-form-urlencoded",
                    "x-csrf-token": document.querySelectorAll('[data-token]')[0].attributes['data-token'].value
                },
                "body": "themeType=Dark",
                "method": "PATCH",
                "credentials": "include"
            })
        }
        // Applies darkmode to the body so that it's always dark even if not logged in
        document.body.classList.add('dark-theme');
    }
})();
