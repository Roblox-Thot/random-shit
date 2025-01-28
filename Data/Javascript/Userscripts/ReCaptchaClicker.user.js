// ==UserScript==
// @name         Recaptcha Autoclick
// @namespace    http://google.com/
// @version      2024-12-18
// @description  autoclicks Recaptcha
// @author       Roblox-Thot
// @match        https://*.google.com/recaptcha/api2/anchor*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=google.com
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';
    function print(msg) {console.log("AUTOCLICKER",msg)}

    // Scans every second since more isn't needed
    const scanning = setInterval(search, 1000);
    function search() {
        const button = document.querySelector("#recaptcha-anchor > div.recaptcha-checkbox-border");
        // Checks if the button exists to prevent issues
        if (button) {
            // Stops scanning
            clearInterval(scanning);

            print("Found button, waiting a bit to click it")

            setTimeout(function() {
                button.click();
            }, 100);

        }
    }
})();
