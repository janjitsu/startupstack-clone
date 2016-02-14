#####################################################################################
#                                                                                   #
# Function Declarations                                                             #
#                                                                                   #
#####################################################################################

# Make itens of a list add "selected" class when clicked
make_list_selectable = (list) ->
    $(list).find('li').click ->
        $(this).toggleClass("selected")
window.make_list_selectable = make_list_selectable

# Finds all selected tags values
get_selected_tags = (form) ->
    values = []
    $(form).find('.selected').each ->
        values.push $(this).html()
    return values
window.get_selected_tags = get_selected_tags
        
#####################################################################################
#                                                                                   #
# Events                                                                            #
#                                                                                   #
#####################################################################################

# get all lists and make them selectable
$(document).ready ->
    $('#tag-select').find('ul').each ->
        make_list_selectable(this)

# appends selected tags to get url before submit
$(document).on 'ajax:beforeSend','#search-form',(event,xhr,settings) ->
    settings.url += "&tags=" + get_selected_tags(event.currentTarget)

# show search results
$(document).on 'ajax:success','#search-form',(event,xhr,settings) ->
    $(".search-result").html(xhr)

