$(function () {
  $('#company_logo').change(function () {
    var input = this;
    var url = $(this).val();
    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
    if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_logo').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
    else {
      $('#img_logo').attr('src', '/assets/default-image.jpg');
    }
  });

  $('#company_banner').change(function () {
    var input = this;
    var url = $(this).val();
    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
    if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_banner').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
    else {
      $('#img_banner').attr('src', '/assets/default-image.jpg');
    }
  });

  $('#employee_avatar').change(function () {
    var input = this;
    var url = $(this).val();
    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
    if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_avatar').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
    else {
      $('#img_avatar').attr('src', '/assets/default-image.jpg');
    }
  });

  $('#user_avatar').change(function () {
    var input = this;
    var url = $(this).val();
    var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
    if (input.files && input.files[0] && (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#avatar_profile').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
    else {
      $('#avatar_profile').attr('src', '/assets/fallback/default-user.png');
    }
  });

});
