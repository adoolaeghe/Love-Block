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
    return App.initContract();
  },

  initProposal: function(){
    $.getJSON('Marriage.json', function(data) {
      var MarriageArtifact = data;
      App.contracts.Marriage = TruffleContract(MarriageArtifact);
      App.contracts.Marriage.setProvider(App.web3Provider);
    });
    return App.bindEvents();
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
      var data = $('form').serialize();
      // Make a new proposal if the Accountid is not in the marriage record
      // If marriage proposal is created, page loads the pending request page.
      if(x){
        $('.container-propose').hide();
        $('.container-pending').show();
      }
    });
  },

  handleUpdatePendingPage: function(){
    // Recursive function ???
    // If the marriage request matches, page loads the confirmation page
    if(true){
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
    App.handleGetMarried();
    App.handleSendProposal();
    App.handleUpdatePendingPage();
    App.handleConfirmation();
    App.handleCertificate();
  });
});
