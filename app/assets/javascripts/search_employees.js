//= require jquery.dataTables.min

// DataTable
var table_routes = $('#data-employees').DataTable({
  "language": {
    "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Vietnamese.json"
  },
  lengthMenu: [
    [5, 10, 25, -1],
    [5, 10, 25, "Tất cả"]
  ],
});
table_routes.destroy();
