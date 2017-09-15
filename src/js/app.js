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
      // return App.markAdopted();
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
      $('.container-propose').hide();
      $('.container-pending').show();
      var data = $('form').serialize();
      console.log("here");
      console.log(data);
    });
  }

};

$(function() {
  $(window).load(function() {
    // App.init();
    App.handleGetMarried();
    App.handleSendProposal();
  });
});
