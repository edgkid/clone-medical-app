import consumer from "./consumer"
import moment from 'moment'

var current_user_id;
var chat_id;
consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    // mandar a los usuarios que se conecto el medico
    console.log('connected')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if(data.action == 'new') {
      if($(`tr#${data.user.id}`).length === 0) {
        $( '#doctor-table' ).append(`
          <tr  id="${data.user.id}">
            <td>
              <p style="font-family: FuturaStd Medium">${data.user.speciality}</p>
            </td>
            <td>
              <p style="font-family: FuturaStd Medium">
                ${data.user.full_name}
              </p>
            </td>
            <td>
              <i class="material-icons green-text"> brightness_1 </i>
            <td>
              ${
                $('#doctor-table').data('patient-plan-status') == 'APROBADO' && Number($('#doctor-table').data('patient-plan-count')) > 0 ?
                `<a class="modal-trigger" style="color:#039BE5;" href="#idModalAlertaDeCosumo" onclick="setDataModalCounAppointment('${$('#doctor-table').data('patient')}%${data.user.doctor_id}%true')">Iniciar Chat</a>` 
                :
                `<a class="modal-trigger" style="color:#039BE5;" href="#idModalAlertaDeCosumo" onclick="setDataModalCounAppointment('${$('#doctor-table').data('patient')}%${data.user.doctor_id}%false')">Iniciar Chat</a>` 
              }
            </td>
          </tr> 
        `)
      }   
    } else if(data.action == 'remove') {
      $( `tr#${data.user}` ).remove();
    } else if(data.action == 'new_message') {
      let message = JSON.parse(data.message)
      let content = ''

      console.log(message)

      if(message.chat_id !== chat_id)
        return

      if(message.content)
        content = message.content
      else if(message.image_url)
        content = `
          <a href="${message.image_url}"><img class="img-chat responsive-img" src="${message.image_url}"></a>
        `
      else 
        content = 'Error al mostrar contenido'

      $('#messages').append(`
        <div id="msg" style="display: flow-root">
          <div 
            class="message "
            style="
              padding: 1px 30px;
              margin: 10px 0;
              background: white;

              ${message.user_id === current_user_id ? 'text-align: right; float: right; border-radius: 10px 0px 30px 10px;' : 'text-align: left; float: left; border-radius:   0px 10px 10px 30px;'}
              
              
              ${/*message.user == 'patient' && user == 'patient' ? 'text-align: right; float: right; border-radius: 10px 0px 30px 10px;' : '' */''}
              ${/*message.user == 'doctor' && user == 'doctor' ? '  text-align: right; float: right; border-radius: 10px 0px 30px 10px;' : '' */''}
              ${/*message.user == 'patient' && user == 'doctor' ? ' text-align: left; float: left; border-radius:   0px 10px 10px 30px;' : '' */''}
              ${/*message.user == 'doctor' && user == 'patient' ? ' text-align: left; float: left; border-radius:   0px 10px 10px 30px;' : '' */''}
            "
          >
            <div class="message-content">
                ${ content }
            </div>
            <div 
                class="message-hour"
                style=" color: #9c9a9a;
                        font-size: 8pt;
                "
            >
              <span>${ moment(message.created_at, '').format('DD/MM/YYYY h:mm a') }</span>
            </div>
          </div>
        </div>
      `)
      // Called when there's incoming data on the websocket for this channel
      const messagesDiv = document.querySelector("#messages") 
      messagesDiv.scrollTo(0, messagesDiv.scrollHeight)
    }
  }
});

var submit_messages;
$(document).on('turbolinks:load', function () {
  if(!document.getElementById('chat-box'))
    return

  const messagesDiv = document.querySelector("#messages") 
  messagesDiv.scrollTo(0, messagesDiv.scrollHeight)

  current_user_id = Number($('.chat-box').data('user'))
  chat_id = Number($('.chat-box').data('chat'))

  submit_messages()

  $('#message_image').on('change', function (event) {
    if(event.target.files.length > 0){
      $('#submit-button').click()
      event.target.value = ''
      event.preventDefault()
    }
  })
})

submit_messages = function(params) {
  $('#messages_content').on('keydown', function (event) {
    if(event.keyCode == 13){
      $('#submit-button').click()
      event.target.value = ''
      event.preventDefault()
      
    }

    $('#submit-button').on('click', function(event) {
      setTimeout(function() {
        $('#messages_content').val('')
      }, 100);
    });

  })
}

