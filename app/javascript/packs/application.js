// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'materialize-css/dist/js/materialize'
import "channels"
import "chartkick/chart.js"
import "datatables.net-responsive-dt"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on('turbolinks:load', function () {
    console.log('ok')
  
    $('#DataTableId').DataTable({
      responsive: true,
      language: {
          "decimal": "",
          "emptyTable": "No se encontraron registros",
          "info": "Mostrando _START_ de _END_ / _TOTAL_ Registros",
          "infoEmpty": "Mostrando 0 to 0 of 0 Entradas",
          "infoFiltered": "(Filtrado de _MAX_ total registros)",
          "infoPostFix": "",
          "thousands": ",",
          //"lengthMenu": "Mostrar _MENU_ Registros",
          "lengthMenu": "",
          "loadingRecords": "Cargando...",
          "processing": "Procesando...",
          "search": "Buscar:",
          "zeroRecords": "No se encontraron registros....",
          "paginate": {
              "first": "Primero",
              "last": "Ultimo",
              "next": "Siguiente",
              "previous": "Anterior"
          }
      },
      "pageLength": 10
    });
})

window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js').then(registration => {
      console.log('ServiceWorker registered: ', registration);
  
      var serviceWorker;
      if (registration.installing) {
        serviceWorker = registration.installing;
        console.log('Service worker installing.');
      } else if (registration.waiting) {
        serviceWorker = registration.waiting;
        console.log('Service worker installed & waiting.');
      } else if (registration.active) {
        serviceWorker = registration.active;
        console.log('Service worker active.');
      }
    }).catch(registrationError => {
      console.log('Service worker registration failed: ', registrationError);
    });


    $(document).ready(function(){
      var elems = document.querySelectorAll('.sidenav');
      var instances = M.Sidenav.init(elems, {});   
    });
  });
  