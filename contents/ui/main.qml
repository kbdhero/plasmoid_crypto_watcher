import QtQuick 2.0

Item {
    id: root
    width: 250
    height: 100

    property string currBtcPrice: ""
    property string currEthPrice: ""
    
    function setEthPrice(res){
      if (res.responseText){
         var eth = JSON.parse(res.responseText);
         root.currEthPrice = eth.price.usd;
      }
    }
    
    function setBtcPrice(res){
      if (res.responseText){
         var btc = JSON.parse(res.responseText);
         root.currBtcPrice = btc.price.usd;
      }
    }

    function request(url, callback){
       var xhr = new XMLHttpRequest();
       xhr.onreadystatechange = ( function f() { callback(xhr)});
       xhr.open('GET', url, true);
       xhr.send();
    }

    function makeRequests(){
       request('https://coinmarketcap-nexuist.rhcloud.com/api/eth', setEthPrice)
       request('https://coinmarketcap-nexuist.rhcloud.com/api/btc', setBtcPrice)
    }

    Timer {
      running: true
      triggeredOnStart: true
      interval: 60000
      onTriggered: makeRequests()
    }

    Column {
      Text { text: "ETH price: " + root.currEthPrice }
      Text { text: "BTC price: " + root.currBtcPrice }
    }
}


