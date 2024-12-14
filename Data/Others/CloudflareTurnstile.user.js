// ==UserScript==
// @name         Cloudflare Turnstile Autoclick
// @namespace    http://cloudflare.com/
// @version      2024-12-14
// @description  autoclicks the CF turnstiles
// @author       Roblox-Thot
// @match        https://challenges.cloudflare.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=cloudflare.com
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    const originalAttachShadow = Element.prototype.attachShadow;

    // Hooks the attachShadow function
    Element.prototype.attachShadow = function (init) {
        // Return the old attachShadow function
        Element.prototype.attachShadow = originalAttachShadow
        
        // Call the original function to return later
        const shadowRoot = originalAttachShadow.call(this, init);

        // Scans every second since more isn't needed
        const scanning = setInterval(search, 1000);
        function search() {
            const inputs = shadowRoot.querySelectorAll('input[type="checkbox"]');
            console.log(inputs);
            inputs.forEach(function(input) {
                input.click();

                // Stops scanning
                clearInterval(scanning);
            });
        }

        // Return original output to make sure nothing breaks
        return shadowRoot;
    };
})();