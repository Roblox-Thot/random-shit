(async function() {
    var csrf = Roblox.XsrfToken.getToken()

    var ticket = (await fetch("https://auth.roblox.com/v1/authentication-ticket", {
        method: "POST",
        credentials: "include",
        headers: {
            "x-csrf-token": csrf,
            "Content-Type": "application/json"
        }
    })).headers.get("rbx-authentication-ticket")

    console.log(ticket);
})()
