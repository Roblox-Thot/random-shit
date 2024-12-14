const scriptTags = Array.from(document.querySelectorAll('script'));
const scriptSrcs = scriptTags.map(tag=>tag.src).filter(i=>i);
const pageHref = window.location.href;
const newtab = false; // Opens a new tab with all the urls

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
        return new URL(sourceMappingURL, pageHref).href;
    }

    const basePath = new URL(src, pageHref).href;
    return new URL(sourceMappingURL, basePath).href;
}
));

const sourceMappingURLs = maybeSourceMappingURLs.filter(entry=>entry.status === 'fulfilled').map(entry=>entry.value);
console.log(sourceMappingURLs.join("\n"));

if (newtab){
    var tab = window.open('about:blank', '_blank');
    tab.document.write(sourceMappingURLs.join("<br>"));
    tab.document.close();
}
