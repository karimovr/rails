$(document).ready(function(){
    $('form.new_post').submit(function(){
        console.log('Отправка формы');
        var post_title = $(this).find('#post_title').val();
        if (post_title == '' || post_title == undefined) {
            alert('Введите название поста');
            return false;
        };
    })
});