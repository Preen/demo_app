$(document).ready(function() {

    var category = $('#category_id');
    category.change(function() {
        var catValue = category.val();


        $.getJSON('/finder/products/' + catValue + ".json", function(data) {

            var select = $('#prod_id');
            var options = select.attr('options');
            $('option', select).remove();

            $.each(data, function(index, array) {
                options[options.length] = new Option(array['product']['title'], array['product']['id']);
            });

            $.uniform.update(select);

            sizes();

        });
    });

    category.val("");
    $.uniform.update(category);

    $('#limit option:last-child').attr("selected", "selected");
    $.uniform.update('#limit');

});


function sizes() {

    var productVal = $('#prod_id').val();

    $.getJSON('/finder/productSizes/' + productVal + ".json", function(data) {

        var select = $('#si_id');
        var options = select.attr('options');
        $('option', select).remove();

        $.each(data, function(index, array) {
            options[options.length] = new Option(array['product_size']['productSize'], array['product_size']['id']);
        });

        $.uniform.update(select);

        amount()

    });

    sizeActivation();

}

function sizeActivation() {

    $('#prod_id').change(function() {
        sizes();
    });

}

function amount() {
        var amount = $('<select>').attr('id', 'amount').appendTo("#amountSpan");
        amount.css('display', 'none');
        amount.fadeIn();

        var howMany = [1,2,3,4,5,10,15,20];

        var select = $('#amount');
        var options = select.attr('options');
        $('option', select).remove();

        $(howMany).each(function(index, value){
          options[options.length] = new Option(value, value);
        });

        $.uniform.update(select);
}







