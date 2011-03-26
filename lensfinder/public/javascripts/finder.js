$(document).ready(function() {

    var category = $('#category_id');
    category.change(function() {
        var catValue = category.val();


        $.getJSON('/finder/products/' + catValue + ".json", function(data) {

            if (!$('#product').length) {
                var product = $('<select>').attr('id', 'product').appendTo("#productsSpan");
                product.css('display', 'none');
                product.fadeIn();
            }


            var select = $('#product');
            var options = select.attr('options');
            $('option', select).remove();

            $.each(data, function(index, array) {
                options[options.length] = new Option(array['product']['title'], array['product']['id']);
            });

            sizes();

        });
    });

});


function sizes(){

    var productVal = $('#product').val();

        $.getJSON('/finder/sizes/' + productVal + ".json", function(data) {

            if (!$('#sizes').length) {
                var size = $('<select>').attr('id', 'sizes').appendTo("#sizesSpan");
                size.css('display', 'none');
                size.fadeIn();
            }


            var select = $('#sizes');
            var options = select.attr('options');
            $('option', select).remove();

            $.each(data, function(index, array) {
                options[options.length] = new Option(array['size']['size'], array['size']['id']);
            });


        });

    sizeActivation();

}

function sizeActivation(){

    $('#product').change(function(){
      sizes();
    });

}