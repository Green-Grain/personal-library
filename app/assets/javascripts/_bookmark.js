$(document).on('turbolinks:load', function() {
  var disbleRegisterButton = function(book) {
    var element = book.find('.book__right__option__bookmark--enable');
    element.removeClass('book__right__option__bookmark--enable');
    element.addClass('book__right__option__bookmark--disable');
    element.text('My書架に登録済み');
  };
  var regitserBookmark = function(book) {
    var bookId = book.attr('id');
    $.ajax({
      type: 'POST',
      url:  `/books/${bookId}/add_shelf`,
      data: {
        id:   bookId
      },
      dataType: 'json'
    })
    .done(function() {
      console.log("My書架への追加に成功しました。");
      disbleRegisterButton(book);
    })
    .fail(function() {
      console.log("My書架への追加に失敗しました。");
    });
  };
  $('.book__right__option__bookmark--enable').on('click', function() {
    var rootElement = $(this).closest('.book');
    regitserBookmark(rootElement);
  });
});
