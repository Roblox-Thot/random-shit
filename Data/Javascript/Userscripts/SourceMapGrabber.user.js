// ==UserScript==
// @name         Source Map Grabber
// @namespace    http://tampermonkey.net/
// @version      2024-11-14
// @description  Grabs source maps from most(tm) sites
// @author       RobloxThot
// @match        *://*/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=roblox.com
// @run-at       document-idle
// @grant        GM_registerMenuCommand
// ==/UserScript==

(async function() {
    'use strict';

    if (window.top == window.self) {
        const scriptTags = Array.from(document.querySelectorAll('script'));
        const scriptSrcs = scriptTags.map(tag=>tag.src).filter(i=>i);

        const maybeSourceMappingURLs = await Promise.allSettled(scriptSrcs.map(async(src)=>{
            const code = await fetch(src).then(resp=>resp.text());

            if (!code.includes("//# sourceMappingURL=")) {
                throw new Error('This scripts don\'t have sourcemap');
            }

            let sourceMappingURL = code.match(/\/\/# sourceMappingURL=(.*\.map)/)[1];
            if (sourceMappingURL.includes("http")) {
                return sourceMappingURL;
            }

            if (src.startsWith("http")) {
                return new URL(sourceMappingURL,src).href;
            }

            if (sourceMappingURL.startsWith("/")) {
                return new URL(sourceMappingURL,window.location.href).href;
            }

            const basePath = new URL(src,window.location.href).href;
            return new URL(sourceMappingURL,basePath).href;
        }
        ));

        const sourceMappingURLs = maybeSourceMappingURLs.filter(entry=>entry.status === 'fulfilled').map(entry=>entry.value);

        let newArray = sourceMappingURLs;

        GM_registerMenuCommand(`SM Count: ${newArray.length}`, function() {
            document.write('<style>body{background-color: black;color:white;}</style>')
            document.write(newArray.join("<br>"))
        });
    }
})();
