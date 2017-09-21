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
      var updatePage = $(".container-m-id");
      updatePage.append("Your marId is " + marId);
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

        var firstName = data[1].value;
        var middleName = data[2].value;
        var lastName = data[3].value;
        var dateOfBirth = data[4].value;
        var id = data[5].value;

        App.contracts.Marriages.deployed().then(function(instance) {
          marriageInstance = instance;
          console.log(senderAccountId);

          return marriageInstance.marriageGetMarIdForPerson.call(senderAccountId);
        }).then(function(marId){
          console.log("8");
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
      instance.addPerson(marId, _address, firstName, middleName, lastName, dateOfBirth, id).then(function(result) {
        console.log("9, person has been added to the marriage");
        console.log("Retreiving people names...");
        instance.marriageGetPersonFirstName.call(marId, 0).then(function(name) {
          console.log(web3.toAscii(name));
        });
        instance.marriageGetPersonFirstName.call(marId, 1).then(function(name) {
          console.log(web3.toAscii(name));
        });
        App.handleCompletionPendingPage(marId);
      });
    });
  },

  handleCompletionPendingPage: function(marId) {
    $('.container-form').hide();
    $('.container-pending-marriage').show();
    var complete = false;

    timerId = setInterval(function() {
      App.contracts.Marriages.deployed().then(function(marriages) {
        console.log('Requesting completion for marId:');
        console.log(marId);
        marriages.marriageIsComplete.call(marId).then(function(isComplete) {
          console.log(isComplete);
          if(isComplete) {
            $('.container-complete-marriage').show();
            console.log('Completion confirmed.');
            App.renderCertificate(marId);
            clearInterval(timerId);
          }
        });
      });
    }, 3000);
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

  renderCertificate: function(marId) {
    // Define person1 data
    var person1FirstName;
    var person1MiddleName;
    var person1LastName;
    var person1DateOfBirth;
    var person1Id;

    // Define person2 data
    var person2FirstName;
    var person2MiddleName;
    var person2LastName;
    var person2DateOfBirth;
    var person2Id;

    // Load data from blockchain
    App.contracts.Marriages.deployed().then(function(marriages) {
      var printedCertificate = $(".printed-certificate");
      // Person 1
      marriages.marriageGetPersonFirstName.call(marId, 0).then(function(result) {
        person1FirstName = result;
        console.log("found " + web3.toAscii(person1FirstName));
        printedCertificate.append(web3.toAscii(person1FirstName));
      });
      marriages.marriageGetPersonMiddleName.call(marId, 0).then(function(result) {
        person1MiddleName = result;
        printedCertificate.append(web3.toAscii(person1MiddleName));
      });
      marriages.marriageGetPersonLastName.call(marId, 0).then(function(result) {
        person1LastName = result;
        printedCertificate.append(web3.toAscii(person1LastName));
      });
      marriages.marriageGetPersonDateOfBirth.call(marId, 0).then(function(result) {
        person1DateOfBirth = result;
        printedCertificate.append(person1DateOfBirth);
      });
      marriages.marriageGetPersonId.call(marId, 0).then(function(result) {
        person1Id = result;
        printedCertificate.append(person1Id);
      });

      // Person 2
      marriages.marriageGetPersonFirstName.call(marId, 1).then(function(result) {
        person2FirstName = result;
        printedCertificate.append(web3.toAscii(person2FirstName));
      });
      marriages.marriageGetPersonMiddleName.call(marId, 1).then(function(result) {
        person2MiddleName = result;
        printedCertificate.append(web3.toAscii(person2MiddleName));
      });
      marriages.marriageGetPersonLastName.call(marId, 1).then(function(result) {
        person2LastName = result;
        printedCertificate.append(web3.toAscii(person2LastName));
      });
      marriages.marriageGetPersonDateOfBirth.call(marId, 1).then(function(result) {
        person2DateOfBirth = result;
        printedCertificate.append(person2DateOfBirth);
      });
      marriages.marriageGetPersonId.call(marId, 1).then(function(result) {
        person2Id = result;
        printedCertificate.append(person2Id);
      });
    });
    // Show/hide the relevant views and render the data obtained above

  },

  handleCertificate: function(){
    $('.certificateButton').click(function(event){
      // retrieve the marriage certificate.
      event.preventDefault();
      $('.container-complete-marriage').hide();
      $('.container-certificate').show();
    });
    // web3.eth.getAccounts(function(error, accounts) {
    //   if (error) {
    //     console.log(error);
    //   }

    //   var senderAccountId = accounts[0];
    //   console.log(senderAccountId);
    //
    //   App.contracts.Marriages.deployed().then(function(instance) {
    //     marriageInstance = instance;
    //     console.log(senderAccountId);
    //     return marriageInstance.marriageGetMarIdForPerson.call(senderAccountId);
    //   }).then(function(marId){
    //     console.log("9");
    //     console.log(marId);
    //     App.renderCertificate(marId);
    //   }).catch(function(err) {
    //     console.log(err.message);
    //   });
    // });
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
