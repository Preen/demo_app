$(document).ready(function() {

});

function miniMizeActivation(element) {
    $("#mize-" + element).click(function() {
        $("#minimize-" + element).slideUp();
        slideDownContent(element);
    });
}

function slideDownContent(element) {
    $("#mize-" + element).text('Visa').attr('id', 'visa-' + element);
    $("#visa-" + element).click(function() {
        $("#minimize-" + element).slideDown();
        slideUpAgain(element);
    });
}

function slideUpAgain(element) {
    var parentElement = $("#visa-" + element).parent();
    $("#mize-" + element).remove();
    $("#visa-" + element).remove();
    parentElement.prepend("<span id='mize-" + element + "' class='right' style='cursor: pointer; padding-top: 6px;'>Minimera</span>");
    miniMizeActivation(element)
}

function activateTabs(element) {
    $("#" + element).tabs();
}