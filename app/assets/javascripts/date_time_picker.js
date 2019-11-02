$(document).ready(function () {
  $('.trip_start_time').datepicker({
    format: "%d-%m-%Y %H:%M",
    startView: 'months',
    startDate: '+1d',
  });
});
