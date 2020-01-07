$(document).on('turbolinks:load', function() {
  var getBookContent = function(book, infoItem){
    return book.find(`${infoItem} .content`).text().trim();
  };
  var disbleRegisterButton = function(book) {
    var element = book.find('.book__right__option__add');
    element.removeClass('book__right__option__add');
    element.addClass('book__right__option__disable');
    element.text('書架に登録済みです');
  };
  var regitserBookShelf = function(book) {
    var isbn = getBookContent(book, '.book__right__info--isbn');
    var title = getBookContent(book, '.book__right__info--title');
    var author = getBookContent(book, '.book__right__info--author');
    var publisher = getBookContent(book, '.book__right__info--publisher');
    var image = book.find('.book__left__image img').attr('src');
    var link_url = book.find('.book__right__option__info').attr('url');
    $.ajax({
      type:     'POST',
      url:      '/books',
      data: {
        isbn:   isbn,
        title:  title,
        author: author,
        publisher:  publisher,
        image:      image,
        link_url:   link_url
      },
      dataType: 'json'
    })
    .done(function() {
      console.log("書架への追加に成功しました。");
      disbleRegisterButton(book);
    })
    .fail(function() {
      console.log("書架への追加に失敗しました。");
    });
  };
  $('.book__right__option__add').on('click', function() {
    var rootElement = $(this).closest('.book');
    regitserBookShelf(rootElement);
  });
});
