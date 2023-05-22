$(document).on('click', '.notion-title', function() {
  const notionId = $(this).data('id');
  $.ajax({
    type: 'GET',
    url: `/notions/${notionId}`,
    dataType: 'json',
  })
  .done(function(notion) {
    $('#notion-content').empty().append(notion.content);
  })
  .fail(function() {
    alert('エラーが発生しました');
  });
});
