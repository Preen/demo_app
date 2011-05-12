//SETTING UP OUR POPUP
//0 means disabled; 1 means enabled;
var popupStatus = 0;

//loading popup with jQuery magic!
function loadPopup() {
//loads popup only if it is disabled
    if (popupStatus == 0) {
        $("#backgroundPopup").css({
            "opacity": "0.7"
        });
        $("#backgroundPopup").fadeIn("slow");
        $("#popup").fadeIn("slow");
        popupStatus = 1;
    }
}

//disabling popup with jQuery magic!
function disablePopup() {
//disables popup only if it is enabled
    if (popupStatus == 1) {
        $("#backgroundPopup").fadeOut("slow");
        $("#popup").fadeOut("slow");
        $("#popupContent").html('');
        popupStatus = 0;
    }
}

//centering popup
function centerPopup() {
//request data for centering
    var windowWidth = document.documentElement.clientWidth;
    var windowHeight = document.documentElement.clientHeight;
    var popupHeight = $("#popup").height();
    var popupWidth = $("#popup").width();
//centering
    $("#popup").css({
        "position": "absolute",
        "top": windowHeight / 2 - popupHeight / 2,
        "left": windowWidth / 2 - popupWidth / 2
    });
//only need force for IE6

    $("#backgroundPopup").css({
        "height": windowHeight
    });

}

$(document).ready(function() {

    $.fn.qtip.styles.mystyle = { // Last part is the name of the style
        width: 250,
        color: 'black',
        border: {
            width: 5,
            radius: 5,
            color: '#99ffff'
        },
        tip: 'topLeft',
        name: 'light' // Inherit the rest of the attributes from the preset dark style
    };

//CLOSING POPUP
//Click the x event!
    $("#popupClose").click(function() {
        disablePopup();
    });
//Click out event!
    $("#backgroundPopup").click(function() {
        disablePopup();
    });
//Press Escape event!
//Press Escape event!
    $(document).keypress(function(e) {
        if (e.keyCode == 27 && popupStatus == 1) {
            disablePopup();
        }
    });


    modalWindow('.login', 'Logga in', '');
    modalWindow('.register', 'Logga in', '');

    $("select, input:checkbox, input:radio, input:file").uniform();

});

//TOOLTIP

function tooltip(element, info, style) {
    $(element).qtip({
        content: info,
        title: 'hejsan!',
        style: style,
        show: { delay: 0 },
        api: { onShow: function() {
            $(this.elements.content).addClass('tipActivated');
        },
            onHide: function() {
                $(this.elements.content).html(info);
                $(this.elements.content).removeClass('tipActivated');
            }}
    });
}


function modalWindow(element, title, content) {
    if ($('#qtip-blanket').length == 0) {
        $('#qtip-blanket').remove();
    }
    $('<div id="qtip-blanket">')
            .css({
                     position: 'absolute',
                     top: $(document).scrollTop(), // Use document scrollTop so it's on-screen even if the window is scrolled
                     left: 0,
                     height: $(document).height(), // Span the full document height...
                     width: '100%', // ...and full width

                     opacity: 0.7, // Make it slightly transparent
                     backgroundColor: 'black',
                     zIndex: 5000  // Make sure the zIndex is below 6000 to keep it below tooltips!
                 })
            .appendTo(document.body)// Append to the document body
            .hide(); // Hide it initially


    $(element).qtip(
    {
        content: {
            title: {
                text: title,
                button: 'Stäng'
            },
            text: content
        },
        position: {
            target: $(document.body), // Position it via the document body...
            corner: 'center' // ...at the center of the viewport
        },
        show: {
            when: 'click', // Show it on click
            solo: true // And hide all other tooltips
        },
        hide: false,
        style: {
            width: { min: 350 },
            padding: '14px',
            border: {
                width: 9,
                radius: 9,
                color: '#666666'
            },
            name: 'light'
        },
        api: {
            beforeShow: function() {
                $(this.elements.content).addClass('tipActivated');
                $(this.elements.content).html('');
                $('#qtip-blanket').fadeIn(this.options.hide.effect.length);
                // Fade in the modal "blanket" using the defined show speed

            },
            beforeHide: function() {
                // Fade out the modal "blanket" using the defined hide speed

            },
            onShow: function() {


            },
            onHide: function() {
                $('#qtip-blanket').fadeOut(this.options.hide.effect.length);
            }
        }
    });
}