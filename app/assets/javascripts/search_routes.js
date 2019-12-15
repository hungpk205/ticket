//= require jquery.dataTables.min
$(document).ready(function () {
  // DataTable
  var table = $('#data-routes').DataTable({
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Vietnamese.json"
    },
    lengthMenu: [
      [5, 10, 25, -1],
      [5, 10, 25, "Tất cả"]
    ],
  });
  table.destroy();
});
