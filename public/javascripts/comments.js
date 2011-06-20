$(document).ready(function() {
    var newComment = $('#nComment');
    showContent(newComment);
});


function showContent(newComment) {
    newComment.click(function() {
        newComment.remove();
        var newUser = $('#new_user');
        var comment = $('#new_comment');
        var closeComment = $('<span class="smallHeader" id="closeComment">Stäng</span>');
        $(closeComment).insertAfter('#pager');
        var hideMe = $('#closeComment');
        if (!comment.length == 0) {
            comment.slideDown();
            hideComment(hideMe, comment);
        }
        else {

        }

        if (!newUser.length == 0) {
            newUser.slideDown();
            hideComment(hideMe, newUser);
        }
    });
}


function hideComment(action, box) {
    action.click(function() {
        box.hide();
        action.remove();
        var myNewComment = $('<span class="smallHeader" id="nComment">Ny kommentar</span>');
        $(myNewComment).insertAfter('#pager');
        var newComment = $('#nComment');
        showContent(newComment);
    });
}