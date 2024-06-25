(async function() {
    var csrf = (await fetch("https://auth.roblox.com/v1/authentication-ticket", {
        method: "POST",
        credentials: "include"
    })).headers.get("x-csrf-token")

    var ticket = (await fetch("https://auth.roblox.com/v1/authentication-ticket", {
        method: "POST",
        credentials: "include",
        headers: {"x-csrf-token": csrf}
    })).headers.get("rbx-authentication-ticket")

    console.log(ticket);
})()
t