$(document).on('turbolinks:load', function() {
  // books要素再構築
  var createBookElement = function(book) {
    authorsName = ""
    book.authors.forEach(function(author) {
      authorsName += `${author.name}／`
    })
    authorsName = authorsName.slice(0, -1);
    var book =  `<div class='book'>
                  <div class='book__left'>
                    <div class='book__left__image'>
                      <img src='${book.image}', alt='${book.title}の画像' />
                    </div>
                  </div>
                  <div class='book__right'>
                    <div class='book__right__info'>
                      <div class='book__right__info--title'>
                        <span class='caption'>書籍名</span>
                        <span class='content'>
                          ${book.title}
                        </span>
                      </div>
                      <div class='book__right__info--author'>
                        <span class='caption'>著者</span>
                        <span class='content'>
                          ${authorsName}
                        </span>
                      </div>
                      <div class='book__right__info--publisher'>
                        <span class='caption'>出版社</span>
                        <span class='content'>
                          ${book.publisher.name}
                        </span>
                      </div>
                      <div class='book__right__info--isbn'>
                        <span class='caption'>ISBN</span>
                        <span class='content'>
                          ${book.isbn}
                        </span>
                      </div>
                    </div>
                    <div class='book__right__option'>
                    </div>
                  </div>
                </div>
                `;
    return book;
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
    .done(function(results) {
      console.log(results);
      var rootElement = $('.books');
      rootElement.empty();
      if (results.length > 0) {
        // resultでbooks要素を再構築
        results.forEach(function(book) {
          var bookElement = createBookElement(book);
          rootElement.append(bookElement);
        })
      }
      else {
        rootElement.append('該当なし');
      }
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
})
