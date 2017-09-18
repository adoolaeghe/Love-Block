App = {
  web3Provider: null,
  contracts: {},

  initWeb3: function() {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
      web3 = new Web3(App.web3Provider);
    }
    return App.initProposal();
  },

  initProposal: function(){
    $.getJSON('Marriages.json', function(data) {
      var MarriagesArtifact = data;
      App.contracts.Marriages = TruffleContract(MarriagesArtifact);
      App.contracts.Marriages.setProvider(App.web3Provider);
    });
    // return App.bindEvents();
  },

  handleGetMarried: function(){
    $('.getMarriedButton').click(function(){
      $('.container-main').hide();
      $('.container-propose').show();
    });
  },

  handleSendProposal: function(){
    $('.sendProposalButton').click(function(event){
      event.preventDefault();

      var data = $('form').serializeArray();
      var receiverAccountId = data[0].value;
      console.log(receiverAccountId);

      web3.eth.getAccounts(function(error, accounts) {
        if (error) {
          console.log(error);
        }
        var senderAccountId = accounts[0];
        console.log(senderAccountId);

        App.contracts.Marriages.deployed().then(function(instance) {
          marriageInstance = instance;
          console.log("1");
          console.log(marriageInstance);
          return marriageInstance.marriageNew(senderAccountId, receiverAccountId);
          console.log("2");
          }).then(function(result) {
            console.log("3");
          }).catch(function(err) {
            console.log(err.message);
          });
        // Make a new proposal if the Accountid is not in the marriage record
        // If marriage proposal is created, page loads the pending request page.
        $('.container-propose').hide();
        $('.container-pending').show();
      });
    });
  },

  handleUpdatePendingPage: function(){
    // Recursive function ???
    // If the marriage request matches, page loads the confirmation page
    if(false){
      $('.container-pending').hide();
      $('.container-confirmation').show();
    }
  },

  handleConfirmation: function(){
    // When a confirm button is triggered, page checks if the other has already confrimed or loads a pending page
    // Redirect to successful or unsuccessful marriage.
    $('.confirmYesButton').click(function(event){
      event.preventDefault();
      $('.container-confirmation').hide();
      $('.container-congratulation').show();
    });
    $('.confirmNoButton').click(function(event){
      $('.container-confirmation').hide();
      $('.container-cancellation').show();
    });
  },

  handleCertificate: function(){
    $('.downloadCertificate').click(function(event){
      // retrieve the marriage certificate.
    });
  }
};

$(function() {
  $(window).load(function() {
    App.initWeb3();
    App.handleGetMarried();
    App.handleSendProposal();
    App.handleUpdatePendingPage();
    App.handleConfirmation();
    App.handleCertificate();
  });
});
