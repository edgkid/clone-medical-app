import '../peerjs.min.js'
import consumer from "./consumer"
import { broadcastData } from '../call_utils'

var me = {};
var myStream;
var peers = {};
var call = {}
var isStarted = false;
var chat_id;
var current_user_id;

const init = () => { 
  navigator.getUserMedia = 
    (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);

  if (!navigator.getUserMedia) return unsupported();

  getLocalAudioStream(function(err, stream) {
    if (err || !stream) return;

    connectToPeerJS(function(err) {
      if (err) return;
      registerIdWithServer(me.id);
      if (call?.peers?.length) callPeers();
      else displayShareMessage();
    });
  });
}


const connectToPeerJS = (cb) => {
  // display('Connecting to PeerJS...');
  me = new Peer({
    host: 'medi-chat-peerserver.herokuapp.com',
    debug: 1,
    secure: true,
    port: '',
    path: '/peerjs/myapp'
  });

  me.on('call', handleIncomingCall);
  
  me.on('open', function() {
    // display('Connected.');
    // display('ID: ' + me.id);
    // console.log('aja', window.M)
    initModal('.modal')
    $('#finishcall').show()
    $('#startcall').hide()


    cb && cb(null, me);
  });
  
  me.on('error', function(err) {
    // display(err);
    cb && cb(err);
    $('#startcall').prop('disabled', false);
  });
}

const initModal = (selector) => {
  var elems = document.querySelectorAll(selector);
  var instances = M.Modal.init(elems, {});
  M.Modal.getInstance(elems[0]).open();
}



const registerIdWithServer = () => {
  // display('Registering ID with server...');
  // $.post('/' + call.id + '/addpeer/' + me.id);
  broadcastData('/add_peer', {
    call_id: chat_id,
    peer_id: me.id,
    current_user_id: current_user_id || Number($('.chat-box').data('user'))
  })
} 

// Call each of the peer IDs using PeerJS
const callPeers = () => {
  call.peers.forEach(callPeer);
}

const callPeer = (peerObjec) => {
  // display('Calling ' + peerId + '...');
  if(peerObjec['peer_id'] === me.id) return;

  var peer = getPeer(peerObjec['peer_id']);
  peer.outgoing = me.call(peerObjec['peer_id'], myStream);
  console.log('peer', peer)

  peer.outgoing.on('error', function(err) {
    // display(err);
  });

  peer.outgoing.on('stream', function(stream) {
    // display('Connected to ' + peerId + '.');
    addIncomingStream(peer, stream);
  });
}

// When someone initiates a call via PeerJS
const handleIncomingCall = (incoming) => {
  console.log('incoming', incoming)
  // display('Answering incoming call from ' + incoming.peer);
  var peer = getPeer(incoming.peer);
  peer.incoming = incoming;
  incoming.answer(myStream);
  peer.incoming.on('stream', function(stream) {
    addIncomingStream(peer, stream);
  });
}

// Add the new audio stream. Either from an incoming call, or
// from the response to one of our outgoing calls
const addIncomingStream = (peer, stream) => {
  // display('Adding incoming stream from ' + peer.id);
  peer.incomingStream = stream;
  playStream(stream);
}


// Create an <audio> element to play the audio stream
const playStream = (stream) => {
  var audio = $('<audio autoplay />').appendTo('body');
  console.log(window.URL)
  audio[0].srcObject = stream;
}


// Remove our ID from the call's list of IDs
// function unregisterIdWithServer() {
//   $.post('/' + call.id + '/removepeer/' + me.id);
// }

const getLocalAudioStream = (cb) => {
  // display('Trying to access your microphone. Please click "Allow".');

  navigator.getUserMedia (
    {video: false, audio: true},

    function success(audioStream) {
      // display('Microphone is open.');
      myStream = audioStream;
      if (cb) cb(null, myStream);
    },

    function error(err) {
      // display('Couldn\'t connect to microphone. Reload the page to try again.');
      $('#startcall').prop('disabled', false);
      if (cb) cb(err);
    }
  );
}




////////////////////////////////////
// Helper functions
const getPeer = (peerId) => {
  return peers[peerId] || (peers[peerId] = {id: peerId});
}

const displayShareMessage = () => {
  // display('Give someone this URL to chat.');
  // display('<input type="text" value="' + location.href + '" readonly>');
  
  // $('#display input').click(function() {
  //   this.select();
  // });
}

const unsupported = () => {
  // display("Your browser doesn't support getUserMedia.");
}

function display(message) {
  $('<div />').html(message).appendTo('body');
}



// const initSubscription = () => {
  consumer.subscriptions.create("CallChannel", {
    // broadcastData: broadcastData,
    connected() {
      // Called when the subscription is ready for use on the server
      // console.log('11111111111111111111')
      // thisUserId = $('#chat').data('user')
      // this.broadcastData({ type: JOIN_CALL, from: thisUserId});
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received: (data) => {
      if(data?.action == 'newCall' && !isStarted) {
        initModal('#incomingCall')
      } else {

        if(!isStarted) return;

        call = data?.call

        if(data == null  && me){
          myStream.getTracks().forEach(function(track) {
            track.stop();
          }); 
          call = {}
          isStarted = false
          $('#finishcall').hide()
          $('#startcall').show()      
        }
        console.log(call, data)

        if (call?.peers?.length && me.call) callPeers();
      }
    }
  });
// }

$(document).on('turbolinks:load', () => {

  if(!document.getElementById('chat-box'))
    return

  call = call || {}

  $('#finishcall').hide()
  
  chat_id = Number($('.chat-box').data('chat'))
  current_user_id = current_user_id || Number($('.chat-box').data('user'))

  $('#startcall').on('click', (e) => {
    e.preventDefault()
    initCall(true)
  })

  $('#incomingCallButton').on('click', (e) => {
    e.preventDefault()
    initCall()
  })

  

  $('.close-call').on('click', (e) => {
    closeCall()
  })


  $('#finishcall').on('click', () => {
    closeCall()
  })

})


const closeCall = () => {
  isStarted = false
  call = {}
  myStream.getTracks().forEach(function(track) {
    track.stop();
  });

  $('#finishcall').hide()
  $('#startcall').show()      

  broadcastData('/finish', {
    call_id: chat_id || Number($('.chat-box').data('chat')),
    current_user_id: current_user_id || Number($('.chat-box').data('user')),
  })
}
const initCall = (newCall = false) => {
  console.log(call, chat_id)
  call.id = chat_id || Number($('.chat-box').data('chat'))
  isStarted = true

  $('#startcall').prop('disabled', true);
  broadcastData('/new', {
    call_id: chat_id || Number($('.chat-box').data('chat')),
    current_user_id: current_user_id || Number($('.chat-box').data('user')),
    new_call: newCall
  })

  init()
}
