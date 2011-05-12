$(document).ready(function() {
    $('#limit').val(3);
    $.uniform.update('#si_id');
    $.uniform.update('#limit');
    $('#search').trigger('submit');
});