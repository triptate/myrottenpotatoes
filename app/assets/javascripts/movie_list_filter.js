var MovieListFilter = {
  
  filter_adult: function() {
    // 'this' is *unwrapped* element that received event (checkbox)
    if ($(this).is(':checked')) {
      $('tr.adult').hide();
    } else {
      $('tr.adult').show();
    };
  },
  
  setup: function() {
    // construct checkbox with label
    var labelAndCheckbox = $('<label for="filter">Parental Filter</label>Show only movies suitable for children' +
                              '<input id="filter" name="filter" type="checkbox" />' );
    labelAndCheckbox.insertBefore('#rating_search');
    $('#filter').change(MovieListFilter.filter_adult);
  }

};

$(MovieListFilter.setup);                             // Javascript won't run on initial page load without this
$(document).on('page:load', MovieListFilter.setup);   // Javascript won't run on new page loads because of Turbolinks without this