// ==UserScript==
// @name         HCaptcha AutoClicker
// @namespace    http://tampermonkey.net/
// @version      2025-08-28
// @description  try to take over the world!
// @author       You
// @match        https://newassets.hcaptcha.com/captcha*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=hcaptcha.com
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    function print(msg) {console.log("AUTOCLICKER",msg)}

    // Scans every second since more isn't needed
    const scanning = setInterval(search, 1000);
    function search() {
        const button = document.querySelector("#checkbox");
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