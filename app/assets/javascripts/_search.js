$(document).on('turbolinks:load', function() {
  // books要素再構築
  var restructureBooksTreeElement = function(results) {
    // ToDo
  }
  // インクリメンタルサーチ実行
  var execIncrementalSearch = function () { 
    var inputTitle  = $('#book_title_shelf').val();
    var inputAuthor = $('#book_author_shelf').val();
    var inputIsbn   = $('#book_isbn_shelf').val();
    $.ajax({
      type:     'GET',
      url:      '/api/books',
      data: {
        title:  inputTitle,
        author: inputAuthor,
        isbn:   inputIsbn
      },
      dataType: 'json'
    })
    .done(function(result) {
      console.log(result);
      // resultでbooks要素を再構築
    })
    .fail(function(data) {
      console.log('failed incremental search');
    })
  }
  // 書架から検索 文字入力 callback
  $('.menu__search-form__field__input__shelf').on('keyup', function(e) {
    e.preventDefault();
    execIncrementalSearch();
  })
  // 楽天ブックス検索 実行
  // var execRackutenBooksSearch = function () { 
  //   var inputTitle  = $('#book_title_external').val();
  //   var inputAuthor = $('#book_author_external').val();
  //   var inputIsbn   = $('#book_isbn_external').val();
  //   console.log('title: ' + inputTitle);
  //   console.log('author: ' + inputAuthor);
  //   console.log('isbn: ' + inputIsbn);
  //   $.get('https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?', {
  //     applicationId: "1011752311455155114",
  //     format: 'json',
  //     title:  inputTitle,
  //     author: inputAuthor,
  //     isbn:   inputIsbn,
  //     booksGenreId: '001'
  //   }, function(results) {
  //     console.log(results);
  //   })
  // }
  // // 外部サイトから書籍情報を検索
  // $('#external-find-btn').on('click', function(e) {
  //   e.preventDefault();
  //   execRackutenBooksSearch();
  // })
})
