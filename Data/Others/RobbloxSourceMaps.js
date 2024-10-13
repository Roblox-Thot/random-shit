const scriptTags = Array.from(document.querySelectorAll('script'));
const scriptSrcs = scriptTags.map(tag=>tag.src).filter(i=>i);
const SOURCE_MAPPING_URL = "//# sourceMappingURL=";

const maybeSourceMappingURLs = await Promise.allSettled(scriptSrcs.map(async(src)=>{
    if(src.includes('hsts.js')) return;
    const code = await fetch(src).then(resp=>resp.text());

    if (!code.includes(SOURCE_MAPPING_URL)) {
        throw new Error('This scripts don\'t have sourcemap');
    }

    const srcUrl = new URL(window.location.href);

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
console.log(maybeSourceMappingURLs)
const sourceMappingURLs = maybeSourceMappingURLs.filter(entry=>entry.status === 'fulfilled').map(entry=>entry.value);
console.log(sourceMappingURLs.join("\n"));
