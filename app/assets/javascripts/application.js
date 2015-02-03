//= require jquery
//= require jquery_ujs
//= require_tree .

jQuery(function($) {
    $('tr[data-link]').click(function() {
        window.location = this.dataset.link
    })
    $('td[data-link]').click(function() {
        window.location = this.dataset.link
    })
})
