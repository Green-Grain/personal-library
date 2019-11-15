$(document).on('turbolinks:load', function() {
  // インクリメンタルサーチ実行
  var execIncrementalSearch = function () { 
    var inputTitle  = $('#title_input').val();
    var inputAuthor = $('#author_input').val();
    var inputIsbn   = $('#isbn_input').val();
    $.ajax({
      type:     'GET',
      url:      '/api/books',
      data: {
        title:  inputTitle,
        author: inputAuthor,
        isbn:   inputIsbn
      },
      dataType:     'json',
      // processData:  true,
      // contentType:  false
    })
    .done(function(result) {
      console.log(result);
    })
    .fail(function(data) {
      
    })
  }
  // title 文字入力 callback
  $('.menu__search-form__field__input__title').on('keyup', function(e) {
    e.preventDefault();
    execIncrementalSearch();
  })
  // author 文字入力 callback
  $('.menu__search-form__field__input__author').on('keyup', function(e) {
    e.preventDefault();
    execIncrementalSearch();
  })
  // isbn 文字入力 callback
  $('.menu__search-form__field__input__isbn').on('keyup', function(e) {
    e.preventDefault();
    execIncrementalSearch();
  })

})