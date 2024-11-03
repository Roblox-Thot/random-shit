Roblox.ProtocolHandlerClientInterface.doAuthTicketRequest().then(function (_,_,xhr) {
      const authenticationTicket = xhr.getResponseHeader('RBX-Authentication-Ticket');
      console.log(authenticationTicket);
});