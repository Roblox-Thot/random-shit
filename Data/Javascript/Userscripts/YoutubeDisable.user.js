// ==UserScript==
// @name         Disable number keys
// @namespace    http://tampermonkey.net/
// @version      2024-05-07
// @description  Removes the number keys on youtube videos
// @author       You
// @match        https://www.youtube.com/watch*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=youtube.com
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    console.log("content.js");

    const disabledKeyCodes = new Set([
        // Num pad
        12,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        45,
        96,
        97,
        98,
        99,
        100,
        101,
        102,
        103,
        104,
        105,

        // Num row
        48,
        49,
        50,
        51,
        52,
        53,
        54,
        55,
        56,
        57,

        // Minus Plus
        187,
        189,
    ]);

    window.addEventListener(
        "keydown",
        function(e) {
            if (disabledKeyCodes.has(e.which)) {
                e.stopPropagation();
            }
        },
        true
    );
})();