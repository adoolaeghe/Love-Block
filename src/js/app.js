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

      var marriageInstance;

      web3.eth.getAccounts(function(error, accounts) {
        if (error) {
          console.log(error);
        }
        var senderAccountId = accounts[0];
        console.log(senderAccountId);

      App.contracts.Marriages.deployed().then(function(instance) {
        marriageInstance = instance;
        console.log("1");
        return marriageInstance.proposalNew(senderAccountId, receiverAccountId);
        console.log("2");
        }).then(function(result) {
          console.log("3");
          setTimeout(function() { App.checkForMatchingProposal(senderAccountId, receiverAccountId);}, 3000);
        }).catch(function(err) {
          console.log(err.message);
        });
      });
    });
  },

  checkForMatchingProposal: function(senderAccountId, receiverAccountId) {
    $('.container-propose').hide();

    App.contracts.Marriages.deployed().then(function(instance) {
      marriageInstance = instance;
      return marriageInstance.proposalMatch.call(senderAccountId,receiverAccountId);
    }).then(function(isMatching) {
      if (isMatching) {
        console.log("4");
        App.handleUpdatePendingPage(senderAccountId, receiverAccountId);
      } else {
        console.log("5");
        $('.container-propose').hide();
        $('.container-pending-proposal').show();
      }
    });
  },

  handleUpdatePendingPage: function(senderAccountId, receiverAccountId) {
    var marriageInstance;

    if(true){
      $('.container-pending-proposal').hide();
      $('.container-confirmation').show();
    }

    App.contracts.Marriages.deployed().then(function(instance) {
      marriageInstance = instance;
      return marriageInstance.marriageNew(senderAccountId,receiverAccountId);
    }).then(function(result) {
      console.log("6");
      return marriageInstance.marriageNew.call(senderAccountId,receiverAccountId);
    }).then(function(marId){
      console.log("7");
      console.log(marId);
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleGetPersonDetails() {
      $('.personalDetailsButton').click(function(event){
        event.preventDefault();
        var data = $('form').serializeArray();
        console.log(data);

        web3.eth.getAccounts(function(error, accounts) {
          if (error) {
            console.log(error);
          }
          var senderAccountId = accounts[0];
          console.log(senderAccountId);

          var firstName = data[2].value;
          var middleName = data[3].value;
          var lastName = data[4].value;
          var dateOfBirth = data[5].value;
          var id = data[6].value;

        App.contracts.Marriages.deployed().then(function(instance) {
          marriageInstance = instance;
          console.log(senderAccountId);

          return marriageInstance.marriageGetMarIdForPerson.call(senderAccountId);
          }).then(function(marId){
            console.log("8")
            console.log(marId);
            App.handleAddPersonToMarriage(marId, senderAccountId, firstName, middleName, lastName, dateOfBirth, id);
          }).catch(function(err) {
            console.log(err.message);
          });
        });
      });
    },

  handleAddPersonToMarriage(marId, _address, firstName, middleName, lastName, dateOfBirth, id) {
    App.contracts.Marriages.deployed().then(function(instance) {
      marriageInstance = instance;
      marriageInstance.addPerson(marId, _address, firstName, middleName, lastName, dateOfBirth, id);
      console.log("9, person has been added to the marriage");
    });
  },

  handleClickYesIdo: function() {
    $('.confirmYesButton').click(function(event){
      event.preventDefault();
      $('.container-confirmation').hide();
      $('.container-form').show();
    });
    $('.confirmNoButton').click(function(event){
      event.preventDefault();
      $('.container-confirmation').hide();
      $('.container-cancelled').show();
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
    App.handleClickYesIdo();
    App.handleGetPersonDetails();
    App.handleCertificate();
  });
});
