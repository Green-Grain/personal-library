$(document).on('turbolinks:load', function() {
  var getBookContent = function(className, id){
    return $(className + id).find('.content').text().trim();
  };
  var disbleRegisterButton = function(candidateId) {
    var element = $('.book__right__option__add' + candidateId);
    element.removeClass('book__right__option__add');
    element.addClass('book__right__option__disable');
    element.text('書架に登録済みです');
  };
  var regitserBookShelf = function(candidateId) {
    var bookId = `#${candidateId}`;
    var isbn = getBookContent('.book__right__info--isbn', bookId);
    var title = getBookContent('.book__right__info--title', bookId);
    var author = getBookContent('.book__right__info--author', bookId);
    var publisher = getBookContent('.book__right__info--publisher', bookId);
    var image = $('.book__left__image' + bookId).find('img').attr('src');
    var link_url = $('.book__right__option__info'+ bookId).attr('url');
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
      disbleRegisterButton(bookId);
    })
    .fail(function() {
      console.log("書架への追加に失敗しました。");
    });
  };
  $('.book__right__option__add').on('click', function() {
    var id = $(this).attr('id');
    regitserBookShelf(id);
  });
});
