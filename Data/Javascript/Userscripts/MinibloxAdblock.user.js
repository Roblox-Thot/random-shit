// ==UserScript==
// @name         Miniblox Adblock
// @namespace    http://Roblox-Thot.github.io
// @version      2024-12-22
// @description  A browser script made to give enhancements on miniblox.io
// @author       Roblox-Thot
// @match        https://miniblox.io/*
// @icon         https://miniblox.io/favicon.png
// @grant        unsafeWindow
// @run-at       document-start
// ==/UserScript==

let replacements = {};

function addReplacement(replacement, code, replaceit) {
	replacements[replacement] = [code, replaceit];
}

function modifyCode(text) {
	for(const [replacement, code] of Object.entries(replacements)){
		text = text.replaceAll(replacement, code[1] ? code[0] : replacement + code[0]);
	}

	var newScript = document.createElement("script");
	newScript.type = "module";
	newScript.crossOrigin = "";
	newScript.textContent = text;
	var head = document.querySelector("head");
	head.appendChild(newScript);
	newScript.textContent = "";
	newScript.remove();
}

(function() {
	'use strict';

	addReplacement('document.addEventListener("DOMContentLoaded",startGame,!1);', `
		setTimeout(function() {
			var DOMContentLoaded_event = document.createEvent("Event");
			DOMContentLoaded_event.initEvent("DOMContentLoaded", true, true);
			document.dispatchEvent(DOMContentLoaded_event);
		}, 0);
	`);

	addReplacement('this.game.unleash.isEnabled("disable-ads")', 'true', true);

	async function execute(src, oldScript) {
		if (oldScript) oldScript.type = 'javascript/blocked';
		await fetch(src).then(e => e.text()).then(e => modifyCode(e));
		if (oldScript) oldScript.type = 'module';
	}

	// https://stackoverflow.com/questions/22141205/intercept-and-alter-a-sites-javascript-using-greasemonkey
	if (navigator.userAgent.indexOf("Firefox") != -1) {
		window.addEventListener("beforescriptexecute", function(e) {
			if (e.target.src.includes("https://miniblox.io/assets/index")) {
				e.preventDefault();
				e.stopPropagation();
				execute(e.target.src);
			}
		}, false);
	} else {
		new MutationObserver(async (mutations, observer) => {
			let oldScript = mutations
				.flatMap(e => [...e.addedNodes])
				.filter(e => e.tagName == 'SCRIPT')
				.find(e => e.src.includes("https://miniblox.io/assets/index"));

			if (oldScript) {
				observer.disconnect();
				execute(oldScript.src, oldScript);
			}
		}).observe(document, {
			childList: true,
			subtree: true,
		});
	}
})();
