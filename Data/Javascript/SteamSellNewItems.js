// Get the element with the ID 'newitemscroll'
var newItems = document.getElementById('newitemscroll');

// Check if the element exists
if (newItems) {
    let children = newItems.children;
    let list = '';
    let addedHashes = [];

    for (let i = 0; i < children.length; i++) {
        let child = children[i];
		let splitting = child.href.split('_');
		let code = splitting[splitting.length - 1];
        let itemData = window.g_ActiveInventory.m_rgAssets[code];

        // If you can't sell the item skip it (not 100% tested)
    	if (!itemData) continue;

		let description = itemData.description

		// Can't be sold so skip over it
        if (!description.marketable) continue;

        // If the item is already in the list skip it
        if (addedHashes.includes(description.market_hash_name)) continue;

        addedHashes.push(description.market_hash_name);
        list += '&items[]=' + encodeURIComponent(itemData.description.market_hash_name);
    }
    
    let sellLink = 'https://steamcommunity.com/market/multisell?appid=753&contextid=6' + list
    console.log(sellLink);
} else {
    console.log('No "newitemscroll" so no new items.');
}

